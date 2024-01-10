// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MobileController
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class MobileController : MonoBehaviour
	{
		[Tooltip("Is the character always aiming in camera direction when not in cover.")]
		public bool AlwaysAim = true;

		[Tooltip("Should the controller automatically reload once the weapon magazine is empty.")]
		public bool AutoReload = true;

		[Tooltip("Maximum target angle difference for the character to aim precisely at an enemy.")]
		public float AutoAimPrecision = 30f;

		[Tooltip("Maximum target distance for the character to aim precisely at an enemy.")]
		public float AutoAimDistance = 20f;

		[Tooltip("Maximum ngle difference between the current and intended orientations of the character for it to fire.")]
		public float FirePrecision = 25f;

		[Tooltip("Is the character now crouching.")]
		public bool IsCrouching;

		[Tooltip("How long to maintain the aim direction before aiming torwards the direction of running.")]
		public float PostFireDelay = 0.5f;

		[Tooltip("Movement speed.")]
		public CharacterSpeed Speed = CharacterSpeed.Run;

		[Tooltip("Input is ignored when a disabler is active.")]
		public GameObject Disabler;

		[HideInInspector]
		public Vector3 Forward = Vector3.forward;

		[HideInInspector]
		public bool HasMovement;

		[HideInInspector]
		public Vector2 Movement = Vector2.zero;

		[HideInInspector]
		public bool HasAiming;

		[HideInInspector]
		public float Magnitude;

		[HideInInspector]
		public bool IsAllowedToFire;

		[HideInInspector]
		public Vector2 Aiming = Vector2.zero;

		[Tooltip("Prefab to instantiate to display grenade explosion preview.")]
		public GameObject ExplosionPreview;

		[Tooltip("Prefab to instantiate to display grenade path preview.")]
		public GameObject PathPreview;

		private bool _wasAiming;

		private bool _wasInCover;

		private bool _willFireOrThrow;

		private bool _hasJustFiredOrThrown;

		private float _coverTimer;

		private float _postAimWait;

		private Vector3[] _grenadePath = new Vector3[128];

		private int _grenadePathLength;

		private bool _hasGrenadePath;

		private float _fireAngle;

		private GameObject _explosionPreview;

		private GameObject _pathPreview;

		private CharacterMotor _motor;

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		private void Update()
		{
			if (Disabler != null && Disabler.activeSelf)
			{
				return;
			}
			updateGrenadeAimAndPreview();
			if (_motor.PotentialCover != null)
			{
				_motor.InputTakeCover();
			}
			if (AlwaysAim)
			{
				if (_motor.IsInCover)
				{
					_motor.InputAimWhenLeavingCover();
				}
				else
				{
					_motor.InputAim();
				}
			}
			BaseGun gun = _motor.EquippedWeapon.Gun;
			if (AutoReload && gun != null && gun.LoadedBulletsLeft <= 0)
			{
				_motor.InputReload();
			}
			bool flag = HasMovement && Movement.sqrMagnitude > float.Epsilon;
			bool flag2 = HasAiming && Aiming.sqrMagnitude > float.Epsilon;
			if (flag)
			{
				CharacterMovement movement = default(CharacterMovement);
				Vector3 a = Vector3.Cross(Vector3.up, Forward);
				movement.Direction = Movement.x * a + Movement.y * Forward;
				switch (Speed)
				{
				case CharacterSpeed.Walk:
					movement.Magnitude = 0.4f;
					break;
				case CharacterSpeed.Run:
					movement.Magnitude = 1f;
					break;
				case CharacterSpeed.Sprint:
					movement.Magnitude = 2f;
					break;
				}
				if (_motor.IsInCover && _coverTimer < 0.5f && (movement.Direction.magnitude < 0.1f || Vector3.Dot(movement.Direction, _motor.Cover.Forward) > -0.1f))
				{
					movement.Direction = (movement.Direction + _motor.Cover.Forward).normalized;
				}
				_motor.InputMovement(movement);
				if (!flag2 && !_willFireOrThrow && !_hasJustFiredOrThrown)
				{
					Vector3 vector = _motor.transform.position + movement.Direction * 100f;
					_motor.SetBodyTarget(vector);
					_motor.SetAimTarget(vector);
				}
			}
			else if (_motor.IsInCover && _coverTimer < 0.5f)
			{
				CharacterMovement movement2 = default(CharacterMovement);
				movement2.Magnitude = 1f;
				movement2.Direction = _motor.Cover.Forward;
				_motor.InputMovement(movement2);
			}
			if (_motor.HasGrenadeInHand)
			{
				if (flag2)
				{
					Vector3 a2 = Vector3.Cross(Vector3.up, Forward);
					Vector3 a3 = Aiming.x * a2 + Aiming.y * Forward;
					Vector3 vector2 = base.transform.position + a3 * 100f + Vector3.up;
					_motor.SetBodyTarget(vector2);
					_motor.SetAimTarget(vector2);
					_wasAiming = true;
				}
				else if (_wasAiming)
				{
					_willFireOrThrow = IsAllowedToFire;
					_wasAiming = false;
				}
			}
			else if (flag2)
			{
				findTarget();
				Vector3 lhs = _motor.AimTarget - _motor.transform.position;
				lhs.y = 0f;
				lhs.Normalize();
				if ((Vector3.Dot(lhs, _motor.transform.forward) > 0.25f || _motor.IsInCover) && IsAllowedToFire && (Speed != CharacterSpeed.Sprint || !HasMovement))
				{
					_motor.InputAim();
					_wasAiming = true;
				}
				if (gun != null && gun.FireOnMobileAim && IsAllowedToFire)
				{
					_willFireOrThrow = true;
				}
			}
			else if (_wasAiming)
			{
				if (IsAllowedToFire)
				{
					findTarget();
					_willFireOrThrow = true;
				}
				_wasAiming = false;
			}
			if (_hasJustFiredOrThrown)
			{
				_postAimWait += Time.deltaTime;
				if (_postAimWait >= PostFireDelay)
				{
					_hasJustFiredOrThrown = false;
					_postAimWait = 0f;
				}
			}
			if (_willFireOrThrow)
			{
				if (_motor.HasGrenadeInHand)
				{
					if (_hasGrenadePath)
					{
						_motor.InputThrowGrenade(_grenadePath, _grenadePathLength, _motor.Grenade.Step);
					}
					_willFireOrThrow = false;
					_hasJustFiredOrThrown = true;
					_postAimWait = 0f;
				}
				else
				{
					Vector3 eulerAngles = base.transform.eulerAngles;
					float num = Mathf.Abs(Mathf.DeltaAngle(eulerAngles.y, _fireAngle));
					if (num < FirePrecision)
					{
						_motor.InputFire();
						_willFireOrThrow = false;
						_hasJustFiredOrThrown = true;
						_postAimWait = 0f;
					}
				}
			}
			if (_motor.IsInCover)
			{
				if (_motor.IsInCover)
				{
					if (!_wasInCover)
					{
						_wasInCover = true;
						_coverTimer = 0f;
					}
					else
					{
						_coverTimer += Time.deltaTime;
					}
				}
				else
				{
					_wasInCover = false;
				}
			}
			else if (_motor.PotentialCover != null)
			{
				_motor.InputTakeCover();
			}
			if (IsCrouching)
			{
				_motor.InputCrouch();
			}
		}

		private void findTarget()
		{
			Vector3 a = Vector3.Cross(Vector3.up, Forward);
			Vector3 vector = Aiming.x * a + Aiming.y * Forward;
			Vector3 vector2 = base.transform.position + vector * 100f + Vector3.up;
			float num = -1f;
			float num2 = Mathf.Cos(AutoAimPrecision * ((float)Math.PI / 180f));
			foreach (Character item in Characters.AllAlive)
			{
				Character current = item;
				if (current.Object != base.gameObject && current.IsAnyInSight(0.01f))
				{
					Vector3 a2 = current.Object.transform.position - base.transform.position;
					a2.y = 0f;
					float magnitude = a2.magnitude;
					if (magnitude > float.Epsilon && magnitude < AutoAimDistance)
					{
						float num3 = Vector3.Dot(vector, a2 / magnitude);
						if (num3 > num2 && num3 > num)
						{
							num = num3;
							CharacterMotor component = current.Object.GetComponent<CharacterMotor>();
							vector2 = current.Object.transform.position + Vector3.up * component.CurrentHeight * 0.8f;
						}
					}
				}
			}
			_fireAngle = Util.HorizontalAngle(vector2 - base.transform.position);
			_motor.SetBodyTarget(vector2);
			_motor.SetAimTarget(vector2);
		}

		private void updateGrenadeAimAndPreview()
		{
			if ((HasAiming || _wasAiming) && IsAllowedToFire && _motor.IsAlive && _motor.IsReadyToThrowGrenade && _motor.CurrentGrenade != null)
			{
				GrenadeDescription desc = default(GrenadeDescription);
				desc.Gravity = _motor.Grenade.Gravity;
				desc.Duration = _motor.PotentialGrenade.Timer;
				desc.Bounciness = _motor.PotentialGrenade.Bounciness;
				float num = Magnitude * 45f;
				float num2 = _motor.Grenade.MaxVelocity;
				if (num < 45f)
				{
					num2 *= Mathf.Clamp01((num + 15f) / 45f);
				}
				_grenadePathLength = GrenadePath.Calculate(GrenadePath.Origin(_motor, _motor.BodyAngle), _motor.BodyAngle, num, num2, desc, _grenadePath, _motor.Grenade.Step);
				_hasGrenadePath = true;
				if (_explosionPreview == null && ExplosionPreview != null)
				{
					_explosionPreview = UnityEngine.Object.Instantiate(ExplosionPreview);
					_explosionPreview.transform.SetParent(null);
					_explosionPreview.SetActive(value: true);
				}
				if (_explosionPreview != null)
				{
					_explosionPreview.transform.localScale = Vector3.one * _motor.PotentialGrenade.ExplosionRadius * 2f;
					_explosionPreview.transform.position = _grenadePath[_grenadePathLength - 1];
				}
				if (_pathPreview == null && PathPreview != null)
				{
					_pathPreview = UnityEngine.Object.Instantiate(PathPreview);
					_pathPreview.transform.SetParent(null);
					_pathPreview.SetActive(value: true);
				}
				if (_pathPreview != null)
				{
					_pathPreview.transform.position = _grenadePath[0];
					PathPreview component = _pathPreview.GetComponent<PathPreview>();
					if (component != null)
					{
						component.Points = _grenadePath;
						component.PointCount = _grenadePathLength;
					}
				}
			}
			else
			{
				if (_explosionPreview != null)
				{
					UnityEngine.Object.Destroy(_explosionPreview);
					_explosionPreview = null;
				}
				if (_pathPreview != null)
				{
					UnityEngine.Object.Destroy(_pathPreview);
					_pathPreview = null;
				}
				_hasGrenadePath = false;
			}
		}
	}
}
