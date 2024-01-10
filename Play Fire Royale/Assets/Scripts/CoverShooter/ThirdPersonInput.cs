// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ThirdPersonInput
// SourcesPostProcessor 
using ControlFreak2;
using System;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(ThirdPersonController))]
	public class ThirdPersonInput : MonoBehaviour
	{
		[Tooltip("Is character running instead of walking when moving.")]
		public bool FastMovement = true;

		[Tooltip("Is character slowing to to a walk when zooming in.")]
		public bool WalkWhenZooming = true;

		[Tooltip("Camera to rotate around the player. If set to none it is taken from the main camera.")]
		public ThirdPersonCamera CameraOverride;

		[Tooltip("Multiplier for horizontal camera rotation.")]
		[Range(0f, 10f)]
		public float HorizontalRotateSpeed = 2f;

		[Tooltip("Multiplier for vertical camera rotation.")]
		[Range(0f, 10f)]
		public float VerticalRotateSpeed = 1f;

		[Tooltip("Multiplier to rotation speeds when zooming in. Speed is already adjusted by the FOV difference.")]
		[Range(0f, 10f)]
		public float ZoomRotateMultiplier = 1f;

		[Tooltip("Is camera responding to mouse movement when the mouse cursor is unlocked.")]
		public bool RotateWhenUnlocked;

		[Tooltip("Maximum time in seconds to wait for a second tap to active rolling.")]
		public float DoubleTapDelay = 0.3f;

		[Tooltip("Keys to be pressed to activate custom actions.")]
		public CustomAction[] CustomActions;

		[Tooltip("Input is ignored when a disabler is active.")]
		public GameObject Disabler;

		private CharacterMotor _motor;

		private ThirdPersonController _controller;

		private CharacterInventory _inventory;

		private Camera _cachedCameraOwner;

		private ThirdPersonCamera _cachedCamera;

		private float _timeW;

		private float _timeA;

		private float _timeS;

		private float _timeD;

		private float _leftMoveIntensity = 1f;

		private float _rightMoveIntensity = 1f;

		private float _backMoveIntensity = 1f;

		private float _frontMoveIntensity = 1f;

		public ThirdPersonCamera Camera
		{
			get
			{
				if (CameraOverride != null)
				{
					return CameraOverride;
				}
				if (CameraManager.Main != _cachedCameraOwner)
				{
					_cachedCameraOwner = CameraManager.Main;
					if (_cachedCameraOwner == null)
					{
						_cachedCamera = null;
					}
					else
					{
						_cachedCamera = _cachedCameraOwner.GetComponent<ThirdPersonCamera>();
					}
				}
				return _cachedCamera;
			}
		}

		private int currentWeapon
		{
			get
			{
				if (_inventory == null || !_motor.IsEquipped)
				{
					return 0;
				}
				for (int i = 0; i < _inventory.Weapons.Length; i++)
				{
					if (_inventory.Weapons[i].IsTheSame(ref _motor.Weapon))
					{
						return i + 1;
					}
				}
				return 0;
			}
		}

		private float aimAngle => Util.HorizontalAngle(_controller.BodyTargetInput - base.transform.position);

		private void Awake()
		{
			_controller = GetComponent<ThirdPersonController>();
			_motor = GetComponent<CharacterMotor>();
			_inventory = GetComponent<CharacterInventory>();
			_controller.WaitForUpdateCall = true;
		}

		private void Update()
		{
			if (!(Disabler != null) || !Disabler.activeSelf)
			{
				UpdateCamera();
				UpdateTarget();
				UpdateCustomActions();
				UpdateMovement();
				UpdateWeapons();
				UpdateReload();
				UpdateRolling();
				UpdateAttack();
				UpdateGrenade();
				UpdateCrouching();
				UpdateClimbing();
				UpdateCover();
				UpdateJumping();
				_controller.ManualUpdate();
			}
		}

		protected virtual void UpdateCustomActions()
		{
			CustomAction[] customActions = CustomActions;
			for (int i = 0; i < customActions.Length; i++)
			{
				CustomAction customAction = customActions[i];
				if (CF2Input.GetKeyDown(customAction.Key))
				{
					if (customAction.Message != null && customAction.Message.Length > 0)
					{
						SendMessage(customAction.Message, SendMessageOptions.RequireReceiver);
					}
					if (customAction.Name != null && customAction.Name.Length > 0)
					{
						SendMessage("OnCustomAction", customAction.Name, SendMessageOptions.RequireReceiver);
					}
				}
			}
		}

		protected virtual void UpdateMovement()
		{
			Vector3 local = CF2Input.GetAxis("Horizontal") * Vector3.right + CF2Input.GetAxis("Vertical") * Vector3.forward;
			CharacterMovement movementInput = default(CharacterMovement);
			movementInput.Direction = getMovementDirection(local);
			if (WalkWhenZooming && _controller.ZoomInput)
			{
				movementInput.Magnitude = 0.5f;
				movementInput.IsSlowedDown = true;
			}
			else if ((_motor.ActiveWeapon.Gun != null || _motor.ActiveWeapon.HasMelee) && FastMovement)
			{
				if (CF2Input.GetButton("Run") && !_motor.IsCrouching)
				{
					movementInput.Magnitude = 2f;
				}
				else
				{
					movementInput.Magnitude = 1f;
				}
			}
			else if (CF2Input.GetButton("Run"))
			{
				movementInput.Magnitude = 1f;
			}
			else
			{
				movementInput.Magnitude = 0.5f;
			}
			_controller.MovementInput = movementInput;
		}

		protected virtual void UpdateClimbing()
		{
			if (!CF2Input.GetButtonDown("Climb"))
			{
				return;
			}
			Vector3 vector = CF2Input.GetAxis("Horizontal") * Vector3.right + CF2Input.GetAxis("Vertical") * Vector3.forward;
			if (vector.magnitude > float.Epsilon)
			{
				vector = Quaternion.Euler(0f, aimAngle, 0f) * vector.normalized;
				Cover climbableInDirection = _motor.GetClimbableInDirection(vector);
				if (climbableInDirection != null)
				{
					_controller.InputClimbOrVault(climbableInDirection);
				}
			}
		}

		protected virtual void UpdateCover()
		{
			if (CF2Input.GetButtonDown("TakeCover"))
			{
				_controller.InputTakeCover();
			}
		}

		protected virtual void UpdateJumping()
		{
			if (CF2Input.GetButtonDown("Jump"))
			{
				Vector3 vector = CF2Input.GetAxis("Horizontal") * Vector3.right + CF2Input.GetAxis("Vertical") * Vector3.forward;
				if (vector.magnitude > float.Epsilon)
				{
					_controller.InputJump(Util.HorizontalAngle(vector) + aimAngle);
				}
				else
				{
					_controller.InputJump();
				}
			}
		}

		protected virtual void UpdateCrouching()
		{
			if (CF2Input.GetButton("Crouch"))
			{
				_controller.InputCrouch();
			}
		}

		protected virtual void UpdateGrenade()
		{
			if (_motor.HasGrenadeInHand)
			{
				if (CF2Input.GetButtonDown("Fire"))
				{
					_controller.InputThrowGrenade();
				}
				if (CF2Input.GetButtonDown("Cancel"))
				{
					_controller.InputCancelGrenade();
				}
			}
			if (CF2Input.GetButton("Grenade"))
			{
				_controller.InputTakeGrenade();
			}
		}

		protected virtual void UpdateAttack()
		{
			if (CF2Input.GetButtonDown("Fire"))
			{
				_controller.FireInput = true;
			}
			if (CF2Input.GetButtonUp("Fire"))
			{
				_controller.FireInput = false;
			}
			if (CF2Input.GetButtonDown("Melee"))
			{
				_controller.InputMelee();
			}
			if (CF2Input.GetButtonDown("Zoom"))
			{
				_controller.ZoomInput = true;
			}
			if (CF2Input.GetButtonUp("Zoom"))
			{
				_controller.ZoomInput = false;
			}
			if (CF2Input.GetButtonDown("Block"))
			{
				_controller.BlockInput = true;
			}
			if (CF2Input.GetButtonUp("Block"))
			{
				_controller.BlockInput = false;
			}
			if (_controller.IsZooming)
			{
				if (CF2Input.GetButtonDown("Scope"))
				{
					_controller.ScopeInput = !_controller.ScopeInput;
				}
			}
			else
			{
				_controller.ScopeInput = false;
			}
		}

		protected virtual void UpdateRolling()
		{
			if (_timeW > 0f)
			{
				_timeW -= Time.deltaTime;
			}
			if (_timeA > 0f)
			{
				_timeA -= Time.deltaTime;
			}
			if (_timeS > 0f)
			{
				_timeS -= Time.deltaTime;
			}
			if (_timeD > 0f)
			{
				_timeD -= Time.deltaTime;
			}
			if (CF2Input.GetButtonDown("RollForward"))
			{
				if (_timeW > float.Epsilon)
				{
					Cover climbambleInDirection = _motor.GetClimbambleInDirection(aimAngle);
					if (climbambleInDirection != null)
					{
						_controller.InputClimbOrVault(climbambleInDirection);
					}
					else
					{
						roll(Vector3.forward);
					}
				}
				else
				{
					_timeW = DoubleTapDelay;
				}
			}
			if (CF2Input.GetButtonDown("RollLeft"))
			{
				if (_timeA > float.Epsilon)
				{
					Cover climbambleInDirection2 = _motor.GetClimbambleInDirection(aimAngle - 90f);
					if (climbambleInDirection2 != null)
					{
						_controller.InputClimbOrVault(climbambleInDirection2);
					}
					else
					{
						roll(-Vector3.right);
					}
				}
				else
				{
					_timeA = DoubleTapDelay;
				}
			}
			if (CF2Input.GetButtonDown("RollBackward"))
			{
				if (_timeS > float.Epsilon)
				{
					Cover climbambleInDirection3 = _motor.GetClimbambleInDirection(aimAngle + 180f);
					if (climbambleInDirection3 != null)
					{
						_controller.InputClimbOrVault(climbambleInDirection3);
					}
					else
					{
						roll(-Vector3.forward);
					}
				}
				else
				{
					_timeS = DoubleTapDelay;
				}
			}
			if (!CF2Input.GetButtonDown("RollRight"))
			{
				return;
			}
			if (_timeD > float.Epsilon)
			{
				Cover climbambleInDirection4 = _motor.GetClimbambleInDirection(aimAngle + 90f);
				if (climbambleInDirection4 != null)
				{
					_controller.InputClimbOrVault(climbambleInDirection4);
				}
				else
				{
					roll(Vector3.right);
				}
			}
			else
			{
				_timeD = DoubleTapDelay;
			}
		}

		protected virtual void UpdateWeapons()
		{
			if (CF2Input.GetKey(KeyCode.Alpha1))
			{
				_motor.InputCancelGrenade();
				inputWeapon(0);
			}
			if (CF2Input.GetKey(KeyCode.Alpha2))
			{
				_motor.InputCancelGrenade();
				inputWeapon(1);
			}
			if (CF2Input.GetKey(KeyCode.Alpha3))
			{
				_motor.InputCancelGrenade();
				inputWeapon(2);
			}
			if (CF2Input.GetKey(KeyCode.Alpha4))
			{
				_motor.InputCancelGrenade();
				inputWeapon(3);
			}
			if (CF2Input.GetKey(KeyCode.Alpha5))
			{
				_motor.InputCancelGrenade();
				inputWeapon(4);
			}
			if (CF2Input.GetKey(KeyCode.Alpha6))
			{
				_motor.InputCancelGrenade();
				inputWeapon(5);
			}
			if (CF2Input.GetKey(KeyCode.Alpha7))
			{
				_motor.InputCancelGrenade();
				inputWeapon(6);
			}
			if (CF2Input.GetKey(KeyCode.Alpha8))
			{
				_motor.InputCancelGrenade();
				inputWeapon(7);
			}
			if (CF2Input.GetKey(KeyCode.Alpha9))
			{
				_motor.InputCancelGrenade();
				inputWeapon(8);
			}
			if (CF2Input.GetKey(KeyCode.Alpha0))
			{
				_motor.InputCancelGrenade();
				inputWeapon(9);
			}
			Vector2 mouseScrollDelta = CF2Input.mouseScrollDelta;
			if (mouseScrollDelta.y < 0f)
			{
				if (currentWeapon == 0 && _inventory != null)
				{
					inputWeapon(_inventory.Weapons.Length);
				}
				else
				{
					inputWeapon(currentWeapon - 1);
				}
				return;
			}
			Vector2 mouseScrollDelta2 = CF2Input.mouseScrollDelta;
			if (mouseScrollDelta2.y > 0f)
			{
				if (_inventory != null && currentWeapon == _inventory.Weapons.Length)
				{
					inputWeapon(0);
				}
				else
				{
					inputWeapon(currentWeapon + 1);
				}
			}
		}

		private void inputWeapon(int index)
		{
			if (!(_inventory == null) || index <= 0)
			{
				if (index <= 0 || (_inventory != null && index > _inventory.Weapons.Length))
				{
					_controller.InputUnequip();
				}
				else if (_inventory != null && index <= _inventory.Weapons.Length)
				{
					_controller.InputEquip(_inventory.Weapons[index - 1]);
				}
			}
		}

		protected virtual void UpdateReload()
		{
			if (CF2Input.GetButton("Reload"))
			{
				_controller.InputReload();
			}
		}

		protected virtual void UpdateTarget()
		{
			if (_controller == null)
			{
				return;
			}
			ThirdPersonCamera camera = Camera;
			if (!(camera == null))
			{
				Vector3 vector = camera.CalculateAimTarget(includeRecoil: false);
				Vector3 closestStaticHit = Util.GetClosestStaticHit(camera.transform.position, vector, 0f);
				if (_motor.IsFiringFromCamera && _motor.ActiveWeapon.Gun != null)
				{
					Vector3 target = camera.CalculateAimTarget(includeRecoil: true);
					Vector3 closestStaticHit2 = Util.GetClosestStaticHit(camera.transform.position, target, 0f);
					_motor.ActiveWeapon.Gun.SetupRaycastThisFrame(camera.transform.position, closestStaticHit2);
				}
				_controller.BodyTargetInput = vector;
				_controller.AimTargetInput = closestStaticHit;
				_controller.GrenadeHorizontalAngleInput = Util.HorizontalAngle(camera.transform.forward);
				ThirdPersonController controller = _controller;
				Vector3 forward = camera.transform.forward;
				controller.GrenadeVerticalAngleInput = Mathf.Asin(forward.y) * 180f / (float)Math.PI;
			}
		}

		protected virtual void UpdateCamera()
		{
			ThirdPersonCamera camera = Camera;
			if (camera == null)
			{
				return;
			}
			if (CFCursor.lockState == CursorLockMode.Locked || RotateWhenUnlocked)
			{
				float num = 1f;
				if (_motor != null)
				{
					BaseGun gun = _motor.ActiveWeapon.Gun;
					if (_controller.IsScoping && gun != null)
					{
						num = ZoomRotateMultiplier * (1f - gun.Zoom / camera.StateFOV);
					}
					else if (_controller.IsZooming)
					{
						num = ZoomRotateMultiplier * (1f - camera.Zoom / camera.StateFOV);
					}
				}
				camera.Horizontal += CF2Input.GetAxis("Mouse X") * HorizontalRotateSpeed * num;
				camera.Vertical -= CF2Input.GetAxis("Mouse Y") * VerticalRotateSpeed * num;
				camera.UpdatePosition();
			}
			camera.HorizontalRecoil = _motor.HorizontalRecoil;
			camera.VerticalRecoil = _motor.VerticalRecoil;
			camera.UpdatePosition();
			_motor.InputVerticalMeleeAngle(camera.Vertical);
		}

		private void roll(Vector3 local)
		{
			Vector3 movementDirection = getMovementDirection(local);
			if (movementDirection.sqrMagnitude > float.Epsilon)
			{
				_controller.InputRoll(Util.HorizontalAngle(movementDirection));
			}
		}

		private Vector3 getMovementDirection(Vector3 local)
		{
			Vector3 vector = _controller.BodyTargetInput - base.transform.position;
			vector.y = 0f;
			vector.Normalize();
			float angle;
			if (_motor.IsInCover)
			{
				angle = Util.HorizontalAngle(vector);
				angle = (_motor.Cover.IsLeft(angle, 45f) ? Util.HorizontalAngle(_motor.Cover.Left) : (_motor.Cover.IsRight(angle, 45f) ? Util.HorizontalAngle(_motor.Cover.Right) : ((!_motor.Cover.IsBack(angle, 45f)) ? Util.HorizontalAngle(_motor.Cover.Forward) : Util.HorizontalAngle(-_motor.Cover.Forward))));
				vector = Util.HorizontalVector(angle);
			}
			else
			{
				angle = Util.HorizontalAngle(vector);
			}
			Vector3 vector2 = Vector3.Cross(Vector3.up, vector);
			Util.Lerp(ref _leftMoveIntensity, (!_motor.IsFreeToMove(-vector2)) ? 0f : 1f, 4f);
			Util.Lerp(ref _rightMoveIntensity, (!_motor.IsFreeToMove(vector2)) ? 0f : 1f, 4f);
			Util.Lerp(ref _backMoveIntensity, (!_motor.IsFreeToMove(-vector)) ? 0f : 1f, 4f);
			Util.Lerp(ref _frontMoveIntensity, (!_motor.IsFreeToMove(vector)) ? 0f : 1f, 4f);
			if (local.x < -1.401298E-45f)
			{
				local.x *= _leftMoveIntensity;
			}
			if (local.x > float.Epsilon)
			{
				local.x *= _rightMoveIntensity;
			}
			if (local.z < -1.401298E-45f)
			{
				local.z *= _backMoveIntensity;
			}
			if (local.z > float.Epsilon)
			{
				local.z *= _frontMoveIntensity;
			}
			return Quaternion.Euler(0f, angle, 0f) * local;
		}
	}
}
