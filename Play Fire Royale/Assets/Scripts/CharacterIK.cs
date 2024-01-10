// DecompilerFi decompiler from Assembly-CSharp.dll class: CharacterIK
// SourcesPostProcessor 
using System;
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public struct CharacterIK
	{
		private struct SwitchedWeapon
		{
			public Transform OriginalBone;

			public Transform SwitchedBone;

			public Transform Weapon;

			public Vector3 OriginalLocalPosition;

			public Quaternion OriginalLocalRotation;

			public Vector3 OriginalLocalScale;

			public bool NeedsToRestoreLeftHand;

			public Vector3 OriginalLeftHand;

			public Vector3 OriginalLeftHandAim;

			public Vector3 OriginalLeftHandCrouch;

			public Vector3 OriginalLeftHandLowCover;

			public Vector3 OriginalLeftHandTallCover;
		}

		public Transform Sight;

		private CharacterMotor _motor;

		private Animator _animator;

		private Transform[] _bones;

		private Dictionary<Transform, Transform> _mirrors;

		private Transform[] _left;

		private Transform[] _right;

		private Transform[] _middle;

		private IKBone[] _chain;

		private int[] _leftIndices;

		private int[] _rightIndices;

		private int[] _middleIndices;

		private bool _areArmsComingOutOfNeck;

		private IK _aimIK;

		private IK _recoilIK;

		private IK _leftHandIK;

		private IK _rightHandIK;

		private IK _sightIK;

		private SwitchedWeapon _leftSwitchedWeapon;

		private SwitchedWeapon _rightSwitchedWeapon;

		private Quaternion _aim;

		private float _aimDistance;

		private Quaternion _relativeAim;

		private float _relativeAimDistance;

		private Quaternion _preciseHorizontalRotation;

		private float _leftHandAimIntensity;

		private float _armAimIntensity;

		private float _previousArmAimTargetIntensity;

		private float _throwAimIntensity;

		private float _headAimIntensity;

		private Vector3 _lastHit;

		private float _lastHitStrength;

		private float _lastHitWait;

		private float _meleeLowering;

		public bool HasSwitchedHands => _rightSwitchedWeapon.Weapon != null || _leftSwitchedWeapon.Weapon != null;

		public bool IsAimingArms => _armAimIntensity > 0.9f;

		public Transform GetBone(HumanBodyBones bone)
		{
			return _bones[(int)bone];
		}

		public void Setup(CharacterMotor motor)
		{
			_motor = motor;
			_animator = motor.GetComponent<Animator>();
			_aim = Quaternion.identity;
			_relativeAim = Quaternion.identity;
			_preciseHorizontalRotation = Quaternion.identity;
			_aimIK = new IK();
			_recoilIK = new IK();
			_leftHandIK = new IK();
			_rightHandIK = new IK();
			_sightIK = new IK();
			_mirrors = new Dictionary<Transform, Transform>();
			int num = 0;
			for (int i = 0; i < 55; i++)
			{
				if (i > num)
				{
					num = i;
				}
			}
			_bones = new Transform[num + 1];
			for (int j = 0; j < 55; j++)
			{
				_bones[j] = _animator.GetBoneTransform((HumanBodyBones)j);
			}
			for (int k = 0; k < 55; k++)
			{
				HumanBodyBones humanBodyBones = (HumanBodyBones)k;
				string text = humanBodyBones.ToString();
				int num2 = k;
				if (text.StartsWith("Left"))
				{
					int num3 = (int)Enum.Parse(typeof(HumanBodyBones), text.Replace("Left", "Right"));
					if (!(_bones[num2] == null) && !(_bones[num3] == null))
					{
						_mirrors[_bones[num2]] = _bones[num3];
						_mirrors[_bones[num3]] = _bones[num2];
					}
				}
				else if (!text.StartsWith("Right") && _bones[num2] != null)
				{
					_mirrors[_bones[num2]] = _bones[num2];
				}
			}
			Transform transform = _bones[10];
			for (int l = 0; l < transform.childCount; l++)
			{
				Transform child = transform.GetChild(l);
				if (child.name == "Look" || child.name == "Sight" || child.name == "look" || child.name == "sight")
				{
					Sight = child;
					break;
				}
				for (int m = 0; m < child.childCount; m++)
				{
					Transform child2 = child.GetChild(m);
					if (child2.name == "Look" || child2.name == "Sight" || child2.name == "look" || child2.name == "sight")
					{
						Sight = child2;
						break;
					}
				}
			}
			_left = findChain(_bones[15]);
			_right = findChain(_bones[16]);
			_middle = findChain(_bones[10]);
			_leftIndices = findIndices(_left);
			_rightIndices = findIndices(_right);
			_middleIndices = findIndices(_middle);
			_areArmsComingOutOfNeck = (findIndex(_left, HumanBodyBones.Neck) >= 0 || findIndex(_right, HumanBodyBones.Neck) >= 0);
		}

		public void Mirror(Transform right, Transform left, bool preferSwapping)
		{
			if (preferSwapping && right != null && left != null)
			{
				Vector3 localPosition = right.localPosition;
				Quaternion localRotation = right.localRotation;
				Vector3 localScale = right.localScale;
				Transform parent = right.parent;
				Vector3 localPosition2 = left.localPosition;
				Quaternion localRotation2 = left.localRotation;
				Vector3 localScale2 = left.localScale;
				Transform parent2 = left.parent;
				mirror(ref _rightSwitchedWeapon, right, parent2, localPosition2, localRotation2, localScale2);
				mirror(ref _leftSwitchedWeapon, left, parent, localPosition, localRotation, localScale);
				swapLeftHand(ref _leftSwitchedWeapon, ref _rightSwitchedWeapon);
			}
			else
			{
				if (right != null)
				{
					calculateMirror(ref _rightSwitchedWeapon, right);
				}
				else
				{
					unmirror(ref _rightSwitchedWeapon);
				}
				if (left != null)
				{
					calculateMirror(ref _leftSwitchedWeapon, left);
				}
				else
				{
					unmirror(ref _leftSwitchedWeapon);
				}
			}
		}

		public void Unmirror()
		{
			unmirror(ref _rightSwitchedWeapon);
			unmirror(ref _leftSwitchedWeapon);
		}

		public void Hit(Vector3 normal, float strength, float wait)
		{
			if (!(_lastHitWait > float.Epsilon))
			{
				_lastHit = normal;
				_lastHitStrength = 1f;
				_lastHitWait = wait;
			}
		}

		public void Skip()
		{
			_headAimIntensity = 0f;
			_throwAimIntensity = 0f;
			_leftHandAimIntensity = 0f;
			_armAimIntensity = 0f;
		}

		public void ImmediateArmAim()
		{
			_previousArmAimTargetIntensity = 1f;
			_armAimIntensity = 1f;
		}

		public void Update(IKConfig config)
		{
			updateHeadAimIntennsity();
			updateThrowAimIntensity();
			updateArmAimIntennsity();
			updateLeftHandIntensity(config.Gun);
			BaseGun gun = config.Gun;
			Transform transform = (!(gun != null)) ? null : gun.transform.Find("Aim");
			Cover cover = _motor.Cover;
			float distance = 0f;
			if (CameraManager.Main != null && CameraManager.Main.transform != null)
			{
				distance = Vector3.Distance(_motor.transform.position, CameraManager.Main.transform.position);
			}
			float delay = config.Delay.Get(distance);
			if (_lastHitWait > float.Epsilon)
			{
				_lastHitWait -= Time.deltaTime;
			}
			if (_lastHitStrength > float.Epsilon)
			{
				if (config.HitBone != null)
				{
					float num = Vector3.Dot(-config.HitBone.transform.forward, _lastHit) * 30f;
					float num2 = Vector3.Dot(config.HitBone.transform.right, _lastHit) * 30f;
					Quaternion lhs = Quaternion.Euler(num * _lastHitStrength, 0f, num2 * _lastHitStrength);
					config.HitBone.localRotation = lhs * config.HitBone.localRotation;
				}
				_lastHitStrength -= Time.deltaTime * 5f;
			}
			if (_motor.IsPerformingMelee)
			{
				Util.Lerp(ref _meleeLowering, Mathf.Clamp(_motor.VerticalMeleeAngle, -30f, 40f), 6f);
			}
			else
			{
				Util.Lerp(ref _meleeLowering, 0f, 6f);
			}
			if (_meleeLowering > 1f || _meleeLowering < -1f)
			{
				Transform transform2 = _bones[7];
				if (transform2 != null)
				{
					transform2.rotation = Quaternion.AngleAxis(_meleeLowering, _motor.transform.right) * transform2.rotation;
				}
			}
			Vector3 accurateAimOrigin = _motor.AccurateAimOrigin;
			if (config.TurnImmediately)
			{
				_aim = Quaternion.FromToRotation(Vector3.forward, config.BodyTarget - accurateAimOrigin);
				_aimDistance = Vector3.Distance(config.BodyTarget, accurateAimOrigin);
			}
			else
			{
				Util.Lerp(ref _aim, Quaternion.FromToRotation(Vector3.forward, config.BodyTarget - accurateAimOrigin), 4f);
				Util.Lerp(ref _aimDistance, Vector3.Distance(config.BodyTarget, accurateAimOrigin), 4f);
			}
			float num3 = (!_motor.IsZooming) ? 1f : 4f;
			Vector3 vector = accurateAimOrigin + _aim * Vector3.forward * _aimDistance;
			Vector3 vector2 = config.AimTarget;
			bool flag = true;
			if (gun != null && gun.HasRaycastSetup)
			{
				vector2 = gun.RaycastTarget;
				flag = false;
				num3 *= Mathf.Clamp(1f + (Mathf.Abs(_motor.HorizontalRecoil) + Mathf.Abs(_motor.VerticalRecoil)), 1f, 10f);
			}
			if (isExtremeTarget(vector2))
			{
				vector2 = vector;
			}
			Vector3 normalized = (vector - accurateAimOrigin).normalized;
			Vector3 normalized2 = (vector2 - accurateAimOrigin).normalized;
			float target = Vector3.Distance(vector2, accurateAimOrigin);
			Quaternion b = Quaternion.FromToRotation(normalized, normalized2);
			Util.Lerp(ref _relativeAim, Quaternion.Lerp(Quaternion.identity, b, _armAimIntensity), num3);
			Util.Lerp(ref _relativeAimDistance, target, num3);
			Vector3 axis = Util.HorizontalVector(Util.HorizontalAngle(normalized) + 90f);
			Quaternion rotation = (!flag) ? Quaternion.identity : (Quaternion.AngleAxis(0f - _motor.VerticalRecoil, axis) * Quaternion.AngleAxis(_motor.HorizontalRecoil, Vector3.up));
			Vector3 aimTarget = accurateAimOrigin + rotation * (_relativeAim * normalized).normalized * _relativeAimDistance;
			clampAimTarget(ref aimTarget, accurateAimOrigin);
			Vector3 vector3 = aimTarget - accurateAimOrigin;
			float magnitude = vector3.magnitude;
			if (magnitude < 2f)
			{
				aimTarget = accurateAimOrigin + vector3.normalized * 2f;
			}
			Vector3 vector4 = Vector3.zero;
			if (gun != null)
			{
				float num4 = 0f;
				num4 = ((!HasSwitchedHands) ? Vector3.Distance(_bones[12].position, _bones[18].position) : Vector3.Distance(_bones[11].position, _bones[17].position));
				vector4 -= num4 * gun.transform.forward * _motor.VerticalRecoil / 20f;
				vector4 -= num4 * gun.transform.right * _motor.HorizontalRecoil / 20f;
			}
			if (config.RightHand != null && gun != null && vector4.magnitude > 0.01f)
			{
				setIKTarget(_recoilIK, config.RightHand, useMirror: true);
				Vector3 targetPosition;
				if (gun.Type != 0)
				{
					targetPosition = _recoilIK.GetTargetPosition() + vector4 * 0.5f;
					setIKTarget(_recoilIK, _bones[12], useMirror: true);
					buildMainChain(ChainElement.chest, ChainElement.spine, mirror: false);
					_recoilIK.Bones = _chain;
					_recoilIK.UpdateMove(_recoilIK.GetTargetPosition() + vector4 * 0.5f, 0f, 1f, 1, 1);
					setIKTarget(_recoilIK, config.RightHand, useMirror: true);
				}
				else
				{
					targetPosition = _recoilIK.GetTargetPosition() + vector4;
				}
				buildMainChain(ChainElement.lowerArm, ChainElement.shoulder, mirror: false);
				_recoilIK.Bones = _chain;
				_recoilIK.UpdateMove(targetPosition, 0f, 1f, 1, 1);
			}
			int num5;
			if (!(gun != null) || gun.Type == WeaponType.Pistol)
			{
				WeaponDescription equippedWeapon = _motor.EquippedWeapon;
				num5 = ((equippedWeapon.Shield == null) ? 1 : 0);
			}
			else
			{
				num5 = 1;
			}
			bool mirror = (byte)num5 != 0;
			if (transform != null && _armAimIntensity > 0.01f)
			{
				setIKTarget(_aimIK, transform, useMirror: false);
				buildMainChain(ChainElement.shoulder, ChainElement.spine, mirror);
				_aimIK.Bones = _chain;
				_aimIK.UpdateAim(aimTarget, delay, _armAimIntensity * _armAimIntensity, config.MinIterations, config.MaxIterations);
			}
			if (gun != null && _armAimIntensity > 0.01f)
			{
				if (config.IsPrecise)
				{
					Transform transform3 = config.RightHand;
					if (HasSwitchedHands)
					{
						transform3 = ((!_mirrors.ContainsKey(transform3)) ? null : _mirrors[transform3]);
					}
					if (transform3 != null)
					{
						Transform transform4 = (!(gun.Aim != null)) ? gun.transform : gun.Aim.transform;
						Vector3 closestStaticHit = Util.GetClosestStaticHit(gun.Origin, gun.Origin + transform4.forward * gun.Distance, 0f);
						float current = Util.HorizontalAngle(closestStaticHit - transform3.position);
						float target2 = Util.HorizontalAngle(vector2 - transform3.position);
						Quaternion b2 = Quaternion.AngleAxis(Mathf.DeltaAngle(current, target2), Vector3.up);
						Util.Lerp(ref _preciseHorizontalRotation, Quaternion.Lerp(Quaternion.identity, b2, _armAimIntensity), 2f * num3);
						transform3.rotation = _preciseHorizontalRotation * transform3.rotation;
						if (_leftHandAimIntensity > 0.01f)
						{
							transform3 = _bones[15];
							if (HasSwitchedHands)
							{
								transform3 = ((!_mirrors.ContainsKey(transform3)) ? null : _mirrors[transform3]);
							}
							if (transform3 != null)
							{
								transform3.rotation = Quaternion.Lerp(Quaternion.identity, _preciseHorizontalRotation, _leftHandAimIntensity) * transform3.rotation;
							}
						}
					}
				}
				if (!gun.HasRaycastSetup)
				{
					gun.SetupRaycastThisFrame(gun.Origin, config.AimTarget);
				}
			}
			else
			{
				_preciseHorizontalRotation = Quaternion.identity;
			}
			if (gun != null && config.LeftHand != null && _leftHandAimIntensity > 0.01f)
			{
				Transform transform5 = null;
				if (_motor.IsCrouching && gun.LeftHandOverwrite.Crouch != null)
				{
					transform5 = gun.LeftHandOverwrite.Crouch;
				}
				else if (_motor.IsAimingGun)
				{
					transform5 = gun.LeftHandOverwrite.Aim;
				}
				else if (_motor.IsInCover)
				{
					transform5 = ((!_motor.IsInTallCover) ? gun.LeftHandOverwrite.LowCover : gun.LeftHandOverwrite.TallCover);
				}
				if (transform5 == null)
				{
					transform5 = gun.LeftHandDefault;
				}
				if (transform5 != null)
				{
					setIKTarget(_leftHandIK, config.LeftHand, useMirror: true);
					buildSupportChain(ChainElement.lowerArm, ChainElement.shoulder, mirror: false);
					_leftHandIK.Bones = _chain;
					_leftHandIK.UpdateMove(transform5.position, delay, _leftHandAimIntensity, config.MinIterations, config.MaxIterations);
				}
			}
			if (config.Sight != null && _headAimIntensity > 0.01f)
			{
				setIKTarget(_sightIK, config.Sight, useMirror: true);
				if (_areArmsComingOutOfNeck)
				{
					buildMiddleChain(ChainElement.head, ChainElement.head);
				}
				else
				{
					buildMiddleChain(ChainElement.head, ChainElement.neck);
				}
				_sightIK.Bones = _chain;
				_sightIK.UpdateAim(aimTarget, delay, _headAimIntensity, config.MinIterations, config.MaxIterations);
			}
		}

		private void updateThrowAimIntensity()
		{
			float target = 0f;
			if (_motor.IsThrowingGrenade && !_motor.IsInTallCover)
			{
				target = 1f;
			}
			Util.Lerp(ref _throwAimIntensity, target, 6f);
		}

		private void updateArmAimIntennsity()
		{
			if (_motor.IsGettingHit)
			{
				_armAimIntensity = 0f;
				return;
			}
			float num = 0f;
			if (_motor.WasAimingGun && _motor.IsAimingGun && !_motor.IsMovingToCoverOffsetAndCantAim && !_motor.IsSprinting)
			{
				num = 1f;
			}
			if (_motor.IsChangingWeaponOrHasJustChanged)
			{
				num = 0f;
			}
			BaseGun gun = _motor.EquippedWeapon.Gun;
			if (gun != null && _motor.IsPumping)
			{
				num = 0f;
			}
			else if (gun != null && _motor.IsLoadingBullet)
			{
				num = 0f;
			}
			else if (gun != null && _motor.IsLoadingMagazine)
			{
				num = 0f;
			}
			else if (_motor.IsInCover && _motor.IsInCoverOffset)
			{
				num = 1f;
			}
			if (_motor.dontChangeArmAimingJustYet && _previousArmAimTargetIntensity < num)
			{
				num = 0f;
			}
			else
			{
				_previousArmAimTargetIntensity = num;
			}
			if (num > _armAimIntensity)
			{
				if (_motor.wantsToFire && !_motor.IsInCover && !_motor.Weapon.IsNull && _motor.IsEquipped)
				{
					_armAimIntensity = num;
				}
				else
				{
					Util.Move(ref _armAimIntensity, num, Time.deltaTime * 10f);
				}
			}
			else if (_armAimIntensity > num)
			{
				Util.Move(ref _armAimIntensity, num, Time.deltaTime * 10f);
			}
		}

		private void updateLeftHandIntensity(BaseGun gun)
		{
			if (_motor.IsGettingHit)
			{
				_leftHandAimIntensity = 0f;
				return;
			}
			float num = 0f;
			if (_motor.IsLeftHandAimReady && !_motor.IsClimbingOrVaulting && !_motor.IsFalling)
			{
				if (gun != null && gun.Type == WeaponType.Pistol)
				{
					if (_motor.IsAimingGun || _motor.IsInCover)
					{
						num = 1f;
					}
				}
				else if (_motor.IsInCover)
				{
					num = 1f;
				}
				else
				{
					AnimatorStateInfo nextAnimatorStateInfo = _animator.GetNextAnimatorStateInfo(0);
					float num2 = 1f;
					AnimatorStateInfo animatorStateInfo;
					if (nextAnimatorStateInfo.shortNameHash != 0)
					{
						num2 = _animator.GetAnimatorTransitionInfo(0).normalizedTime;
						animatorStateInfo = nextAnimatorStateInfo;
					}
					else
					{
						animatorStateInfo = _animator.GetCurrentAnimatorStateInfo(0);
					}
					if (animatorStateInfo.IsName("Walking"))
					{
						num = num2;
					}
				}
			}
			if (num > _leftHandAimIntensity)
			{
				if (_motor.wantsToFire)
				{
					_leftHandAimIntensity = num;
				}
				else
				{
					Util.Move(ref _leftHandAimIntensity, num, Time.deltaTime * 15f);
				}
			}
			else
			{
				Util.Move(ref _leftHandAimIntensity, num, Time.deltaTime * 15f);
			}
		}

		private void updateHeadAimIntennsity()
		{
			if (_motor.IsGettingHit)
			{
				_headAimIntensity = 0f;
				return;
			}
			float num = 0f;
			if (_motor.IsAiming && !_motor.IsMovingToCoverOffsetAndCantAim)
			{
				num = 1f;
			}
			if (num > _headAimIntensity)
			{
				Util.Lerp(ref _headAimIntensity, num, 2f);
			}
			else
			{
				Util.Lerp(ref _headAimIntensity, num, 15f);
			}
		}

		private void setIKTarget(IK ik, Transform value, bool useMirror)
		{
			ik.TargetParentBone = value;
			while (ik.TargetParentBone != null && !_mirrors.ContainsKey(ik.TargetParentBone))
			{
				Transform parent = ik.TargetParentBone.parent;
				if (parent == null)
				{
					ik.TargetParentBone = null;
					break;
				}
				ik.TargetParentBone = parent;
			}
			bool flag = ik.TargetParentBone != value;
			if (HasSwitchedHands && useMirror)
			{
				ik.TargetParentBone = _mirrors[ik.TargetParentBone];
			}
			if (flag)
			{
				ik.OffsetOrientation = Quaternion.FromToRotation(ik.TargetParentBone.forward, value.forward);
				ik.Offset = Quaternion.Inverse(ik.OffsetOrientation) * (value.transform.position - ik.TargetParentBone.position);
			}
			else
			{
				ik.Offset = Vector3.zero;
				ik.OffsetOrientation = Quaternion.identity;
			}
		}

		private float getPenetration(Vector3 start, Vector3 end)
		{
			Vector3 a = end - start;
			float magnitude = a.magnitude;
			Vector3 direction = a / magnitude;
			int num = Physics.RaycastNonAlloc(start, direction, Util.Hits, magnitude, Layers.Geometry, QueryTriggerInteraction.Ignore);
			float num2 = magnitude;
			for (int i = 0; i < num; i++)
			{
				if (!Util.InHiearchyOf(Util.Hits[i].collider.gameObject, _motor.gameObject) && Util.Hits[i].distance < num2)
				{
					num2 = Util.Hits[i].distance;
				}
			}
			return magnitude - num2;
		}

		private bool isExtremeTarget(Vector3 aimTarget)
		{
			Vector3 vector = aimTarget - _motor.AimOriginWithCoverOffset;
			Vector3 eulerAngles = _motor.transform.eulerAngles;
			float y = eulerAngles.y;
			float target = Util.HorizontalAngle(vector);
			float num = Mathf.DeltaAngle(y, target);
			if (num > _motor.AimSettings.MaxAimAngle || num < 0f - _motor.AimSettings.MaxAimAngle)
			{
				return true;
			}
			return false;
		}

		private void clampAimTarget(ref Vector3 aimTarget, Vector3 origin)
		{
			Vector3 vector = aimTarget - origin;
			Vector3 eulerAngles = _motor.transform.eulerAngles;
			float y = eulerAngles.y;
			float target = Util.HorizontalAngle(vector);
			float num = Mathf.DeltaAngle(y, target);
			if (num > _motor.AimSettings.MaxAimAngle)
			{
				aimTarget = origin + Quaternion.AngleAxis(_motor.AimSettings.MaxAimAngle - num, Vector3.up) * vector;
			}
			else if (num < 0f - _motor.AimSettings.MaxAimAngle)
			{
				aimTarget = origin + Quaternion.AngleAxis(0f - _motor.AimSettings.MaxAimAngle - num, Vector3.up) * vector;
			}
		}

		private void buildSupportChain(ChainElement start, ChainElement end, bool mirror)
		{
			if (HasSwitchedHands)
			{
				buildChain(_right, bestIndex(_rightIndices, start), bestIndex(_rightIndices, end), mirror);
			}
			else
			{
				buildChain(_left, bestIndex(_leftIndices, start), bestIndex(_leftIndices, end), mirror);
			}
		}

		private void buildMainChain(ChainElement start, ChainElement end, bool mirror)
		{
			if (HasSwitchedHands)
			{
				buildChain(_left, bestIndex(_leftIndices, start), bestIndex(_leftIndices, end), mirror);
			}
			else
			{
				buildChain(_right, bestIndex(_rightIndices, start), bestIndex(_rightIndices, end), mirror);
			}
		}

		private void buildMiddleChain(ChainElement start, ChainElement end)
		{
			buildChain(_middle, bestIndex(_middleIndices, start), bestIndex(_middleIndices, end), mirror: false);
		}

		private void buildChain(Transform[] bones, int start, int end, bool mirror)
		{
			int num = end - start + 1;
			if (num < 0)
			{
				num = 0;
			}
			if (_chain == null || _chain.Length < num)
			{
				_chain = new IKBone[num];
			}
			for (int i = 0; i < num; i++)
			{
				Transform transform = bones[end - i];
				float weight = (i != num - 1) ? 0.5f : 0.8f;
				if (mirror)
				{
					Transform transform2 = _mirrors[transform];
					if (transform2 != null && transform2 != transform)
					{
						_chain[i] = new IKBone(transform, transform2, weight);
					}
					else
					{
						_chain[i] = new IKBone(transform, weight);
					}
				}
				else
				{
					_chain[i] = new IKBone(transform, weight);
				}
			}
		}

		private int bestIndex(int[] indices, ChainElement element)
		{
			for (int i = (int)element; i < indices.Length; i++)
			{
				if (indices[i] >= 0)
				{
					return indices[i];
				}
			}
			for (int i = (int)element; i > 0; i--)
			{
				if (indices[i] >= 0)
				{
					return indices[i];
				}
			}
			return 0;
		}

		private int[] findIndices(Transform[] chain)
		{
			int[] array = new int[7]
			{
				findIndex(chain, HumanBodyBones.LeftLowerArm),
				0,
				0,
				0,
				0,
				0,
				0
			};
			if (array[0] < 0)
			{
				array[0] = findIndex(chain, HumanBodyBones.RightLowerArm);
			}
			array[1] = findIndex(chain, HumanBodyBones.LeftUpperArm);
			if (array[1] < 0)
			{
				array[1] = findIndex(chain, HumanBodyBones.RightUpperArm);
			}
			array[2] = findIndex(chain, HumanBodyBones.LeftShoulder);
			if (array[2] < 0)
			{
				array[2] = findIndex(chain, HumanBodyBones.RightShoulder);
			}
			array[3] = findIndex(chain, HumanBodyBones.Head);
			array[4] = findIndex(chain, HumanBodyBones.Neck);
			array[5] = findIndex(chain, HumanBodyBones.Chest);
			array[6] = findIndex(chain, HumanBodyBones.Spine);
			return array;
		}

		private int findIndex(Transform[] chain, HumanBodyBones bone)
		{
			Transform y = _bones[(int)bone];
			for (int i = 0; i < chain.Length; i++)
			{
				if (chain[i] == y)
				{
					return i;
				}
			}
			return -1;
		}

		private Transform[] findChain(Transform start)
		{
			List<Transform> list = new List<Transform>();
			Transform transform = start;
			while (transform != null && _mirrors.ContainsKey(transform))
			{
				list.Add(transform);
				transform = transform.parent;
			}
			return list.ToArray();
		}

		private void calculateMirror(ref SwitchedWeapon weapon, Transform transform)
		{
			if (weapon.Weapon != null)
			{
				unmirror(ref weapon);
			}
			Transform transform2 = transform.parent;
			if (_mirrors.ContainsKey(transform2))
			{
				transform2 = _mirrors[transform2];
			}
			if (!(transform2 == transform.parent))
			{
				Transform transform3 = transform;
				BaseGun component = transform.GetComponent<BaseGun>();
				if (component != null && component.Aim != null)
				{
					transform3 = component.Aim.transform;
				}
				Vector3 forward = transform3.forward;
				weapon.Weapon = transform;
				weapon.OriginalBone = weapon.Weapon.transform.parent;
				weapon.OriginalLocalPosition = weapon.Weapon.localPosition;
				weapon.OriginalLocalRotation = weapon.Weapon.localRotation;
				weapon.OriginalLocalScale = weapon.Weapon.localScale;
				weapon.NeedsToRestoreLeftHand = false;
				weapon.SwitchedBone = transform2;
				weapon.Weapon.SetParent(transform2, worldPositionStays: false);
				weapon.Weapon.localScale = new Vector3(weapon.OriginalLocalScale.x, 0f - weapon.OriginalLocalScale.y, weapon.OriginalLocalScale.z);
				if (Vector3.Dot(transform3.forward, forward) < 0f)
				{
					weapon.Weapon.localPosition = new Vector3(0f - weapon.OriginalLocalPosition.x, 0f - weapon.OriginalLocalPosition.y, 0f - weapon.OriginalLocalPosition.z);
					weapon.Weapon.Rotate(Vector3.up, 180f);
				}
			}
		}

		private void swapLeftHand(ref SwitchedWeapon left, ref SwitchedWeapon right)
		{
			BaseGun component = left.Weapon.GetComponent<BaseGun>();
			BaseGun component2 = right.Weapon.GetComponent<BaseGun>();
			if (!(component == null) && !(component2 == null))
			{
				left.NeedsToRestoreLeftHand = true;
				right.NeedsToRestoreLeftHand = true;
				left.OriginalLeftHand = ((!(component.LeftHandDefault != null)) ? Vector3.zero : component.LeftHandDefault.localPosition);
				left.OriginalLeftHandAim = ((!(component.LeftHandOverwrite.Aim != null)) ? Vector3.zero : component.LeftHandOverwrite.Aim.localPosition);
				left.OriginalLeftHandCrouch = ((!(component.LeftHandOverwrite.Crouch != null)) ? Vector3.zero : component.LeftHandOverwrite.Crouch.localPosition);
				left.OriginalLeftHandLowCover = ((!(component.LeftHandOverwrite.LowCover != null)) ? Vector3.zero : component.LeftHandOverwrite.LowCover.localPosition);
				left.OriginalLeftHandTallCover = ((!(component.LeftHandOverwrite.TallCover != null)) ? Vector3.zero : component.LeftHandOverwrite.TallCover.localPosition);
				right.OriginalLeftHand = ((!(component2.LeftHandDefault != null)) ? Vector3.zero : component2.LeftHandDefault.localPosition);
				right.OriginalLeftHandAim = ((!(component2.LeftHandOverwrite.Aim != null)) ? Vector3.zero : component2.LeftHandOverwrite.Aim.localPosition);
				right.OriginalLeftHandCrouch = ((!(component2.LeftHandOverwrite.Crouch != null)) ? Vector3.zero : component2.LeftHandOverwrite.Crouch.localPosition);
				right.OriginalLeftHandLowCover = ((!(component2.LeftHandOverwrite.LowCover != null)) ? Vector3.zero : component2.LeftHandOverwrite.LowCover.localPosition);
				right.OriginalLeftHandTallCover = ((!(component2.LeftHandOverwrite.TallCover != null)) ? Vector3.zero : component2.LeftHandOverwrite.TallCover.localPosition);
				if (component.LeftHandDefault != null && component2.LeftHandDefault != null)
				{
					Vector3 localPosition = component.LeftHandDefault.localPosition;
					component.LeftHandDefault.localPosition = component2.LeftHandDefault.localPosition;
					component2.LeftHandDefault.localPosition = localPosition;
				}
				if (component.LeftHandOverwrite.Aim != null && component2.LeftHandOverwrite.Aim != null)
				{
					Vector3 localPosition2 = component.LeftHandOverwrite.Aim.localPosition;
					component.LeftHandOverwrite.Aim.localPosition = component2.LeftHandOverwrite.Aim.localPosition;
					component2.LeftHandOverwrite.Aim.localPosition = localPosition2;
				}
				if (component.LeftHandOverwrite.Crouch != null && component2.LeftHandOverwrite.Crouch != null)
				{
					Vector3 localPosition3 = component.LeftHandOverwrite.Crouch.localPosition;
					component.LeftHandOverwrite.Crouch.localPosition = component2.LeftHandOverwrite.Crouch.localPosition;
					component2.LeftHandOverwrite.Crouch.localPosition = localPosition3;
				}
				if (component.LeftHandOverwrite.LowCover != null && component2.LeftHandOverwrite.LowCover != null)
				{
					Vector3 localPosition4 = component.LeftHandOverwrite.LowCover.localPosition;
					component.LeftHandOverwrite.LowCover.localPosition = component2.LeftHandOverwrite.LowCover.localPosition;
					component2.LeftHandOverwrite.LowCover.localPosition = localPosition4;
				}
				if (component.LeftHandOverwrite.TallCover != null && component2.LeftHandOverwrite.TallCover != null)
				{
					Vector3 localPosition5 = component.LeftHandOverwrite.TallCover.localPosition;
					component.LeftHandOverwrite.TallCover.localPosition = component2.LeftHandOverwrite.TallCover.localPosition;
					component2.LeftHandOverwrite.TallCover.localPosition = localPosition5;
				}
			}
		}

		private void mirror(ref SwitchedWeapon weapon, Transform transform, Transform newParent, Vector3 localPosition, Quaternion localRotation, Vector3 localScale)
		{
			if (weapon.Weapon != null)
			{
				unmirror(ref weapon);
			}
			weapon.Weapon = transform;
			weapon.OriginalBone = weapon.Weapon.transform.parent;
			weapon.OriginalLocalPosition = weapon.Weapon.localPosition;
			weapon.OriginalLocalRotation = weapon.Weapon.localRotation;
			weapon.OriginalLocalScale = weapon.Weapon.localScale;
			weapon.SwitchedBone = newParent;
			weapon.Weapon.SetParent(newParent, worldPositionStays: false);
			weapon.Weapon.localPosition = localPosition;
			weapon.Weapon.localRotation = localRotation;
			weapon.Weapon.localScale = localScale;
			weapon.NeedsToRestoreLeftHand = false;
		}

		private void unmirror(ref SwitchedWeapon weapon)
		{
			if (weapon.Weapon == null)
			{
				return;
			}
			weapon.Weapon.SetParent(weapon.OriginalBone);
			weapon.Weapon.localPosition = weapon.OriginalLocalPosition;
			weapon.Weapon.localRotation = weapon.OriginalLocalRotation;
			weapon.Weapon.localScale = weapon.OriginalLocalScale;
			if (weapon.NeedsToRestoreLeftHand)
			{
				BaseGun component = weapon.Weapon.GetComponent<BaseGun>();
				if (component != null)
				{
					if (component.LeftHandDefault != null)
					{
						component.LeftHandDefault.localPosition = weapon.OriginalLeftHand;
					}
					if (component.LeftHandOverwrite.Aim != null)
					{
						component.LeftHandOverwrite.Aim.localPosition = weapon.OriginalLeftHandAim;
					}
					if (component.LeftHandOverwrite.Crouch != null)
					{
						component.LeftHandOverwrite.Crouch.localPosition = weapon.OriginalLeftHandCrouch;
					}
					if (component.LeftHandOverwrite.LowCover != null)
					{
						component.LeftHandOverwrite.LowCover.localPosition = weapon.OriginalLeftHandLowCover;
					}
					if (component.LeftHandOverwrite.TallCover != null)
					{
						component.LeftHandOverwrite.TallCover.localPosition = weapon.OriginalLeftHandTallCover;
					}
				}
			}
			weapon.Weapon = null;
		}
	}
}
