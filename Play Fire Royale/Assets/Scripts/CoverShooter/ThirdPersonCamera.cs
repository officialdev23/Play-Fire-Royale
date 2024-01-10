// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ThirdPersonCamera
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Camera))]
	public class ThirdPersonCamera : BaseCamera
	{
		[Tooltip("Is the camera adjusting itself so there are no colliders between it and the target.")]
		public bool AvoidObstacles = true;

		[Tooltip("Should the AvoidObstacles be ignored when the character is zooming in.")]
		public bool IgnoreObstaclesWhenZooming = true;

		[Tooltip("Reduction in field of view when zooming in without a scope.")]
		public float Zoom = 10f;

		[Tooltip("Does camera shake affect aiming.")]
		public bool ShakingAffectsAim = true;

		[Tooltip("Should the camera ask for smoother rotation animations when zooming in.")]
		public bool AskForSmoothRotations = true;

		[Tooltip("Camera settings for all gameplay situations.")]
		public CameraStates States = CameraStates.GetDefault();

		[HideInInspector]
		public float Horizontal;

		[HideInInspector]
		public float Vertical;

		[HideInInspector]
		public float VerticalRecoil;

		[HideInInspector]
		public float HorizontalRecoil;

		private Vector3 _pivot;

		private Vector3 _offset;

		private float _horizontalDifference;

		private float _verticalDifference;

		private Vector3 _orientation;

		private float _crosshairAlpha;

		private Vector3 _motorPosition;

		private Quaternion _motorRotation;

		private Vector3 _motorOffset;

		private float _motorOffsetIntensity;

		private Vector3 _obstacleFix;

		private float _lastTargetDistance;

		private Camera _camera;

		private ThirdPersonController _controller;

		private CharacterMotor _cachedMotor;

		private float _stateFOV;

		private bool _hasAskedForLateUpdate;

		private bool _wasScoped;

		private bool _wasAiming;

		private CameraObjectFader _fader;

		private Vector3 _currentPivot;

		private Vector3 _currentOffset;

		private bool _isByCorner;

		private float _cornerDelay;

		private bool _isMirrored;

		private bool _couldCornerAim;

		private string _stateName;

		private float _shakeTime;

		private float _shakeDuration;

		private float _shakeIntensity;

		private Vector3 _shake;

		private Vector3 _shakeTarget;

		public float StateFOV => _stateFOV;

		public string State => _stateName;

		public float CrosshairAlpha => _crosshairAlpha;

		public float ShakeOffset
		{
			get
			{
				float num = Mathf.Abs(_shakeTarget.x);
				float num2 = Mathf.Abs(_shakeTarget.y);
				if (num > num2)
				{
					return num;
				}
				return num2;
			}
		}

		public static void Shake(Vector3 position, float intensity, float time)
		{
			Camera main = Camera.main;
			if (main == null)
			{
				return;
			}
			ThirdPersonCamera component = main.GetComponent<ThirdPersonCamera>();
			if (!(component == null))
			{
				float num = Vector3.Distance(component.transform.position, position);
				if (num < 0.1f)
				{
					num = 0.1f;
				}
				num *= 10f;
				intensity *= 100f / (num * num);
				if (intensity > 0.01f)
				{
					component.Shake(intensity, time);
				}
			}
		}

		public static void Shake(CharacterMotor motor, float intensity, float time)
		{
			Camera main = Camera.main;
			if (!(main == null))
			{
				ThirdPersonCamera component = main.GetComponent<ThirdPersonCamera>();
				if (!(component == null) && component.Target == motor)
				{
					component.Shake(intensity, time);
				}
			}
		}

		public void Shake(float intensity, float time)
		{
			_shakeTime = time;
			_shakeDuration = time;
			_shakeIntensity = intensity;
			_shakeTarget = Vector3.zero;
		}

		private void Awake()
		{
			_camera = GetComponent<Camera>();
			_offset = States.Default.Offset;
			_camera.depthTextureMode = DepthTextureMode.Depth;
			_stateFOV = States.Default.FOV;
			_fader = GetComponent<CameraObjectFader>();
			Zoom = 20f;
			StartCoroutine(retorna());
		}

		private IEnumerator retorna()
		{
			yield return new WaitForSeconds(10f);
			Zoom = 11f;
		}

		private ThirdPersonController getCurrentController()
		{
			if (_cachedMotor != Target)
			{
				_cachedMotor = Target;
				if (_cachedMotor == null)
				{
					_controller = null;
				}
				else
				{
					_controller = _cachedMotor.GetComponent<ThirdPersonController>();
				}
			}
			return _controller;
		}

		private void calculatePositionAndTarget(float horizontal, float vertical, Vector3 pivot, Vector3 offset, out Vector3 position, out Vector3 target)
		{
			Quaternion rotation = Quaternion.Euler(vertical, horizontal, 0f);
			Vector3 a = _motorRotation * pivot + _motorPosition;
			position = a + rotation * offset;
			target = _motorPosition + pivot + rotation * Vector3.forward * 10f;
		}

		public Vector3 CalculateAimTarget(bool includeRecoil)
		{
			float horizontal = Horizontal + ((!includeRecoil) ? 0f : HorizontalRecoil);
			float vertical = Vertical - ((!includeRecoil) ? 0f : VerticalRecoil);
            Vector3 position,   target;

            calculatePositionAndTarget(horizontal, vertical, _currentPivot, _currentOffset, out  position, out  target);
       

            if (ShakingAffectsAim)
			{
				Vector3 point = target - position;
				return target + Quaternion.AngleAxis(_shake.x, base.transform.right) * Quaternion.AngleAxis(_shake.y, base.transform.up) * point;
			}
			return target;
		}

		public void UpdatePosition()
		{
            Vector3 position,   target;

            calculatePositionAndTarget(Horizontal + HorizontalRecoil, Vertical - VerticalRecoil, _currentPivot, _currentOffset, out  position, out  target);
			ThirdPersonController component = Target.GetComponent<ThirdPersonController>();
			BaseGun gun = Target.ActiveWeapon.Gun;
			if (gun != null && gun.Scope != null && (Target.IsScoping || (component != null && component.IsScoping)))
			{
				Target.InputLayer(Layers.Scope);
				_wasScoped = true;
				_obstacleFix = Util.Lerp(_obstacleFix, Vector3.zero, 20f);
			}
			else
			{
				_wasScoped = false;
				Vector3 normalized = (target - position).normalized;
				Vector3 target2 = Vector3.zero;
				if (AvoidObstacles && (!IgnoreObstaclesWhenZooming || !component.IsZooming))
				{
					target2 = checkObstacles(position, _motorPosition + Target.StandingHeight * Vector3.up, 0.1f);
				}
				_obstacleFix = Util.Lerp(_obstacleFix, target2, 6f);
			}
			position += _obstacleFix;
			base.transform.position = position;
			base.transform.LookAt(target);
			float d = Vector3.Distance(position, target);
			base.transform.localRotation *= Quaternion.Euler(_shake);
			target = base.transform.position + base.transform.forward * d;
		}

		private void LateUpdate()
		{
			if (!_hasAskedForLateUpdate)
			{
				UpdateForCharacterMotor();
			}
		}

		protected override void Update()
		{
			base.Update();
			if (_shakeTime > float.Epsilon)
			{
				float num = _shakeTime / _shakeDuration;
				num *= num;
				Util.Lerp(ref _shake, _shakeTarget, 20f);
				if (Vector3.Distance(_shake, _shakeTarget) < 1f)
				{
					_shakeTarget = Random.onUnitSphere * num * _shakeIntensity * 5f;
					_shakeTarget.z = 0f;
				}
				_shakeTime -= Time.deltaTime;
			}
			else
			{
				Util.Lerp(ref _shake, Vector3.zero, 10f);
			}
			if (Target != null)
			{
				ThirdPersonController currentController = getCurrentController();
				if (Target.IsInTallCover)
				{
					_isMirrored = Target.IsStandingLeftInCover;
				}
				else if (!currentController.IsZooming && (!_isMirrored || !Target.WantsToMaintainMirror))
				{
					_isMirrored = false;
				}
				if (_isMirrored)
				{
					Target.InputMirror();
				}
			}
			if ((bool)Target)
			{
				_hasAskedForLateUpdate = true;
				Target.AskForLateUpdate(this);
			}
			else
			{
				_hasAskedForLateUpdate = false;
			}
		}

		public override void UpdateForCharacterMotor()
		{
			_hasAskedForLateUpdate = false;
			if (Target == null)
			{
				return;
			}
			if ((Target.IsStandingLeftInCover && Target.IsByAnOpenLeftCorner) || (!Target.IsStandingLeftInCover && Target.IsByAnOpenRightCorner))
			{
				Util.Lerp(ref _motorOffsetIntensity, 1f, 6f);
				_motorOffset = Vector3.Lerp(_motorOffset, Target.ClosestCoverPosition - Target.transform.position, _motorOffsetIntensity);
			}
			else
			{
				_motorOffsetIntensity = 0f;
				Util.Lerp(ref _motorOffset, Vector3.zero, 6f);
			}
			_motorPosition = Target.transform.position + _motorOffset;
			if (Target.IsVaulting)
			{
				_motorPosition.y = Target.VaultPosition;
			}
			_motorRotation = Target.transform.rotation;
			UpdatePosition();
			if (_fader != null)
			{
				Plane plane = new Plane(_motorPosition, _motorPosition + base.transform.up, _motorPosition + base.transform.right);
				Ray ray = new Ray(base.transform.position, base.transform.forward);
				Vector3 position;
                float enter;

                if (plane.Raycast(ray, out  enter))
				{
					position = base.transform.position + ray.direction * enter;
				}
				else
				{
					position = Util.GetClosestHit(base.transform.position, base.transform.forward * 100f, 0.1f, Target.gameObject);
					position -= base.transform.forward * 0.2f;
				}
				_fader.SetFadeTarget(new FadeTarget(Target.gameObject, position));
			}
			Vector3 target = base.transform.position + base.transform.forward * 1000f;
			Vector3 closestHit = Util.GetClosestHit(base.transform.position, target, Vector3.Distance(base.transform.position, Target.Top), Target.gameObject);
			_lastTargetDistance = Vector3.Distance(base.transform.position, closestHit);
			float target2 = 0f;
			ThirdPersonController currentController = getCurrentController();
			bool flag = false;
			if ((_couldCornerAim || !Target.IsMoving) && Target.IsInCover && ((Target.IsInTallCover && Target.CoverSettings.CanUseTallCorners) || (Target.IsInLowCover && Target.CoverSettings.CanUseLowCorners)) && Target.Cover.IsFrontField(Horizontal + _horizontalDifference, 180f) && ((Target.IsNearLeftCorner && Target.IsStandingLeftInCover && Target.Cover.OpenLeft) || (Target.IsNearRightCorner && !Target.IsStandingLeftInCover && Target.Cover.OpenRight)))
			{
				flag = true;
			}
			if (flag)
			{
				if (!Target.IsWalkingInCover)
				{
					_cornerDelay = 0.2f;
				}
				if (_cornerDelay < 0.2f)
				{
					_cornerDelay += Time.deltaTime;
				}
				else
				{
					_isByCorner = true;
				}
			}
			else if (_cornerDelay > float.Epsilon)
			{
				_cornerDelay -= Time.deltaTime;
			}
			else
			{
				_isByCorner = false;
			}
			_couldCornerAim = flag;
			CameraState cameraState;
			if (!Target.IsAlive)
			{
				_stateName = "Dead";
				cameraState = States.Dead;
				target2 = 0f;
			}
			else if (currentController != null && currentController.IsMelee)
			{
				target2 = 0f;
				cameraState = States.Melee;
				_stateName = "Melee";
			}
			else if (currentController != null && currentController.IsZooming)
			{
				target2 = 1f;
				if (flag)
				{
					if (Target.IsInTallCover)
					{
						_stateName = "TallCornerZoom";
						cameraState = States.TallCornerZoom;
					}
					else
					{
						_stateName = "LowCornerZoom";
						cameraState = States.LowCornerZoom;
					}
				}
				else
				{
					cameraState = States.Zoom;
				}
			}
			else if (Target.IsClimbingOrVaulting)
			{
				_stateName = "Climb";
				cameraState = States.Climb;
			}
			else if (Target.IsInCover)
			{
				if (flag && _isByCorner)
				{
					target2 = 1f;
					_stateName = "Corner";
					cameraState = States.Corner;
				}
				else if (Target.IsInTallCover)
				{
					if (Target.Cover.IsBack(Horizontal + _horizontalDifference))
					{
						target2 = 1f;
						_stateName = "TallCoverBack";
						cameraState = States.TallCoverBack;
					}
					else
					{
						_stateName = "TallCover";
						cameraState = States.TallCover;
					}
				}
				else if (Target.HasGrenadeInHand)
				{
					_stateName = "LowCoverGrenade";
					cameraState = States.LowCoverGrenade;
				}
				else
				{
					target2 = 1f;
					_stateName = "LowCover";
					cameraState = States.LowCover;
				}
			}
			else if (Target.IsCrouching)
			{
				if (Target.IsAiming)
				{
					target2 = 1f;
				}
				_stateName = "Crouch";
				cameraState = States.Crouch;
			}
			else if (Target.WouldAim)
			{
				if (Target.IsAiming)
				{
					target2 = 1f;
				}
				_stateName = "Aim";
				cameraState = States.Aim;
			}
			else
			{
				target2 = 0f;
				_stateName = "Default";
				cameraState = States.Default;
			}
			float num = Mathf.Clamp(Vertical + _verticalDifference, 0f - cameraState.MaxAngle, 0f - cameraState.MinAngle);
			_verticalDifference = num - Vertical;
			float num2 = cameraState.FOV;
			_stateFOV = cameraState.FOV;
			if (currentController != null && Target != null && Target.ActiveWeapon.Gun != null)
			{
				if (currentController.IsScoping)
				{
					num2 -= Target.ActiveWeapon.Gun.Zoom;
				}
				else if (currentController.IsZooming)
				{
					num2 -= Zoom;
				}
			}
			bool flag2 = currentController != null && currentController.IsScoping;
			float num3 = 6f;
			if (flag2 || (Target != null && Target.IsChangingWeapon))
			{
				target2 = 0f;
			}
			if (flag2 || _wasScoped)
			{
				_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, num2, num3 * 3f);
				num3 = 1f;
			}
			else
			{
				_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, num2, num3);
			}
			_wasScoped = flag2;
			Vector3 constantPivot = cameraState.ConstantPivot;
			Pivot pivot = cameraState.Pivot;
			Vector3 offset = cameraState.Offset;
			Vector3 orientation = cameraState.Orientation;
			if (_isMirrored)
			{
				constantPivot.x *= -1f;
				switch (pivot)
				{
				case Pivot.leftShoulder:
					pivot = Pivot.rightShoulder;
					break;
				case Pivot.rightShoulder:
					pivot = Pivot.leftShoulder;
					break;
				}
				offset.x *= -1f;
				orientation.y *= -1f;
			}
			_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, num2, 6f);
			Util.Lerp(ref _crosshairAlpha, target2, num3);
			Util.Lerp(ref _orientation, orientation, num3);
			Vector3 offset2 = offset;
			Vector3 pivot2;
			if (pivot == Pivot.constant)
			{
				pivot2 = constantPivot;
			}
			else
			{
				pivot2 = ((!Target.IsCrouching && (!Target.IsInLowCover || Target.IsAimingThroughCoverPlane)) ? Target.ShoulderSettings.Standing : Target.ShoulderSettings.Crouching);
				if (pivot == Pivot.leftShoulder)
				{
					pivot2.x *= -1f;
				}
			}
			if (_wasAiming || Target.IsAiming)
			{
                Vector3 position2, position3; Vector3 target3, target4;

                calculatePositionAndTarget(Horizontal + _horizontalDifference, Vertical + _verticalDifference, _pivot, _offset, out  position2, out  target3);
				calculatePositionAndTarget(Horizontal + _horizontalDifference, Vertical + _verticalDifference, pivot2, offset2, out  position3, out  target4);
				RaycastHit hitInfo;
				Vector3 a = (!Physics.Raycast(position2, (target3 - position2).normalized, out hitInfo) || !(Vector3.Distance(position2, hitInfo.point) > 2f)) ? target3 : hitInfo.point;
				Vector3 normalized = (target4 - position3).normalized;
				Vector3 normalized2 = (a - position3).normalized;
				float num4 = Util.HorizontalAngle(normalized2) - Util.HorizontalAngle(normalized);
				_horizontalDifference += num4;
				float num5 = Mathf.Asin(normalized.y) * 57.29578f - Mathf.Asin(normalized2.y) * 57.29578f;
				_verticalDifference += num5;
			}
			_wasAiming = Target.IsAiming;
			_pivot = pivot2;
			_offset = offset2;
			Util.Lerp(ref _currentPivot, _pivot, 6f);
			Util.Lerp(ref _currentOffset, _offset, 6f);
			float num6 = Util.LerpAngle(0f, _horizontalDifference, 6f);
			float num7 = Util.LerpAngle(0f, _verticalDifference, 6f);
			Horizontal += num6;
			_horizontalDifference -= num6;
			Vertical += num7;
			_verticalDifference -= num7;
			if (currentController != null && currentController.IsZooming && AskForSmoothRotations)
			{
				Target.InputSmoothRotation();
			}
			Target.InputPreciseHands();
		}

		private Vector3 checkObstacles(Vector3 camera, Vector3 target, float radius)
		{
			int num = 0;
			float num2 = Vector3.Distance(camera, target);
			Vector3 normalized = (target - camera).normalized;
			float maxFix = 0f;
			if ((float)num < num2)
			{
				Vector3 vector = target - normalized * num;
				float num3 = Vector3.Distance(camera, target) + radius;
				if (num3 < float.Epsilon)
				{
					num3 = float.Epsilon;
				}
				Vector3 vector2 = (!(normalized.y > -0.99f) && !(normalized.y < 0.99f)) ? Vector3.forward : Vector3.up;
				Vector3 a = Vector3.Cross(vector2, normalized);
				raycast(vector, normalized, num3, ref maxFix);
				raycast(vector + a * radius, normalized, num3, ref maxFix);
				raycast(vector - a * radius, normalized, num3, ref maxFix);
				raycast(vector + vector2 * radius, normalized, num3, ref maxFix);
				raycast(vector - vector2 * radius, normalized, num3, ref maxFix);
			}
			return maxFix * normalized;
		}

		private void raycast(Vector3 origin, Vector3 forward, float distance, ref float maxFix)
		{
			Ray ray = new Ray(origin, -forward);
			int num = Physics.RaycastNonAlloc(ray, Util.Hits, distance, Layers.Geometry, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num; i++)
			{
				RaycastHit raycastHit = Util.Hits[i];
				if (!(raycastHit.collider == null) && !Util.InHiearchyOf(raycastHit.collider.gameObject, Target.gameObject))
				{
					float num2 = Mathf.Clamp(distance - raycastHit.distance, 0f, distance);
					if (num2 > maxFix)
					{
						maxFix = num2;
					}
				}
			}
		}
	}
}
