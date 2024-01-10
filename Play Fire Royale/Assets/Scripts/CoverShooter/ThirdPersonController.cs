// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ThirdPersonController
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class ThirdPersonController : MonoBehaviour
	{
		public enum Mode
		{
			Default,
			Cover,
			Sprint,
			Aim,
			Grenade,
			Melee
		}

		[Tooltip("Determines if the character takes cover automatically instead of waiting for player input.")]
		public bool AutoTakeCover = true;

		[Tooltip("Time in seconds after a potential cover has been detected when the character automatically enters it.")]
		public float CoverEnterDelay = 0.1f;

		[Tooltip("Is the character always aiming in camera direction when not in cover.")]
		public bool AlwaysAim;

		[Tooltip("Should the character aim when walking, if turned off it will only aim when zooming in.")]
		public bool AimWhenWalking;

		[Tooltip("Should the character start crouching near closing in to a low cover.")]
		public bool CrouchNearCovers = true;

		[Tooltip("Will the character turn immediatelly when aiming.")]
		public bool ImmediateTurns = true;

		[Tooltip("Radius at which enemy actors are detected in melee mode.")]
		public float MeleeRadius = 4f;

		[Tooltip("Distance to maintain against melee targets.")]
		public float MinMeleeDistance = 1.5f;

		[Tooltip("How long to continue aiming after no longer needed.")]
		public float AimSustain = 0.4f;

		[Tooltip("Time in seconds to keep the gun down when starting to move.")]
		public float NoAimSustain = 0.14f;

		[Tooltip("Cancel get hit animations upon player input.")]
		public bool CancelHurt = true;

		[Tooltip("Degrees to add when aiming a grenade vertically.")]
		public float ThrowAngleOffset = 30f;

		[Tooltip("How high can the player throw the grenade.")]
		public float MaxThrowAngle = 45f;

		[Tooltip("Time in seconds to wait after landing before AlwaysAim activates again.")]
		public float PostLandAimDelay = 0.4f;

		[Tooltip("Time in seconds to wait before lifting an arm when running with a pistol.")]
		public float ArmLiftDelay = 1.5f;

		[Tooltip("Prefab to instantiate to display grenade explosion preview.")]
		public GameObject ExplosionPreview;

		[Tooltip("Prefab to instantiate to display grenade path preview.")]
		public GameObject PathPreview;

		[Tooltip("Scope object and component that's enabled and maintained when using scope.")]
		public Image Scope;

		[HideInInspector]
		public bool FireInput;

		[HideInInspector]
		public bool ZoomInput;

		[HideInInspector]
		public bool ScopeInput;

		[HideInInspector]
		public bool BlockInput;

		[HideInInspector]
		public Vector3 BodyTargetInput;

		[HideInInspector]
		public Vector3 AimTargetInput;

		[HideInInspector]
		public float GrenadeHorizontalAngleInput;

		[HideInInspector]
		public float GrenadeVerticalAngleInput;

		[HideInInspector]
		public CharacterMovement MovementInput;

		[HideInInspector]
		public bool WaitForUpdateCall;

		private Actor _actor;

		private CharacterMotor _motor;

		private Mode _mode;

		private bool _wantsToThrowGrenade;

		private bool _wantsToAim;

		private bool _wantsToHit;

		private bool _wantsToRoll;

		private bool _wantsToReload;

		private bool _wantsToUnequip;

		private WeaponDescription _wantsToEquip;

		private bool _wantsToTakeGrenade;

		private bool _wantsToCancelGrenade;

		private bool _wantsToCrouch;

		private bool _wantsToTakeCover;

		private bool _wantsToJump;

		private Cover _wantsToClimbOrVault;

		private bool _isZooming;

		private bool _isScoping;

		private float _rollAngle;

		private float _jumpAngle;

		private bool _hasJumpAngle;

		private float _coverDelayWait;

		private float _aimSustain;

		private float _noAimSustain;

		private float _postSprintNoAutoAim;

		private float _armLiftTimer;

		private float _armLiftRetain;

		private float _postLandWait;

		private GameObject _explosionPreview;

		private GameObject _pathPreview;

		private Vector3[] _grenadePath = new Vector3[128];

		private int _grenadePathLength;

		private bool _hasGrenadePath;

		private Actor _meleeTarget;

		public bool IsZooming => _isZooming && _motor.IsAlive && _mode == Mode.Aim && (((!_motor.IsInCover || _motor.IsReloadingAndNotAiming) && _motor.IsInCameraAimableState) || (_motor.IsInCover && !_motor.IsReloadingAndNotAiming && _motor.IsInAimableState));

		public bool IsScoping => ScopeInput && IsZooming && CouldScope && _motor.IsWeaponScopeReady && _mode == Mode.Aim;

		public bool IsMelee => _mode == Mode.Melee;

		public bool CouldScope
		{
			get
			{
				BaseGun gun = _motor.ActiveWeapon.Gun;
				return gun != null && gun.Scope != null;
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		public void InputTakeGrenade()
		{
			_wantsToTakeGrenade = true;
		}

		public void InputCancelGrenade()
		{
			_wantsToCancelGrenade = true;
		}

		public void InputTakeCover()
		{
			_wantsToTakeCover = true;
		}

		public void InputReload()
		{
			_wantsToReload = true;
		}

		public void InputJump()
		{
			_wantsToJump = true;
			_hasJumpAngle = false;
		}

		public void InputJump(float angle)
		{
			_wantsToJump = true;
			_hasJumpAngle = true;
			_jumpAngle = angle;
		}

		public void InputUnequip()
		{
			_wantsToUnequip = true;
		}

		public void InputEquip(WeaponDescription weapon)
		{
			_wantsToEquip = weapon;
		}

		public void InputCrouch()
		{
			_wantsToCrouch = true;
		}

		public void InputThrowGrenade()
		{
			_wantsToThrowGrenade = true;
		}

		public void InputAim()
		{
			_wantsToAim = true;
		}

		public void InputMelee()
		{
			_wantsToHit = true;
		}

		public void InputRoll(float angle)
		{
			_wantsToRoll = true;
			_rollAngle = angle;
		}

		public void InputClimbOrVault(Cover cover)
		{
			_wantsToClimbOrVault = cover;
		}

		private void OnEnable()
		{
			if (_motor != null && AlwaysAim && !_motor.ActiveWeapon.IsNull)
			{
				_motor.InputImmediateAim();
			}
		}

		private void LateUpdate()
		{
			if (!WaitForUpdateCall)
			{
				ManualUpdate();
			}
		}

		public bool ManualUpdate()
		{
			if (_mode != Mode.Grenade)
			{
				destroyGrenadePreview();
			}
			checkLanded();
			switch (_mode)
			{
			case Mode.Default:
				if (_motor.HasGrenadeInHand)
				{
					return transitionAndPerform(Mode.Grenade);
				}
				if (updateIsAiming())
				{
					return transitionAndPerform(Mode.Aim);
				}
				if (isSprinting())
				{
					return transitionAndPerform(Mode.Sprint);
				}
				if (updateIsMelee())
				{
					return transitionAndPerform(Mode.Melee);
				}
				if (_motor.IsInCover)
				{
					return transitionAndPerform(Mode.Cover);
				}
				checkArmLift();
				checkReload();
				checkUnzoom();
				checkEquipment();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(1f);
				checkCover();
				checkGrenade();
				checkCrouch();
				checkMelee();
				break;
			case Mode.Sprint:
				if (_motor.HasGrenadeInHand)
				{
					return transitionAndPerform(Mode.Grenade);
				}
				if (updateIsAiming())
				{
					return transitionAndPerform(Mode.Aim);
				}
				if (!isSprinting())
				{
					return transitionAndPerform(Mode.Default);
				}
				lowerArms();
				checkReload();
				checkUnzoom();
				checkEquipment();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(2f);
				checkCover();
				checkGrenade();
				checkCrouch();
				break;
			case Mode.Cover:
				if (_motor.HasGrenadeInHand)
				{
					return transitionAndPerform(Mode.Grenade);
				}
				if (updateIsAiming())
				{
					return transitionAndPerform(Mode.Aim);
				}
				if (isSprinting())
				{
					return transitionAndPerform(Mode.Sprint);
				}
				if (updateIsMelee())
				{
					return transitionAndPerform(Mode.Melee);
				}
				if (!_motor.IsInCover)
				{
					return transitionAndPerform(Mode.Default);
				}
				lowerArms();
				checkMelee();
				checkReload();
				checkUnzoom();
				checkEquipment();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(1f);
				checkGrenade();
				checkCrouch();
				break;
			case Mode.Aim:
				if (!updateIsAiming())
				{
					return transitionAndPerform(Mode.Default);
				}
				_noAimSustain = 0f;
				if (AimWhenWalking && MovementInput.IsMoving)
				{
					_aimSustain = AimSustain;
				}
				else
				{
					_aimSustain -= Time.deltaTime;
				}
				checkZoom();
				checkEquipment();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(1f);
				checkCover();
				checkGrenade();
				checkCrouch();
				checkReload();
				checkMelee();
				if (CancelHurt)
				{
					_motor.CancelAndPreventGetHit(0.3f);
				}
				liftArms();
				_motor.SetBodyTarget(BodyTargetInput);
				_motor.SetAimTarget(AimTargetInput);
				if (ImmediateTurns)
				{
					_motor.InputPossibleImmediateTurn();
				}
				if (_motor.IsInCover)
				{
					_motor.InputAimWhenLeavingCover();
				}
				_motor.InputAim();
				if (_motor.IsWeaponReady && FireInput)
				{
					_aimSustain = AimSustain;
					BaseGun gun = _motor.ActiveWeapon.Gun;
					if (gun != null && gun.LoadedBulletsLeft <= 0)
					{
						_motor.InputReload();
					}
					else
					{
						_motor.InputFire();
					}
				}
				if (_motor.IsWeaponScopeReady && ZoomInput)
				{
					_aimSustain = AimSustain;
					_motor.InputZoom();
					if (_isScoping)
					{
						_motor.InputScope();
					}
				}
				break;
			case Mode.Grenade:
				if (!_motor.HasGrenadeInHand)
				{
					return transitionAndPerform(Mode.Default);
				}
				if (_motor.IsReadyToThrowGrenade && _motor.CurrentGrenade != null)
				{
					GrenadeDescription desc = default(GrenadeDescription);
					desc.Gravity = _motor.Grenade.Gravity;
					desc.Duration = _motor.PotentialGrenade.Timer;
					desc.Bounciness = _motor.PotentialGrenade.Bounciness;
					float num = Mathf.Min(GrenadeVerticalAngleInput + ThrowAngleOffset, MaxThrowAngle);
					float num2 = _motor.Grenade.MaxVelocity;
					if (num < 45f)
					{
						num2 *= Mathf.Clamp01((num + 15f) / 45f);
					}
					_grenadePathLength = GrenadePath.Calculate(GrenadePath.Origin(_motor, GrenadeHorizontalAngleInput), GrenadeHorizontalAngleInput, num, num2, desc, _grenadePath, _motor.Grenade.Step);
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
					destroyGrenadePreview();
				}
				if (_hasGrenadePath && _wantsToThrowGrenade)
				{
					if (ImmediateTurns)
					{
						_motor.InputPossibleImmediateTurn();
					}
					_motor.SetBodyTarget(BodyTargetInput);
					_motor.SetAimTarget(BodyTargetInput);
					_motor.InputThrowGrenade(_grenadePath, _grenadePathLength, _motor.Grenade.Step);
				}
				if (_wantsToCancelGrenade)
				{
					_motor.InputCancelGrenade();
				}
				lowerArms();
				checkZoom();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(2f);
				checkCover();
				checkCrouch();
				break;
			case Mode.Melee:
			{
				if (_motor.HasGrenadeInHand)
				{
					return transitionAndPerform(Mode.Grenade);
				}
				if (isSprinting())
				{
					return transitionAndPerform(Mode.Sprint);
				}
				if (!updateIsMelee())
				{
					return transitionAndPerform(Mode.Default);
				}
				checkUnzoom();
				checkEquipment();
				checkJump();
				checkRoll();
				checkClimbOrVault();
				checkMovement(2f);
				checkGrenade();
				checkCrouch();
				checkMelee();
				if (!(_meleeTarget != null))
				{
					break;
				}
				_motor.SetBodyTarget(_meleeTarget.transform.position);
				_motor.SetAimTarget(_meleeTarget.transform.position + Vector3.up * 1.5f);
				_motor.InputMeleeTarget(_meleeTarget.transform.position);
				if (MovementInput.IsMoving)
				{
					break;
				}
				Vector3 a = _meleeTarget.transform.position - _motor.transform.position;
				float magnitude = a.magnitude;
				if (!(magnitude < MinMeleeDistance))
				{
					break;
				}
				Character character = Characters.Get(_meleeTarget.gameObject);
				if (character.Motor == null || !character.Motor.IsPerformingMelee)
				{
					if (magnitude < MinMeleeDistance * 0.35f)
					{
						_motor.InputMovement(new CharacterMovement(-a / magnitude, 1f, 0.2f));
					}
					else
					{
						_motor.InputMovement(new CharacterMovement(-a / magnitude, 0.5f, 0.2f));
					}
				}
				break;
			}
			}
			_wantsToThrowGrenade = false;
			_wantsToAim = false;
			_wantsToHit = false;
			_wantsToRoll = false;
			_wantsToReload = false;
			_wantsToUnequip = false;
			_wantsToTakeGrenade = false;
			_wantsToCancelGrenade = false;
			_wantsToCrouch = false;
			_wantsToTakeCover = false;
			_wantsToJump = false;
			_wantsToClimbOrVault = null;
			if (!_wantsToEquip.IsNull)
			{
				_wantsToEquip = default(WeaponDescription);
			}
			return true;
		}

		private bool transitionAndPerform(Mode mode)
		{
			_mode = mode;
			return ManualUpdate();
		}

		private bool isSprinting()
		{
			if (!MovementInput.IsMoving || MovementInput.Magnitude <= 1.1f || _motor.IsCrouching || _motor.IsClimbingOrVaulting || _motor.IsRolling || !_motor.IsGrounded || _motor.IsInCover || _motor.HasGrenadeInHand)
			{
				return false;
			}
			if ((FireInput & _motor.IsWeaponReady) || (ZoomInput && _motor.IsWeaponScopeReady))
			{
				return false;
			}
			return true;
		}

		private bool updateIsAiming()
		{
			if (_motor.HasGrenadeInHand)
			{
				return false;
			}
			if (_postLandWait > float.Epsilon)
			{
				return false;
			}
			if (_wantsToAim && _motor.IsWeaponReady)
			{
				return true;
			}
			if (!_motor.IsGrounded)
			{
				return false;
			}
			if (_motor.EquippedWeapon.Gun == null)
			{
				return false;
			}
			if (!_motor.IsInCover)
			{
				if (AlwaysAim)
				{
					return !isSprinting();
				}
				if (AimWhenWalking && MovementInput.IsMoving)
				{
					if (isSprinting())
					{
						return false;
					}
					if (!(_noAimSustain < NoAimSustain))
					{
						return true;
					}
					_noAimSustain += Time.deltaTime;
				}
				else
				{
					_noAimSustain = 0f;
				}
			}
			if ((FireInput & _motor.IsWeaponReady) || (ZoomInput && _motor.IsWeaponScopeReady))
			{
				return true;
			}
			if (_motor.IsInCover)
			{
				return false;
			}
			return _aimSustain > float.Epsilon;
		}

		private bool updateIsMelee()
		{
			_meleeTarget = null;
			WeaponDescription equippedWeapon = _motor.EquippedWeapon;
			if (!equippedWeapon.HasMelee || equippedWeapon.Gun != null)
			{
				return false;
			}
			float num = 0f;
			for (int i = 0; i < AIUtil.FindActors(_motor.transform.position, MeleeRadius, _actor); i++)
			{
				Actor actor = AIUtil.Actors[i];
				if (actor.Side != _actor.Side)
				{
					float num2 = Vector3.Distance(_motor.transform.position, actor.transform.position);
					if (_meleeTarget == null || num2 < num)
					{
						_meleeTarget = actor;
						num = num2;
					}
				}
			}
			return _meleeTarget != null;
		}

		private void checkLanded()
		{
			if (_motor.IsGrounded)
			{
				if (_postLandWait >= 0f)
				{
					_postLandWait -= Time.deltaTime;
				}
			}
			else
			{
				_postLandWait = PostLandAimDelay;
			}
		}

		private void destroyGrenadePreview()
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

		private void lowerArms()
		{
			_armLiftTimer = 0f;
			_armLiftRetain = 0f;
		}

		private void liftArms()
		{
			_armLiftTimer = ArmLiftDelay;
			_armLiftRetain = 0f;
		}

		private void checkArmLift()
		{
			if (_motor.IsInProcess && !_motor.CanMoveInProcess)
			{
				lowerArms();
			}
			else if (!_motor.IsGrounded)
			{
				lowerArms();
			}
			else if ((MovementInput.IsSlowedDown || MovementInput.Magnitude > 0.6f) && MovementInput.Magnitude < 1.1f && MovementInput.IsMoving && !_motor.IsClimbingOrVaulting)
			{
				_armLiftTimer += Time.deltaTime;
				_armLiftRetain = 0.1f;
			}
			else if (_armLiftRetain > float.Epsilon)
			{
				_armLiftRetain -= Time.deltaTime;
			}
			else
			{
				_armLiftTimer = Mathf.Clamp01(_armLiftTimer - Time.deltaTime);
			}
			if (_armLiftTimer >= ArmLiftDelay - float.Epsilon)
			{
				_motor.InputArmLift();
			}
		}

		private void checkZoom()
		{
			if (ZoomInput && !_isZooming)
			{
				_isZooming = true;
				_motor.NotifyZoom();
			}
			else if (!ZoomInput && _isZooming)
			{
				_isZooming = false;
				_motor.NotifyUnzoom();
			}
			if (ScopeInput && !_isScoping)
			{
				_isScoping = true;
				_motor.NotifyScope();
			}
			else if (!ScopeInput && _isScoping)
			{
				_isScoping = false;
				_motor.NotifyUnscope();
			}
			if (Scope != null && Scope.gameObject.activeSelf != IsScoping)
			{
				Scope.gameObject.SetActive(IsScoping);
				BaseGun gun = _motor.ActiveWeapon.Gun;
				if (Scope.gameObject.activeSelf && gun != null)
				{
					Scope.sprite = gun.Scope;
				}
			}
		}

		private void checkMelee()
		{
			WeaponDescription equippedWeapon = _motor.EquippedWeapon;
			if (equippedWeapon.HasMelee)
			{
				Vector3 target = (!(_meleeTarget != null)) ? AimTargetInput : _meleeTarget.transform.position;
				if (_wantsToHit)
				{
					_motor.InputMelee(target);
				}
				else if (FireInput && equippedWeapon.Gun == null)
				{
					_motor.InputMelee(target);
				}
				else if (BlockInput && equippedWeapon.Gun == null && !_motor.IsPerformingMelee)
				{
					_motor.InputBlock();
				}
			}
		}

		private void checkUnzoom()
		{
			if (_isZooming)
			{
				_motor.NotifyUnzoom();
				_isZooming = false;
			}
			if (_isScoping)
			{
				_motor.NotifyUnscope();
				_isScoping = false;
			}
			if (Scope != null && Scope.gameObject.activeSelf != IsScoping)
			{
				Scope.gameObject.SetActive(IsScoping);
			}
		}

		private void checkEquipment()
		{
			if (!_wantsToEquip.IsNull)
			{
				_motor.CancelAndPreventGetHit(0.3f);
				_motor.IsEquipped = true;
				_motor.Weapon = _wantsToEquip;
			}
			else if (_wantsToUnequip)
			{
				_motor.IsEquipped = false;
			}
		}

		private void checkJump()
		{
			if (_wantsToJump)
			{
				if (_hasJumpAngle)
				{
					_motor.InputJump(_jumpAngle, 1f);
					return;
				}
				CharacterMotor motor = _motor;
				Vector3 eulerAngles = _motor.transform.eulerAngles;
				motor.InputJump(eulerAngles.y, 0f);
			}
		}

		private void checkRoll()
		{
			if (_wantsToRoll)
			{
				if (CancelHurt)
				{
					_motor.CancelAndPreventGetHit(0.3f);
				}
				Vector3 a = Util.Vector(_rollAngle, 0f);
				_motor.SetBodyTarget(_motor.transform.position + a * 100f);
				_motor.InputRoll(_rollAngle);
			}
		}

		private void checkClimbOrVault()
		{
			if (!(_wantsToClimbOrVault == null))
			{
				if (CancelHurt)
				{
					_motor.CancelAndPreventGetHit(0.3f);
				}
				_motor.InputClimbOrVault(_wantsToClimbOrVault);
			}
		}

		private void checkMovement(float max)
		{
			CharacterMovement movementInput = MovementInput;
			if (movementInput.Magnitude > max)
			{
				movementInput.Magnitude = max;
			}
			_motor.InputMovement(movementInput);
			if (movementInput.IsMoving)
			{
				if (CancelHurt)
				{
					_motor.CancelAndPreventGetHit(0.1f);
				}
				_motor.SetBodyTarget(BodyTargetInput);
				_motor.SetAimTarget(AimTargetInput);
			}
		}

		private void checkReload()
		{
			if (_wantsToReload)
			{
				BaseGun gun = _motor.ActiveWeapon.Gun;
				if (gun != null)
				{
					_motor.InputReload();
				}
			}
		}

		private void checkCover()
		{
			if (AutoTakeCover)
			{
				_motor.InputImmediateCoverSearch();
			}
			if (_wantsToTakeCover)
			{
				_motor.InputTakeCover();
			}
			if (AutoTakeCover && _coverDelayWait >= CoverEnterDelay && _motor.PotentialCover != null)
			{
				_motor.InputTakeCover();
			}
			if (AutoTakeCover && CrouchNearCovers)
			{
				_motor.InputCrouchNearCover();
			}
			if (_motor.PotentialCover != null)
			{
				_coverDelayWait += Time.deltaTime;
			}
			else
			{
				_coverDelayWait = 0f;
			}
		}

		private void checkGrenade()
		{
			if (_wantsToTakeGrenade)
			{
				if (CancelHurt)
				{
					_motor.CancelAndPreventGetHit(0.3f);
				}
				_motor.InputTakeGrenade();
			}
		}

		private void checkCrouch()
		{
			if (_wantsToCrouch)
			{
				if (!_motor.IsCrouching)
				{
					_motor.CancelAndPreventGetHit(0.3f);
				}
				_motor.InputCrouch();
			}
		}
	}
}
