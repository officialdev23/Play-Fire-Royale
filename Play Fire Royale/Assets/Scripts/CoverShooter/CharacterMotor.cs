// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterMotor
// SourcesPostProcessor 
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CapsuleCollider))]
	[RequireComponent(typeof(Animator))]
	[RequireComponent(typeof(Rigidbody))]
	public class CharacterMotor : MonoBehaviour
	{
		private enum WalkMode
		{
			none,
			walk,
			run,
			sprint
		}

		[Tooltip("Controls wheter the character is in a state of death.")]
		public bool IsAlive = true;

		[Tooltip("Speed multiplier for the movement speed. Adjusts animations.")]
		public float Speed = 1f;

		[Tooltip("Multiplies movement speed without adjusting animations.")]
		public float MoveMultiplier = 1f;

		[Tooltip("Toggles character's ability to run. Used by the CharacterStamina.")]
		public bool CanRun = true;

		[Tooltip("Toggles character's ability to run. Used by the CharacterStamina.")]
		public bool CanSprint = true;

		[Tooltip("Distance below feet to check for ground.")]
		[Range(0f, 1f)]
		public float GroundThreshold = 0.3f;

		[Tooltip("Minimal height to trigger state of falling. It’s ignored when jumping over gaps.")]
		[Range(0f, 10f)]
		public float FallThreshold = 2f;

		[Tooltip("Movement to obstacles closer than this is ignored.")]
		[Range(0f, 2f)]
		public float ObstacleDistance = 0.05f;

		[Tooltip("Gravity force applied to this character.")]
		public float Gravity = 10f;

		[Tooltip("Degrees recovered per second after a recoil.")]
		public float RecoilRecovery = 17f;

		[Tooltip("Sets the origin of bullet raycasts, either a camera or an end of a gun.")]
		public bool IsFiringFromCamera = true;

		[Tooltip("Gun accuracy increase when zooming in. Multiplier gun error.")]
		public float ZoomErrorMultiplier = 0.75f;

		[Tooltip("Capsule height when crouching.")]
		public float CrouchHeight = 1.5f;

		[Tooltip("How long it takes for the animator to go from standing to full speed when issued a move command.")]
		public float AccelerationDamp = 1f;

		[Tooltip("How much the animator keeps moving after the character stops getting move commands.")]
		public float DeccelerationDamp = 3f;

		public const float MinSlope = 26f;

		[Tooltip("Slope angle at which the character's velocity reaches zero when moving up a cliff.")]
		[Range(26f, 90f)]
		public float MaxSlope = 60f;

		[Tooltip("Damage multiplier for weapons.")]
		public float DamageMultiplier = 1f;

		[Tooltip("Should the character hold the weapon in their hands. Change is not immediate.")]
		public bool IsEquipped = true;

		[Tooltip("Weapon description of the weapon the character is to equip.")]
		public WeaponDescription Weapon = WeaponDescription.Default();

		[Tooltip("Deprecated. Use Upgrade Weapon List button to update to the newer version of the asset.")]
		[Obsolete("Deprecated. Use Upgrade Weapon List button to update to the newer version of the asset.")]
		[HideInInspector]
		public WeaponDescription[] Weapons;

		public GrenadeSettings Grenade = GrenadeSettings.Default();

		[Tooltip("IK settings for the character.")]
		public IKSettings IK = IKSettings.Default();

		[Tooltip("Settings for cover behaviour.")]
		public CoverSettings CoverSettings = CoverSettings.Default();

		[Tooltip("Settings for climbing.")]
		public ClimbSettings ClimbSettings = ClimbSettings.Default();

		[Tooltip("Settings for climbing.")]
		public VaultSettings VaultSettings = VaultSettings.Default();

		[Tooltip("Settings for jumping.")]
		public JumpSettings JumpSettings = JumpSettings.Default();

		[Tooltip("Settings for rolling.")]
		public RollSettings RollSettings = RollSettings.Default();

		[Tooltip("Settings for aiming.")]
		public AimSettings AimSettings = AimSettings.Default();

		[Tooltip("Settings for turning.")]
		public TurnSettings TurnSettings = TurnSettings.Default();

		[Tooltip("Settings for camera pivot positions based on shoulders.")]
		public ShoulderSettings ShoulderSettings = ShoulderSettings.Default();

		[Tooltip("Settings for hit response IK.")]
		public HitResponseSettings HitResponseSettings = HitResponseSettings.Default();

		public Action<float> StandingHeightChanged;

		public Action<float> CurrentHeightChanged;

		public Action WeaponChangeStarted;

		public Action WeaponChanged;

		public Action FireStarted;

		public Action FireStopped;

		public Action ReloadStarted;

		public Action FullyLoaded;

		public Action BulletLoaded;

		public Action Pumped;

		public Action<Hit> SuccessfullyHit;

		public Action<Cover> EnteredCover;

		public Action ExitedCover;

		public Action Resurrected;

		public Action Died;

		public Action UsedTool;

		public Action UsedToolAlternate;

		public Action Jumped;

		public Action Stepped;

		public Action Landed;

		public Action Zoomed;

		public Action Unzoomed;

		public Action Scoped;

		public Action Unscoped;

		internal bool internalIsWalkingAnimation;

		internal bool internalIsCoverAnimation;

		internal bool internalIsGrenadeAnimation;

		internal bool internalIsToolAnimation;

		internal static Dictionary<Animator, CharacterMotor> animatorToMotorMap = new Dictionary<Animator, CharacterMotor>();

		private WalkMode _lastWalkMode;

		private bool _hasRegistered;

		private CapsuleCollider _capsule;

		private Rigidbody _body;

		private Animator _animator;

		private Visibility[] _visibility;

		private Actor _actor;

		private CharacterCamera _cameraToLateUpdate;

		private CharacterIK _ik;

		private CoverState _cover;

		private Cover _potentialCover;

		private Cover _lastNotifiedCover;

		private Renderer[] _renderers;

		private int _targetLayer;

		private Vector3 _lastKnownPosition;

		private float _previousCapsuleHeight;

		private bool _isAimingPrecisely;

		private bool _isMoving;

		private bool _isMovingAwayFromCover;

		private Vector3 _moveFromCoverPosition;

		private Vector3 _moveFromCoverDirection;

		private bool _isWeaponBlocked;

		private bool _coverOffsetSideIsRight;

		private bool _canAimInThisOffsetAnimationOrIsAtTheEndOfIt;

		private bool _isGrenadeTakenOut;

		private bool _isThrowing;

		private bool _hasBeganThrowAnimation;

		private bool _isGoingToThrowLeft;

		private bool _hasThrown;

		private float _throwBodyAngle;

		private float _throwAngle;

		private Vector3 _throwTarget;

		private Vector3 _throwVelocity;

		private Vector3 _throwOrigin;

		private bool _hasCrouchCover;

		private Vector3 _crouchCoverPosition;

		private bool _wantsToRotateSmoothly;

		private bool _wantsToCrouchNearCovers;

		private bool _stopAimingWhenEnteringCover;

		private bool _isPerformingCustomAction;

		private bool _isInProcess;

		private CharacterProcess _process;

		private bool _isGrounded = true;

		private bool _wasGrounded;

		private bool _isFalling;

		private float _verticalRecoil;

		private float _horizontalRecoil;

		private bool _wasAimingGun;

		private bool _wantsToZoom;

		private bool _wantedToZoom;

		private bool _wantsToScope;

		private bool _wantedToScope;

		private bool _wantsToMirror;

		private bool _isAimingThroughCoverPlane;

		private float _coverPlaneAngle;

		private bool _hasCoverPlaneAngle;

		private bool _needToEnterCoverByWalkingToIt;

		private bool _immediateAim;

		private bool _immediateIdle;

		private float _aimTimer;

		private bool _hasAimTarget;

		private float _bodyTurnSpeed = 10f;

		private Vector3 _bodyTarget;

		private Vector3 _aimTarget;

		private Vector3 _currentBodyTarget;

		private float _horizontalAngle;

		private float _verticalAngle;

		private float _horizontalAngleDiff;

		private bool _wouldTurnImmediately;

		private float _verticalMeleeAngle;

		private float _currentAnimatedAngle;

		private float _stepCursor;

		private float _currentStep;

		private float _minAnimatedStep = 20f;

		private float _maxAnimatedStep = 90f;

		private float _stepDuration = 0.15f;

		private bool _wantsToTakeCover;

		private bool _wantsToImmediatelyUpdatePotentialCover;

		private bool _wasMovingInCover;

		private CoverAimState _coverAim;

		private Vector3 _coverOffset;

		private Vector3 _coverOffsetSide;

		private Vector3 _coverOffsetBack;

		private Vector3 _coverOffsetSideTarget;

		private Vector3 _coverOffsetBackTarget;

		private CoverOffsetState _sideOffset;

		private CoverOffsetState _backOffset;

		private Vector3 _initialOffsetPosition;

		private WeaponDescription _equippedWeapon;

		private WeaponDescription _equippingWeapon;

		private WeaponEquipState _weaponEquipState;

		private bool _isUnequippedButGoingToGrab;

		private float _weaponGrabTimer;

		private float _movementInput;

		private float _coverTime;

		private float _coverUpdateTimer;

		private bool _wantsToSprint;

		private bool _useSprintingAnimation;

		private float _sprintAnimationOffDelay;

		private bool _isClimbing;

		private Vector3 _climbDirection;

		private bool _isClimbingAVault;

		private Cover _wantsToClimbCover;

		private float _climbHeight;

		private float _climbAngle;

		private float _climbTime;

		private Vector3 _climbOffset;

		private float _ignoreFallTimer;

		private float _normalizedClimbTime;

		private float _vaultPosition;

		private bool _isUsingWeapon;

		private bool _isUsingWeaponAlternate;

		private bool _keepUsingWeapon;

		private bool _wasWeaponUsed;

		private bool _isLoadingMagazine;

		private bool _isLoadingBullet;

		private bool _isPumping;

		private float _postPumpDelay;

		private bool _willPerformPump;

		private bool _willReloadAfterPump;

		private float _pumpWait;

		private bool _keepZoomingAndPotentiallyReloading;

		private bool _wasZoomingAndPotentiallyReloading;

		private bool _isJumping;

		private float _jumpAngle;

		private float _jumpForwardMultiplier;

		private bool _isIntendingToJump;

		private bool _wantsToJump;

		private float _nextJumpTimer;

		private float _jumpTimer;

		private float _ignoreJumpTimer;

		private bool _isRolling;

		private bool _isIntendingToRoll;

		private float _rollAngle;

		private float _defaultCapsuleHeight = 2f;

		private float _defaultCapsuleCenter = 1f;

		private bool _isResurrecting;

		private CoverSearch _coverSearch = new CoverSearch();

		private CoverSearch _climbSearch = new CoverSearch();

		private Vector3 _localMovement = new Vector3(0f, 0f, 0f);

		private float _postFireAimWait;

		private bool _isCrouching;

		private bool _wantsToCrouch;

		private CharacterMovement _inputMovement;

		private CharacterMovement _lastMovingInputMovement;

		private bool _wasCountingInputMovement;

		private float _inputMovementTimer;

		private float _maxInputMovementHold;

		private CharacterMovement _currentMovement;

		private bool _wantsToAim;

		private bool _wantsToAimWhenLeavingCover;

		private bool _wantsToFire;

		private bool _hasFireCondition;

		private int _fireConditionSide;

		private bool _dontChangeArmAimingJustYet;

		private bool _wantsToFaceInADirection;

		private bool _wantsToHit;

		private bool _wantsToCombo;

		private bool _wantsToBlock;

		private bool _isBlocking;

		private int _meleeId;

		private bool _isPerformingMelee;

		private bool _useMeleeRootMotion;

		private bool _isWaitingForComboHit;

		private bool _checkForCombo;

		private Vector3 _meleeTarget;

		private int _meleeScan;

		private int _meleeMoment;

		private int _previousLeftFootDirection;

		private int _previousRightFootDirection;

		private float _previousLeftFootHeight;

		private float _previousRightFootHeight;

		private bool _hasRaisedLeftFoot;

		private bool _hasRaisedRightFoot;

		private float _feetLevel;

		private Transform _leftFoot;

		private Transform _rightFoot;

		private bool _needsToUpdateCoverBecauseOfDelay;

		private float _directionChangeDelay;

		private bool _wasAlive = true;

		private GameObject _target;

		private bool _needsTarget;

		private bool _isOnSlope;

		private Vector3 _groundNormal;

		private float _slope;

		private float _noMovementTimer;

		private float _groundTimer;

		private float _nogroundTimer;

		private bool _wasZooming;

		private GameObject _leftGrenade;

		private GameObject _rightGrenade;

		private bool _wantsToLiftArms;

		private bool _isGettingHit;

		private float _getHitWait;

		private float _lastHitTime;

		private static Vector3[] _grenadePath = new Vector3[64];

		private ICharacterPhysicsListener[] _physicsListeners;

		private ICharacterWeaponChangeListener[] _weaponChangeListeners;

		private ICharacterZoomListener[] _zoomListeners;

		private ICharacterGunListener[] _gunListeners;

		private ICharacterSuccessfulHitListener[] _successfulHitListeners;

		private ICharacterToolListener[] _toolListeners;

		private ICharacterHeightListener[] _heightListeners;

		private ICharacterWalkListener[] _walkListeners;

		private ICharacterCoverListener[] _coverListeners;

		private ICharacterHealthListener[] _healthListeners;

		public int totalalive;

		public int tipo;

		public int zombies;

		public int modojogo;

		public int morretodos;

		public int podemorrer;

		public GameObject explode;

		public GameObject torre;

		public int score;

		public int onda;

		public int xp;

		public int arma;

		public Vector3 BodyLookTarget => _currentBodyTarget;

		public Vector3 AimTarget => _aimTarget;

		public Vector3 ClosestCoverPosition
		{
			get
			{
				if (_cover.In)
				{
					Vector3 vector = _cover.Main.ClosestPointTo(base.transform.position, _capsule.radius, _capsule.radius);
					return vector - _cover.ForwardDirection * Vector3.Dot(-_cover.ForwardDirection, base.transform.position - vector);
				}
				return base.transform.position;
			}
		}

		public Vector3 AimForward
		{
			get
			{
				Vector3 vector = AimTarget - base.transform.position;
				vector.y = 0f;
				return vector.normalized;
			}
		}

		public bool IsPerformingCustomAction => _isPerformingCustomAction;

		public bool IsInProcess => _isInProcess;

		public bool CanMoveInProcess => _isInProcess && _process.CanMove;

		public bool IsClimbingOrVaulting => _isClimbing;

		public bool IsVaulting => _isClimbing && _isClimbingAVault;

		public float VerticalMeleeAngle => _verticalMeleeAngle;

		public float VaultPosition => _vaultPosition;

		public bool IsInCover => _cover.In;

		public bool IsCrouching => _isCrouching;

		public bool IsLow => _isCrouching || (_cover.In && _hasCrouchCover);

		public float BodyAngle => _horizontalAngle;

		public bool IsStandingLeftInCover => _cover.In && _cover.IsStandingLeft;

		public bool WantsToMaintainMirror => _keepZoomingAndPotentiallyReloading;

		public bool IsInLowCover => _cover.In && (_isCrouching || !_cover.IsTall);

		public bool IsInTallCover => _cover.In && _cover.IsTall && !_isCrouching;

		public bool IsCrouchingInTallCover => _isCrouching && _cover.In && _cover.IsTall;

		public bool IsFalling => _isFalling;

		public bool IsGrounded => _isGrounded;

		public bool IsJumping => _isJumping;

		public float GroundTimer => _groundTimer;

		public bool IsAimingThroughCoverPlane => _isAimingThroughCoverPlane;

		public float VerticalRecoil => _verticalRecoil;

		public float HorizontalRecoil => _horizontalRecoil;

		public WeaponDescription ActiveWeapon => (_weaponEquipState != 0) ? _equippedWeapon : ((!IsEquipped) ? default(WeaponDescription) : Weapon);

		public WeaponDescription EquippedWeapon => (_weaponEquipState != 0) ? _equippedWeapon : default(WeaponDescription);

		public WeaponEquipState WeaponEquipState => _weaponEquipState;

		public bool IsChangingWeapon
		{
			get
			{
				if (_weaponEquipState == WeaponEquipState.unequipped)
				{
					return !_equippedWeapon.IsTheSame(ref Weapon) && IsEquipped;
				}
				if (_weaponEquipState == WeaponEquipState.equipped)
				{
					return false;
				}
				return true;
			}
		}

		public bool IsChangingWeaponOrHasJustChanged
		{
			get
			{
				if (_weaponEquipState == WeaponEquipState.unequipped)
				{
					return !_equippedWeapon.IsTheSame(ref Weapon) && IsEquipped;
				}
				if (_weaponEquipState == WeaponEquipState.equipped)
				{
					return _weaponGrabTimer > float.Epsilon;
				}
				return true;
			}
		}

		public bool IsInCameraAimableState
		{
			get
			{
				if (Weapon.IsNull || !IsEquipped)
				{
					return false;
				}
				if (HasGrenadeInHand || IsClimbingOrVaulting || _isFalling || _isJumping || IsRolling || IsPerformingCustomAction || (_isInProcess && !_process.CanAim))
				{
					return false;
				}
				return true;
			}
		}

		public bool IsInAimableState
		{
			get
			{
				if (Weapon.IsNull || !IsEquipped)
				{
					return false;
				}
				if (IsChangingWeapon || HasGrenadeInHand || IsClimbingOrVaulting || _isFalling || _isIntendingToJump || _isJumping || IsRolling || IsPerformingCustomAction || (_isInProcess && !_process.CanAim))
				{
					return false;
				}
				return true;
			}
		}

		public bool IsLeftHandAimReady
		{
			get
			{
				if (_isPerformingMelee || _isGettingHit)
				{
					return false;
				}
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (equippedWeapon.IsNull)
				{
					return false;
				}
				if (equippedWeapon.Shield != null)
				{
					return false;
				}
				if (equippedWeapon.Gun == null)
				{
					return false;
				}
				if (IsChangingWeapon || IsReloading || HasGrenadeInHand || IsClimbingOrVaulting || _isFalling || _isJumping || IsRolling || IsPerformingCustomAction || (_isInProcess && !_process.CanAim))
				{
					return false;
				}
				return true;
			}
		}

		public bool IsZooming => IsAimingGun && (_wantsToZoom || _wantedToZoom);

		public bool IsScoping => IsAimingGun && (_wantsToScope || _wantedToScope) && EquippedWeapon.Gun != null && EquippedWeapon.Gun.Scope != null;

		public bool IsWeaponReady
		{
			get
			{
				if (!IsInAimableState || _isLoadingMagazine || _isPumping)
				{
					return false;
				}
				return true;
			}
		}

		public bool IsReloading => _isPumping || _postPumpDelay > float.Epsilon || _isLoadingBullet || _isLoadingMagazine;

		public bool IsReloadingAndNotAiming => _isLoadingBullet || _isLoadingMagazine;

		public bool IsWeaponScopeReady => IsInAimableState && !_isLoadingBullet && !_isLoadingMagazine && !_isPerformingMelee && !_isGettingHit;

		public bool IsGettingHit => _isGettingHit;

		public bool IsGunReady
		{
			get
			{
				if (!IsWeaponReady || _isPerformingMelee || _isGettingHit)
				{
					return false;
				}
				return EquippedWeapon.Gun != null;
			}
		}

		public bool IsGunScopeReady
		{
			get
			{
				if (!IsWeaponScopeReady)
				{
					return false;
				}
				return EquippedWeapon.Gun != null;
			}
		}

		public bool IsMeleeReady
		{
			get
			{
				if (!IsWeaponReady)
				{
					return false;
				}
				return EquippedWeapon.HasMelee;
			}
		}

		public bool IsBlocking => _isBlocking && !_isPerformingMelee && !IsAiming && IsMeleeReady;

		public bool IsRolling => _isRolling || _isIntendingToRoll;

		public bool IsGoingToSprint => !_cover.In && _isGrounded && _inputMovement.Magnitude > 1.1f;

		public bool IsSprinting => _isMoving && _useSprintingAnimation;

		public bool IsLoadingBullet => _isLoadingBullet;

		public bool IsLoadingMagazine => _isLoadingMagazine;

		public bool IsPumping => _isPumping || _postPumpDelay > float.Epsilon;

		public bool IsByAnOpenLeftCorner => _cover.In && _cover.Main.OpenLeft && (!_cover.HasLeftAdjacent || (_cover.Main.IsTall && !_cover.LeftAdjacent.IsTall)) && IsNearLeftCorner;

		public bool IsByAnOpenRightCorner => _cover.In && _cover.Main.OpenRight && (!_cover.HasRightAdjacent || (_cover.Main.IsTall && !_cover.RightAdjacent.IsTall)) && IsNearRightCorner;

		public bool IsNearLeftCorner
		{
			get
			{
				if (!_cover.In)
				{
					return false;
				}
				return _cover.In && _cover.HasLeftCorner && _cover.Main.IsByLeftCorner(base.transform.position - _coverOffset, CoverSettings.CornerAimTriggerDistance);
			}
		}

		public bool IsNearRightCorner
		{
			get
			{
				if (!_cover.In)
				{
					return false;
				}
				return _cover.In && _cover.HasRightCorner && _cover.Main.IsByRightCorner(base.transform.position - _coverOffset, CoverSettings.CornerAimTriggerDistance);
			}
		}

		public bool IsMovingToCoverOffset
		{
			get
			{
				if (!_cover.In)
				{
					return false;
				}
				return _sideOffset == CoverOffsetState.Entering || _sideOffset == CoverOffsetState.Exiting || _backOffset == CoverOffsetState.Entering || _backOffset == CoverOffsetState.Exiting;
			}
		}

		public bool IsMovingToCoverOffsetAndCantAim
		{
			get
			{
				if (!IsMovingToCoverOffset)
				{
					return false;
				}
				return !_canAimInThisOffsetAnimationOrIsAtTheEndOfIt;
			}
		}

		public Cover Cover => _cover.Main;

		public int CoverDirection => _cover.Direction;

		public Cover LeftCover => _cover.LeftAdjacent;

		public Cover RightCover => _cover.RightAdjacent;

		public Vector3 ConceptualAimOrigin
		{
			get
			{
				float d = (!_ik.HasSwitchedHands) ? 1f : (-1f);
				Vector3 normalized = Vector3.Cross(Vector3.up, _bodyTarget - base.transform.position).normalized;
				return VirtualHead + normalized * _capsule.radius * d * 0.75f;
			}
		}

		public Vector3 AccurateAimOrigin
		{
			get
			{
				float d = (!_ik.HasSwitchedHands) ? 1f : (-1f);
				Vector3 normalized = Vector3.Cross(Vector3.up, _aimTarget - base.transform.position).normalized;
				Vector3 a = base.transform.position + _capsule.height * Vector3.up * 0.75f;
				return a + normalized * _capsule.radius * d * 0.75f;
			}
		}

		public Vector3 AimOriginWithCoverOffset
		{
			get
			{
				float d = (!_ik.HasSwitchedHands) ? 1f : (-1f);
				Vector3 normalized = Vector3.Cross(Vector3.up, _bodyTarget - base.transform.position).normalized;
				Vector3 vector = VirtualHead + normalized * _capsule.radius * d * 0.75f;
				if (_cover.In)
				{
					vector += _coverOffset;
				}
				return vector;
			}
		}

		public Vector3 VirtualHead
		{
			get
			{
				Vector3 vector = base.transform.position + _capsule.height * Vector3.up * 0.75f;
				if (_cover.In)
				{
					vector -= _coverOffset;
				}
				return vector;
			}
		}

		public Vector3 GunOrigin => (!(EquippedWeapon.Gun == null)) ? EquippedWeapon.Gun.Origin : base.transform.position;

		public Vector3 GunDirection => (!(EquippedWeapon.Gun == null)) ? EquippedWeapon.Gun.Direction : base.transform.forward;

		public Vector3 Top => base.transform.position + Vector3.up * _defaultCapsuleHeight;

		public bool WouldAim
		{
			get
			{
				if (_isThrowing || _isGrenadeTakenOut)
				{
					return true;
				}
				return IsEquipped && Weapon.Gun != null;
			}
		}

		public bool IsAimingTool
		{
			get
			{
				if (!_isUsingWeapon || _isGettingHit)
				{
					return false;
				}
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (equippedWeapon.IsNull)
				{
					return false;
				}
				return (!(equippedWeapon.Tool != null) || !_isUsingWeaponAlternate) ? equippedWeapon.Tool.HasAiming : equippedWeapon.Tool.HasAlternateAiming;
			}
		}

		public bool WasAimingGun => _wasAimingGun;

		public bool IsAimingGun
		{
			get
			{
				if (!_isFalling && !_isClimbing && !_isJumping && !_isWeaponBlocked && !_isGettingHit && !IsSprinting && IsGunScopeReady && !HasGrenadeInHand)
				{
					if (_coverAim.IsAiming || wantsToAim)
					{
						return true;
					}
					if (!_cover.In && !EquippedWeapon.IsNull && (wantsToAim || _wantsToAimWhenLeavingCover))
					{
						return true;
					}
					return false;
				}
				return false;
			}
		}

		public bool IsAiming => _isThrowing || IsAimingGun || IsAimingTool;

		public bool IsInAnySideOffset => _sideOffset != CoverOffsetState.None;

		public bool IsInCoverOffset => _sideOffset == CoverOffsetState.Using || _backOffset == CoverOffsetState.Using;

		public bool IsWalkingOrStanding => _currentMovement.Magnitude < 0.9f;

		public Vector3 MovementDirection
		{
			get
			{
				if (_currentMovement.Magnitude < 0.25f)
				{
					return Vector3.zero;
				}
				return _currentMovement.Direction;
			}
		}

		public bool IsWalkingInCover => _wasMovingInCover;

		public float StandingHeight => _defaultCapsuleHeight;

		public float CurrentHeight => _capsule.height;

		public float TargetHeight
		{
			get
			{
				float result = _defaultCapsuleHeight;
				if (_isClimbing && _normalizedClimbTime < 0.5f)
				{
					result = ((!_isClimbingAVault) ? ClimbSettings.CapsuleHeight : VaultSettings.CapsuleHeight);
				}
				else if (_isJumping && _jumpTimer < JumpSettings.HeightDuration)
				{
					result = JumpSettings.CapsuleHeight;
				}
				else if (_isRolling)
				{
					result = RollSettings.CapsuleHeight;
				}
				else if (_isCrouching)
				{
					result = CrouchHeight;
				}
				else if (IsInLowCover)
				{
					if (!IsAiming)
					{
						result = CoverSettings.LowCapsuleHeight;
					}
					else if (!_isAimingThroughCoverPlane)
					{
						result = CoverSettings.LowAimCapsuleHeight;
					}
				}
				return result;
			}
		}

		public bool HasGrenadeInHand => _isGrenadeTakenOut || _isThrowing || internalIsGrenadeAnimation;

		public bool IsReadyToThrowGrenade => _isGrenadeTakenOut && !_isThrowing && !_hasThrown;

		public bool IsThrowingGrenade => _isThrowing || _hasThrown;

		public Grenade PotentialGrenade
		{
			get
			{
				GameObject gameObject = null;
				gameObject = ((!IsThrowingLeft) ? Grenade.Right : Grenade.Left);
				if (gameObject != null)
				{
					return gameObject.GetComponent<Grenade>();
				}
				return null;
			}
		}

		public Grenade CurrentGrenade
		{
			get
			{
				GameObject gameObject = null;
				if (_rightGrenade != null && _rightGrenade.activeSelf)
				{
					gameObject = _rightGrenade;
				}
				else
				{
					if (!(_leftGrenade != null) || !_leftGrenade.activeSelf)
					{
						return null;
					}
					gameObject = _leftGrenade;
				}
				return gameObject.GetComponent<Grenade>();
			}
		}

		public bool IsThrowingLeft
		{
			get
			{
				if (_isThrowing)
				{
					return _isGoingToThrowLeft;
				}
				return (_cover.In && _cover.IsStandingLeft && (Grenade.Left != null || _leftGrenade != null)) || (Grenade.Right == null && _rightGrenade == null);
			}
		}

		public Cover PotentialCover => _potentialCover;

		public bool IsMoving => _isMoving;

		public float Movement => _localMovement.magnitude;

		public float MovementError
		{
			get
			{
				float movement = Movement;
				if (movement < 0.5f)
				{
					return movement * 2f * AimSettings.WalkError;
				}
				if (movement < 1f)
				{
					return Mathf.Lerp(AimSettings.WalkError, AimSettings.RunError, (movement - 0.5f) * 2f);
				}
				if (movement < 2f)
				{
					return Mathf.Lerp(AimSettings.RunError, AimSettings.SprintError, movement - 1f);
				}
				return AimSettings.SprintError;
			}
		}

		public bool IsPerformingMelee => _isPerformingMelee;

		private bool wantsToAim => (_cover.In && _coverAim.IsZoomed) || _wantsToFire || _isThrowing || _wantedToZoom || _wantsToAim || _postFireAimWait > float.Epsilon;

		private bool canFire => !IsReloading && !IsChangingWeapon && IsGunReady && EquippedWeapon.Gun.LoadedBulletsLeft > 0;

		private int gunType
		{
			get
			{
				WeaponType type;
				if (_weaponEquipState == WeaponEquipState.unequipped && !_equippedWeapon.IsTheSame(ref Weapon))
				{
					if (!IsEquipped)
					{
						return 0;
					}
					if (!(Weapon.Gun != null))
					{
						return 0;
					}
					type = Weapon.Gun.Type;
				}
				else
				{
					WeaponDescription equippedWeapon = EquippedWeapon;
					if (!(equippedWeapon.Gun != null))
					{
						return 0;
					}
					type = equippedWeapon.Gun.Type;
				}
				switch (type)
				{
				case WeaponType.Pistol:
					return 1;
				case WeaponType.Rifle:
					return 2;
				case WeaponType.Shotgun:
					return 2;
				case WeaponType.Sniper:
					return 2;
				default:
					return 0;
				}
			}
		}

		private int meleeType
		{
			get
			{
				WeaponType type;
				if (_weaponEquipState == WeaponEquipState.unequipped && !_equippedWeapon.IsTheSame(ref Weapon))
				{
					if (!IsEquipped)
					{
						return 0;
					}
					if (Weapon.RightMelee != null)
					{
						type = Weapon.RightMelee.Type;
					}
					else
					{
						if (!(Weapon.LeftMelee != null))
						{
							return 0;
						}
						type = Weapon.LeftMelee.Type;
					}
				}
				else
				{
					WeaponDescription equippedWeapon = EquippedWeapon;
					if (equippedWeapon.RightMelee != null)
					{
						type = equippedWeapon.RightMelee.Type;
					}
					else
					{
						if (!(equippedWeapon.LeftMelee != null))
						{
							return 0;
						}
						type = equippedWeapon.LeftMelee.Type;
					}
				}
				switch (type)
				{
				case WeaponType.Pistol:
					return 1;
				case WeaponType.Rifle:
					return 2;
				case WeaponType.Shotgun:
					return 2;
				case WeaponType.Sniper:
					return 2;
				case WeaponType.Fist:
					return 3;
				case WeaponType.Machete:
					return 4;
				default:
					return 0;
				}
			}
		}

		internal bool wantsToFire => _wantsToFire;

		internal bool dontChangeArmAimingJustYet => _dontChangeArmAimingJustYet;

		private bool isInAnimatedCover
		{
			get
			{
				bool result = false;
				if (_cover.In && !_isClimbing)
				{
					result = ((!IsAimingGun) ? true : false);
				}
				return result;
			}
		}

		public GameObject AskForTarget()
		{
			_needsTarget = true;
			return _target;
		}

		public bool IsPerformingMeleeId(int id)
		{
			return _meleeId == id && IsPerformingMelee;
		}

		public Cover GetClimbambleInDirection(float angle)
		{
			return GetClimbableInDirection(Util.HorizontalVector(angle));
		}

		public Cover GetClimbableInDirection(Vector3 direction)
		{
			_climbSearch.Update(_cover, base.transform.position, _animator.GetBoneTransform(HumanBodyBones.Head).position, 0f, 0f, CoverSettings.ClimbDistance, _capsule.radius, CoverSettings);
			return _climbSearch.FindClimbCoverInDirection(direction);
		}

		public void SetBodyTarget(Vector3 target, float speed = 8f)
		{
			_bodyTarget = target;
			if (!_hasAimTarget)
			{
				_aimTarget = _bodyTarget;
				_hasAimTarget = true;
			}
			_bodyTurnSpeed = speed;
			updateAngles();
		}

		public void SetAimTarget(Vector3 target)
		{
			_aimTarget = target;
			_hasAimTarget = true;
		}

		public void Resurrect()
		{
			if (!IsAlive || _isResurrecting)
			{
				IsAlive = true;
				_isResurrecting = false;
				for (int i = 0; i < _healthListeners.Length; i++)
				{
					_healthListeners[i].OnResurrect();
				}
			}
		}

		public void OnCustomAction(string name)
		{
			if (!_isPerformingCustomAction)
			{
				_isPerformingCustomAction = true;
				_cover.Clear();
				clearPotentialCovers();
				_animator.SetTrigger(name);
			}
		}

		public void OnFinishCustomAction()
		{
			_isPerformingCustomAction = false;
		}

		private void Start()
		{
			Gravity = 18f;
		}

		private void Update()
		{
			xp = PlayerPrefs.GetInt("xp");
			if (modojogo == 0)
			{
				totalalive = PlayerPrefs.GetInt("totalalive");
			}
			if (modojogo == 2)
			{
				score = PlayerPrefs.GetInt("score");
				onda = PlayerPrefs.GetInt("onda");
				zombies = PlayerPrefs.GetInt("zombies");
				morretodos = PlayerPrefs.GetInt("morretodos");
			}
			if (tipo == 2 && podemorrer == 0 && morretodos == 1)
			{
				Die();
				podemorrer = 1;
			}
		}

		private IEnumerator deletar()
		{
			yield return new WaitForSeconds(5f);
			UnityEngine.Object.Destroy(base.gameObject);
		}

		public void Die()
		{
			if (modojogo == 0)
			{
				totalalive--;
				PlayerPrefs.SetInt("totalalive", totalalive);
				xp += 15;
				PlayerPrefs.SetInt("xp", xp);
			}
			if (modojogo == 2)
			{
				explode.SetActive(value: true);
				zombies--;
				PlayerPrefs.SetInt("zombies", zombies);
				score += 5 + onda;
				PlayerPrefs.SetInt("score", score);
				xp += 5;
				PlayerPrefs.SetInt("xp", xp);
				StartCoroutine(deletar());
			}
			if (modojogo == 4)
			{
				StartCoroutine(deletar());
				explode.SetActive(value: true);
				torre.SetActive(value: false);
			}
			if (tipo == 1)
			{
				PlayerPrefs.SetInt("encerra", 1);
			}
			if (IsAlive)
			{
				IsAlive = false;
				for (int i = 0; i < _healthListeners.Length; i++)
				{
					_healthListeners[i].OnDead();
				}
			}
		}

		public void OnHit(Hit hit)
		{
			bool flag = true;
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (hit.IsMelee && IsBlocking)
			{
				if (equippedWeapon.Shield != null && equippedWeapon.Shield.activeSelf && Vector3.Dot(base.transform.forward, hit.Normal) > 0f)
				{
					equippedWeapon.Shield.SendMessage("OnHit", hit);
					flag = false;
					return;
				}
				if (Vector3.Dot(base.transform.forward, hit.Normal) > 0f)
				{
					WeaponType weaponType = (!(Weapon.RightMelee == null)) ? Weapon.RightMelee.Type : Weapon.LeftMelee.Type;
					flag = (weaponType == WeaponType.Fist && hit.Type == HitType.Machete);
				}
			}
			if (!flag)
			{
				_animator.SetTrigger("SuccessfulBlock");
				SendMessage("OnBlock", hit, SendMessageOptions.DontRequireReceiver);
				return;
			}
			if (_isThrowing && Grenade.DropOnHit)
			{
				dropThrow();
			}
			else if (_isThrowing)
			{
				if (hit.Attacker != null)
				{
					hit.Attacker.SendMessage("NotifySuccessfulHit", hit, SendMessageOptions.DontRequireReceiver);
				}
				return;
			}
			if (_getHitWait > float.Epsilon || Time.timeSinceLevelLoad - _lastHitTime < hit.ReactionDelay || _weaponEquipState == WeaponEquipState.equipping || _weaponEquipState == WeaponEquipState.unequipping)
			{
				if (!_isPerformingMelee)
				{
					_ik.Hit(hit.Normal, HitResponseSettings.Strength, HitResponseSettings.Wait);
				}
			}
			else
			{
				if (_isPerformingMelee)
				{
					_useMeleeRootMotion = false;
					_animator.SetTrigger("EndMelee");
					BaseMelee rightMelee = equippedWeapon.RightMelee;
					if (rightMelee != null)
					{
						rightMelee.End();
					}
					BaseMelee leftMelee = equippedWeapon.LeftMelee;
					if (leftMelee != null)
					{
						leftMelee.End();
					}
				}
				Animator animator = _animator;
				Vector3 eulerAngles = base.transform.eulerAngles;
				animator.SetFloat("GetHitAngle", Mathf.DeltaAngle(eulerAngles.y, Util.HorizontalAngle(hit.Normal)));
				if (_localMovement.magnitude > 0.1f && !_isGettingHit)
				{
					_animator.SetFloat("GetHitType", -1f);
					_animator.SetFloat("GetHitMove", Mathf.DeltaAngle(0f, Util.HorizontalAngle(_localMovement)));
				}
				else
				{
                    int body,  _; float _k;

                    getWeaponProperties(out body, out  _, out  _k);
					_animator.SetFloat("GetHitType", body);
				}
				_lastHitTime = Time.timeSinceLevelLoad;
				_animator.ResetTrigger("CancelGetHit");
				_animator.SetTrigger("GetHit");
			}
			SendMessage("OnTakenHit", hit);
			if (hit.Attacker != null)
			{
				hit.Attacker.SendMessage("NotifySuccessfulHit", hit, SendMessageOptions.DontRequireReceiver);
			}
		}

		public void OnEject()
		{
			BaseGun gun = EquippedWeapon.Gun;
			if (gun != null)
			{
				gun.NotifyEject();
			}
		}

		public void OnRechamber()
		{
			BaseGun gun = EquippedWeapon.Gun;
			if (gun != null)
			{
				gun.NotifyRechamber();
			}
		}

		public void NotifyZoom()
		{
			for (int i = 0; i < _zoomListeners.Length; i++)
			{
				_zoomListeners[i].OnZoom();
			}
			if (Zoomed != null)
			{
				Zoomed();
			}
		}

		public void NotifyUnzoom()
		{
			for (int i = 0; i < _zoomListeners.Length; i++)
			{
				_zoomListeners[i].OnUnzoom();
			}
			if (Unzoomed != null)
			{
				Unzoomed();
			}
		}

		public void NotifyScope()
		{
			for (int i = 0; i < _zoomListeners.Length; i++)
			{
				_zoomListeners[i].OnScope();
			}
			if (Scoped != null)
			{
				Scoped();
			}
		}

		public void NotifyUnscope()
		{
			for (int i = 0; i < _zoomListeners.Length; i++)
			{
				_zoomListeners[i].OnUnscope();
			}
			if (Unscoped != null)
			{
				Unscoped();
			}
		}

		public void NotifyStartGunFire()
		{
			for (int i = 0; i < _gunListeners.Length; i++)
			{
				_gunListeners[i].OnStartGunFire();
			}
			if (FireStarted != null)
			{
				FireStarted();
			}
		}

		public void NotifyStopGunFire()
		{
			for (int i = 0; i < _gunListeners.Length; i++)
			{
				_gunListeners[i].OnStopGunFire();
			}
			if (FireStopped != null)
			{
				FireStopped();
			}
		}

		public void NotifySuccessfulHit(Hit hit)
		{
			for (int i = 0; i < _successfulHitListeners.Length; i++)
			{
				_successfulHitListeners[i].OnSuccessfulHit(hit);
			}
			if (SuccessfullyHit != null)
			{
				SuccessfullyHit(hit);
			}
		}

		public void InputBlock()
		{
			_wantsToBlock = true;
		}

		public void InputPreciseHands()
		{
			_isAimingPrecisely = true;
		}

		public void InputUseWeapon()
		{
			if (!_isUsingWeapon)
			{
				return;
			}
			WeaponDescription equippedWeapon = EquippedWeapon;
			_wasWeaponUsed = true;
			if (equippedWeapon.Tool != null)
			{
				equippedWeapon.Tool.Use(this, _isUsingWeaponAlternate);
			}
			if (_isUsingWeaponAlternate)
			{
				for (int i = 0; i < _toolListeners.Length; i++)
				{
					_toolListeners[i].OnToolUsed(isAlternateMode: true);
				}
				if (UsedToolAlternate != null)
				{
					UsedToolAlternate();
				}
			}
			else
			{
				for (int j = 0; j < _toolListeners.Length; j++)
				{
					_toolListeners[j].OnToolUsed(isAlternateMode: false);
				}
				if (UsedTool != null)
				{
					UsedTool();
				}
			}
			if ((!(equippedWeapon.Tool != null) || !_isUsingWeaponAlternate) ? equippedWeapon.Tool.IsContinuous : equippedWeapon.Tool.IsAlternateContinuous)
			{
				_isUsingWeapon = _keepUsingWeapon;
			}
			else
			{
				_isUsingWeapon = false;
			}
		}

		public void InputThrow()
		{
			executeThrow();
		}

		public void InputEndJump()
		{
			_isJumping = false;
		}

		public void InputMidCoverOffset(float normalizedTime)
		{
			bool flag = false;
			Vector3 vector = Vector3.zero;
			if (_sideOffset == CoverOffsetState.Entering || _sideOffset == CoverOffsetState.Using)
			{
				vector += _coverOffsetSideTarget;
			}
			if (_backOffset == CoverOffsetState.Entering || _backOffset == CoverOffsetState.Using)
			{
				vector += _coverOffsetBackTarget;
			}
			Vector3 closestCoverPosition = getClosestCoverPosition();
			base.transform.position = Vector3.Lerp(_initialOffsetPosition, closestCoverPosition + vector, normalizedTime);
			if (!_canAimInThisOffsetAnimationOrIsAtTheEndOfIt)
			{
				_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = (normalizedTime > 0.5f);
			}
			if (normalizedTime > 0.75f)
			{
				flag = true;
			}
			if (flag)
			{
				if (_sideOffset == CoverOffsetState.Entering)
				{
					_sideOffset = CoverOffsetState.Using;
					_coverOffsetSide = _coverOffsetSideTarget;
				}
				if (_sideOffset == CoverOffsetState.Exiting)
				{
					_sideOffset = CoverOffsetState.None;
					_coverOffsetSide = Vector3.zero;
				}
				if (_backOffset == CoverOffsetState.Entering)
				{
					_backOffset = CoverOffsetState.Using;
					_coverOffsetBack = _coverOffsetBackTarget;
				}
				if (_backOffset == CoverOffsetState.Exiting)
				{
					_backOffset = CoverOffsetState.None;
					_coverOffsetBack = Vector3.zero;
				}
				if ((_sideOffset == CoverOffsetState.Using || _backOffset == CoverOffsetState.Using) && IsInTallCover)
				{
					_coverAim.ImmediateEnter();
				}
			}
		}

		public void InputClimbStart()
		{
			_isClimbing = true;
		}

		public void InputMidClimb(float normalizedTime)
		{
			_normalizedClimbTime = normalizedTime;
		}

		public void InputEndClimb()
		{
			_isClimbing = false;
		}

		public void InputEndBulletLoad()
		{
			if (!_isLoadingBullet)
			{
				return;
			}
			_isLoadingBullet = false;
			BaseGun gun = EquippedWeapon.Gun;
			if (gun == null || !gun.LoadBullet())
			{
				return;
			}
			if (BulletLoaded != null)
			{
				BulletLoaded();
			}
			if (gun.IsFullyLoaded)
			{
				if (FullyLoaded != null)
				{
					FullyLoaded();
				}
				if (gun.PumpAfterFinalLoad)
				{
					InputEndPump();
				}
			}
			else if (gun.PumpAfterBulletLoad)
			{
				InputEndPump();
			}
			else
			{
				loadBullet();
			}
		}

		public void InputEndMagazineLoad()
		{
			if (!_isLoadingMagazine)
			{
				return;
			}
			_isLoadingMagazine = false;
			BaseGun gun = EquippedWeapon.Gun;
			if (!(gun == null))
			{
				if (gun.LoadMagazine() && FullyLoaded != null)
				{
					FullyLoaded();
				}
				if (gun.PumpAfterFinalLoad)
				{
					InputEndPump();
				}
			}
		}

		public void InputEndPump()
		{
			if (!_isPumping)
			{
				return;
			}
			_postPumpDelay = 0.2f;
			_isPumping = false;
			if (Pumped != null)
			{
				Pumped();
			}
			BaseGun gun = EquippedWeapon.Gun;
			if (!(gun == null))
			{
				gun.NotifyPump();
				if (!gun.IsFullyLoaded && !gun.ReloadWithMagazines && gun.PumpAfterBulletLoad)
				{
					_willReloadAfterPump = false;
					loadBullet();
				}
				else if (_willReloadAfterPump)
				{
					_willReloadAfterPump = false;
					InputReload();
				}
			}
		}

		public void InputVerticalMeleeAngle(float value)
		{
			_verticalMeleeAngle = value;
		}

		public void InputFinishEquip()
		{
			if (_weaponEquipState == WeaponEquipState.equipping)
			{
				_weaponEquipState = WeaponEquipState.equipped;
				if (_equippedWeapon.Shield != null)
				{
					_equippedWeapon.Shield.SetActive(value: true);
				}
				for (int i = 0; i < _weaponChangeListeners.Length; i++)
				{
					_weaponChangeListeners[i].OnWeaponChange();
				}
				if (WeaponChanged != null)
				{
					WeaponChanged();
				}
			}
		}

		public void InputGrabWeapon()
		{
			if (_weaponEquipState == WeaponEquipState.unequipped)
			{
				_equippedWeapon = _equippingWeapon;
				_weaponEquipState = WeaponEquipState.equipping;
				_isUnequippedButGoingToGrab = false;
				_weaponGrabTimer = 0.35f;
				showEquippedWeapon(showShield: false);
				if (_equippedWeapon.Gun != null)
				{
					_equippedWeapon.Gun.CancelFire();
				}
			}
		}

		public void InputUnequip()
		{
			if (_weaponEquipState == WeaponEquipState.unequipping)
			{
				_weaponEquipState = WeaponEquipState.unequipped;
				hideEquippedWeapon();
				_equippedWeapon = default(WeaponDescription);
			}
		}

		public void CancelAndPreventGetHit(float time, bool triggerAnimation = true)
		{
			_getHitWait = time;
			if (_isGettingHit && triggerAnimation)
			{
				_animator.SetTrigger("CancelGetHit");
			}
			_isGettingHit = false;
		}

		public void CancelGetHit(float time = 0.3f, bool triggerAnimation = true)
		{
			if (_isGettingHit && triggerAnimation)
			{
				_getHitWait = time;
				_animator.SetTrigger("CancelGetHit");
			}
			_isGettingHit = false;
		}

		public void InputGetHit()
		{
			_isGettingHit = true;
		}

		public void InputRecoil(float vertical, float horizontal)
		{
			_verticalRecoil += vertical;
			_horizontalRecoil += horizontal;
			_verticalRecoil = Mathf.Clamp(_verticalRecoil, -30f, 30f);
			_horizontalRecoil = Mathf.Clamp(_horizontalRecoil, -30f, 30f);
		}

		public void StopAimingWhenEnteringCover()
		{
			_stopAimingWhenEnteringCover = true;
		}

		public void AskForLateUpdate(CharacterCamera camera)
		{
			_cameraToLateUpdate = camera;
		}

		public void InputCrouchNearCover()
		{
			_wantsToCrouchNearCovers = true;
		}

		public void InputSmoothRotation()
		{
			_wantsToRotateSmoothly = true;
		}

		public void InputArmLift()
		{
			_wantsToLiftArms = true;
		}

		public void InputMirror()
		{
			_wantsToMirror = true;
		}

		public void InputResurrect()
		{
			if (!IsAlive && !_isResurrecting)
			{
				_isResurrecting = true;
				_animator.SetTrigger("Resurrect");
			}
		}

		public void InputProcess(CharacterProcess desc)
		{
			_isInProcess = true;
			_process = desc;
			if (desc.AnimationTrigger != null && desc.AnimationTrigger.Length > 0)
			{
				_animator.SetTrigger(desc.AnimationTrigger);
			}
		}

		public void InputProcessEnd()
		{
			_isInProcess = false;
		}

		public void InputLayer(int value)
		{
			_targetLayer = value;
		}

		public void InputTakeGrenade(GameObject grenadeOverride = null)
		{
			if (!_isThrowing && !_isGrenadeTakenOut)
			{
				recreateGrenades(grenadeOverride);
				_isGrenadeTakenOut = true;
				_animator.SetTrigger("TakeGrenade");
			}
		}

		public void InputCancelGrenade()
		{
			_isGrenadeTakenOut = false;
		}

		public void InputThrowGrenade(Vector3 target, GameObject grenadeOverride = null)
		{
			Grenade grenade = (!(grenadeOverride != null)) ? PotentialGrenade : grenadeOverride.GetComponent<Grenade>();
			if (!(grenade == null))
			{
				GrenadeDescription desc = default(GrenadeDescription);
				desc.Gravity = Grenade.Gravity;
				desc.Duration = grenade.Timer;
				desc.Bounciness = grenade.Bounciness;
				int predictedPathLength = GrenadePath.Calculate(GrenadePath.Origin(this, Util.HorizontalAngle(target - base.transform.position)), target, Grenade.MaxVelocity, desc, _grenadePath, Grenade.Step);
				InputThrowGrenade(_grenadePath, predictedPathLength, Grenade.Step, grenadeOverride);
			}
		}

		public void InputThrowGrenade(Vector3[] predictedPath, int predictedPathLength, float step, GameObject grenadeOverride = null)
		{
			if (predictedPathLength >= 2)
			{
				InputThrowGrenade(predictedPath[0], (predictedPath[1] - predictedPath[0]) / step, predictedPath[predictedPathLength - 1], grenadeOverride);
			}
		}

		public void InputThrowGrenade(Vector3 origin, Vector3 velocity, Vector3 target, GameObject grenadeOverride = null)
		{
			if (!_isThrowing)
			{
				_isGoingToThrowLeft = IsThrowingLeft;
				_wouldTurnImmediately = true;
				_isThrowing = true;
				_hasThrown = false;
				_isGrenadeTakenOut = false;
				_throwOrigin = origin;
				_throwVelocity = velocity;
				_throwTarget = target;
				_hasBeganThrowAnimation = false;
				_throwAngle = Util.HorizontalAngle(velocity);
				if (_cover.In && _cover.Main.IsFrontField(_throwAngle, 180f))
				{
					_throwBodyAngle = _cover.FaceAngle(_isCrouching);
				}
				else
				{
					_throwBodyAngle = _throwAngle;
				}
				recreateGrenades(grenadeOverride);
			}
		}

		public void InputRoll(float angle)
		{
			if (_isRolling || _isIntendingToRoll || _isPerformingCustomAction || _isPerformingMelee || _isGettingHit)
			{
				return;
			}
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.IsHeavy)
			{
				return;
			}
			if (_cover.In)
			{
				if (_cover.Main.IsFrontField(angle, 160f))
				{
					return;
				}
				if (_cover.IsTall)
				{
					_needToEnterCoverByWalkingToIt = true;
					_cover.Clear();
					_rollAngle = angle;
				}
				else
				{
					_rollAngle = angle;
				}
			}
			else
			{
				_rollAngle = angle;
			}
			_isIntendingToRoll = true;
		}

		public void InputEndRoll()
		{
			_isRolling = false;
			_isIntendingToRoll = false;
		}

		public void InputJump(float angle, float forwardMultiplier)
		{
			if (!_isIntendingToJump && !_isRolling)
			{
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (!equippedWeapon.IsHeavy)
				{
					_jumpAngle = angle;
					_jumpForwardMultiplier = forwardMultiplier;
					_wantsToJump = true;
				}
			}
		}

		public void InputClimbOrVault(Cover cover)
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (!equippedWeapon.PreventClimbing)
			{
				_wantsToClimbCover = cover;
			}
		}

		public void InputTakeCover()
		{
			_wantsToTakeCover = true;
		}

		public void InputImmediateCoverSearch()
		{
			_wantsToImmediatelyUpdatePotentialCover = true;
		}

		public void InputLeaveCover()
		{
			_wantsToTakeCover = false;
			if (_cover.In)
			{
				_cover.Clear();
			}
		}

		public void InputMovement(CharacterMovement movement)
		{
			if (movement.IsMoving || !_wasCountingInputMovement || !(_inputMovementTimer < _maxInputMovementHold))
			{
				_inputMovement = movement;
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (equippedWeapon.IsHeavy && _inputMovement.Magnitude > 0.5f)
				{
					_inputMovement.Magnitude = 0.5f;
				}
				if (!CanSprint)
				{
					_inputMovement.Magnitude = Mathf.Clamp(_inputMovement.Magnitude, 0f, 1f);
				}
				if (!CanRun)
				{
					_inputMovement.Magnitude = Mathf.Clamp(_inputMovement.Magnitude, 0f, 0.5f);
				}
				_wantsToSprint = _inputMovement.IsSprinting;
				if (_wantsToSprint)
				{
					_useSprintingAnimation = true;
					_sprintAnimationOffDelay = 0.2f;
				}
				_isMoving = _inputMovement.IsMoving;
			}
		}

		public void InputMoveForward(float strength = 1f)
		{
			InputMovement(new CharacterMovement(Util.HorizontalVector(_horizontalAngle), 1f));
		}

		public void InputMoveBack(float strength = 1f)
		{
			InputMovement(new CharacterMovement(Util.HorizontalVector(_horizontalAngle - 180f), 1f));
		}

		public void InputMoveLeft(float strength = 1f)
		{
			InputMovement(new CharacterMovement(Util.HorizontalVector(_horizontalAngle - 90f), 1f));
		}

		public void InputMoveRight(float strength = 1f)
		{
			InputMovement(new CharacterMovement(Util.HorizontalVector(_horizontalAngle + 90f), 1f));
		}

		public void InputCrouch()
		{
			_wantsToCrouch = true;
		}

		public void InputPossibleImmediateTurn(bool value = true)
		{
			_wouldTurnImmediately = value;
		}

		public void InputAim()
		{
			_wantsToAim = true;
		}

		public void InputAimWhenLeavingCover()
		{
			_wantsToAimWhenLeavingCover = true;
		}

		public void InputZoom()
		{
			_wantsToAim = true;
			_wantsToZoom = true;
		}

		public void InputScope()
		{
			_wantsToAim = true;
			_wantsToZoom = true;
			_wantsToScope = true;
		}

		public void InputUseToolAlternate()
		{
			InputUseTool(isAlternate: true);
		}

		public void InputUseTool(bool isAlternate = false)
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_isUsingWeapon)
			{
				_keepUsingWeapon = (isAlternate == _isUsingWeaponAlternate);
			}
			else if (!equippedWeapon.IsNull)
			{
				if (equippedWeapon.Gun != null)
				{
					InputFire();
				}
				else if (_weaponEquipState == WeaponEquipState.equipping || _weaponEquipState == WeaponEquipState.equipped)
				{
					_isUsingWeaponAlternate = isAlternate;
					_isUsingWeapon = true;
					_keepUsingWeapon = true;
					_wasWeaponUsed = false;
				}
			}
		}

		public void InputMelee()
		{
			InputMelee(base.transform.position + base.transform.forward * 1000f);
		}

		public void InputMeleeTarget(Vector3 target)
		{
			_meleeTarget = target;
		}

		public void InputMelee(Vector3 target)
		{
			if (EquippedWeapon.HasMelee)
			{
				_wantsToHit = true;
				_meleeTarget = target;
			}
		}

		public void InputCombo(Vector3 target)
		{
			_meleeTarget = target;
			_wantsToCombo = true;
		}

		public void InputBeginMeleeScan(int id, Limb limb)
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_meleeScan != id)
			{
				_meleeScan = id;
				BaseMelee rightMelee = equippedWeapon.RightMelee;
				BaseMelee leftMelee = equippedWeapon.LeftMelee;
				if (limb == Limb.RightHand && rightMelee != null)
				{
					rightMelee.EndScan();
					rightMelee.BeginScan();
				}
				else if (limb == Limb.LeftHand && leftMelee != null)
				{
					leftMelee.EndScan();
					leftMelee.BeginScan();
				}
			}
		}

		public void InputEndMeleeScan(int id, Limb limb)
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_meleeScan == id)
			{
				_meleeScan = 0;
				if (limb == Limb.RightHand && equippedWeapon.RightMelee != null)
				{
					equippedWeapon.RightMelee.EndScan();
				}
				else if (limb == Limb.LeftHand && equippedWeapon.LeftMelee != null)
				{
					equippedWeapon.LeftMelee.EndScan();
				}
			}
		}

		public void InputMeleeMoment(int id, Limb limb)
		{
			if (!_isPerformingMelee)
			{
				return;
			}
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_meleeId == id && _meleeMoment != id)
			{
				if (limb == Limb.RightHand && equippedWeapon.RightMelee != null)
				{
					_meleeMoment = id;
					equippedWeapon.RightMelee.Moment();
				}
				else if (limb == Limb.LeftHand && equippedWeapon.LeftMelee != null)
				{
					_meleeMoment = id;
					equippedWeapon.LeftMelee.Moment();
				}
			}
		}

		public void InputMeleeAttackStart(int id)
		{
			if (_isPerformingMelee)
			{
				return;
			}
			BaseMelee rightMelee = EquippedWeapon.RightMelee;
			BaseMelee leftMelee = EquippedWeapon.LeftMelee;
			if (rightMelee != null || leftMelee != null)
			{
				_meleeId = id;
				_useMeleeRootMotion = true;
				_isPerformingMelee = true;
				if (rightMelee != null)
				{
					rightMelee.Begin();
				}
				if (leftMelee != null)
				{
					leftMelee.Begin();
				}
			}
		}

		public void InputMeleeComboStart(int id)
		{
			if (_isPerformingMelee && _isWaitingForComboHit)
			{
				_meleeId = id;
				_isWaitingForComboHit = false;
			}
		}

		public void InputMeleeAttackEnd()
		{
			if (_isPerformingMelee)
			{
				_meleeScan = 0;
				_meleeMoment = 0;
				_isPerformingMelee = false;
				BaseMelee rightMelee = EquippedWeapon.RightMelee;
				if (rightMelee != null)
				{
					rightMelee.End();
				}
				rightMelee = EquippedWeapon.LeftMelee;
				if (rightMelee != null)
				{
					rightMelee.End();
				}
			}
		}

		public void InputMeleeComboCheck()
		{
			_checkForCombo = true;
		}

		public void StopMeleeRootMotion()
		{
			_useMeleeRootMotion = false;
		}

		public void InputFire()
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.IsNull)
			{
				return;
			}
			if (equippedWeapon.Gun == null)
			{
				if (equippedWeapon.HasMelee)
				{
					InputMelee();
				}
				else
				{
					InputUseTool();
				}
			}
			else
			{
				_wantsToFire = true;
				_hasFireCondition = false;
				InputAim();
			}
		}

		public void InputFireOnCondition(int ignoreSide)
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.IsNull)
			{
				return;
			}
			if (equippedWeapon.Gun == null)
			{
				if (equippedWeapon.HasMelee)
				{
					InputMelee();
				}
				else
				{
					InputUseTool();
				}
			}
			else
			{
				_hasFireCondition = true;
				_fireConditionSide = ignoreSide;
				_wantsToFire = true;
				InputAim();
			}
		}

		public void InputReload()
		{
			BaseGun gun = EquippedWeapon.Gun;
			if (IsReloading || gun == null || !gun.CanLoad)
			{
				return;
			}
			if (_willPerformPump)
			{
				_willReloadAfterPump = true;
				return;
			}
			_willPerformPump = false;
			if (gun.ReloadWithMagazines || gun.Type == WeaponType.Pistol)
			{
				_isLoadingMagazine = true;
				_animator.SetTrigger("LoadMagazine");
				if (gun != null)
				{
					gun.NotifyMagazineLoadStart();
				}
			}
			else
			{
				loadBullet();
			}
		}

		public void InputPump(float delay = 0f)
		{
			if (!IsReloading && !(EquippedWeapon.Gun == null))
			{
				if (delay <= float.Epsilon)
				{
					performPump();
					return;
				}
				_pumpWait = delay;
				_willPerformPump = true;
				_isPumping = false;
			}
		}

		public void InputStandLeft()
		{
			_wantsToFaceInADirection = true;
			_cover.StandLeft();
		}

		public void InputStandRight()
		{
			_wantsToFaceInADirection = true;
			_cover.StandRight();
		}

		public void InputImmediateAim()
		{
			InputAim();
			_immediateAim = true;
		}

		private void OnEnable()
		{
			if (IsAlive)
			{
				_immediateIdle = true;
				Characters.Register(this);
				_hasRegistered = true;
			}
		}

		private void OnDisable()
		{
			Characters.Unregister(this);
			_hasRegistered = false;
		}

		private void OnDestroy()
		{
			animatorToMotorMap.Remove(_animator);
		}

		private void Awake()
		{
			_capsule = GetComponent<CapsuleCollider>();
			_body = GetComponent<Rigidbody>();
			_animator = GetComponent<Animator>();
			_actor = GetComponent<Actor>();
			_physicsListeners = Util.GetInterfaces<ICharacterPhysicsListener>(base.gameObject);
			_weaponChangeListeners = Util.GetInterfaces<ICharacterWeaponChangeListener>(base.gameObject);
			_zoomListeners = Util.GetInterfaces<ICharacterZoomListener>(base.gameObject);
			_gunListeners = Util.GetInterfaces<ICharacterGunListener>(base.gameObject);
			_toolListeners = Util.GetInterfaces<ICharacterToolListener>(base.gameObject);
			_successfulHitListeners = Util.GetInterfaces<ICharacterSuccessfulHitListener>(base.gameObject);
			_walkListeners = Util.GetInterfaces<ICharacterWalkListener>(base.gameObject);
			_heightListeners = Util.GetInterfaces<ICharacterHeightListener>(base.gameObject);
			_coverListeners = Util.GetInterfaces<ICharacterCoverListener>(base.gameObject);
			_healthListeners = Util.GetInterfaces<ICharacterHealthListener>(base.gameObject);
			_leftFoot = _animator.GetBoneTransform(HumanBodyBones.LeftFoot);
			_rightFoot = _animator.GetBoneTransform(HumanBodyBones.RightFoot);
			animatorToMotorMap[_animator] = this;
			if (!Weapon.IsNull && IsEquipped)
			{
				InputGrabWeapon();
				InputFinishEquip();
				_weaponGrabTimer = 0f;
                int body, tool; float variant;

                getWeaponProperties(out  body, out  tool, out  variant);
				immediateBodyValue(body);
				_animator.SetFloat("Tool", tool);
				_animator.SetFloat("GunVariant", variant);
			}
			else
			{
				immediateBodyValue(0);
			}
			_ik.Setup(this);
			_renderers = GetComponentsInChildren<Renderer>();
			_visibility = new Visibility[_renderers.Length];
			for (int i = 0; i < _visibility.Length; i++)
			{
				_visibility[i] = _renderers[i].GetComponent<Visibility>();
				if (_visibility[i] == null)
				{
					_visibility[i] = _renderers[i].gameObject.AddComponent<Visibility>();
				}
			}
			_defaultCapsuleHeight = _capsule.height;
			Vector3 center = _capsule.center;
			_defaultCapsuleCenter = center.y;
			_previousCapsuleHeight = _defaultCapsuleHeight;
			SetAimTarget(base.transform.position + base.transform.forward * 1000f);
			if (Grenade.Left != null)
			{
				Collider component = Grenade.Left.GetComponent<Collider>();
				if (component != null)
				{
					Physics.IgnoreCollision(_capsule, component, ignore: true);
				}
			}
			if (Grenade.Right != null)
			{
				Collider component2 = Grenade.Right.GetComponent<Collider>();
				if (component2 != null)
				{
					Physics.IgnoreCollision(_capsule, component2, ignore: true);
				}
			}
			for (int j = 0; j < _heightListeners.Length; j++)
			{
				_heightListeners[j].OnStandingHeight(_defaultCapsuleHeight);
				_heightListeners[j].OnCurrentHeight(_defaultCapsuleHeight);
			}
			if (StandingHeightChanged != null)
			{
				StandingHeightChanged(_defaultCapsuleHeight);
			}
			if (CurrentHeightChanged != null)
			{
				CurrentHeightChanged(_defaultCapsuleHeight);
			}
		}

		private void FixedUpdate()
		{
			updateFeet();
		}

		private void LateUpdate()
		{
			if (IsAlive && !_hasRegistered)
			{
				_hasRegistered = true;
				Characters.Register(this);
			}
			else if (!IsAlive && _hasRegistered)
			{
				_hasRegistered = false;
				Characters.Unregister(this);
			}
			if (IsAlive)
			{
				_target = null;
				_isMoving = _currentMovement.IsMoving;
				if (_getHitWait > 0f)
				{
					_getHitWait -= Time.deltaTime;
				}
				if (_weaponGrabTimer > float.Epsilon)
				{
					_weaponGrabTimer -= Time.deltaTime;
				}
				if (_postFireAimWait > float.Epsilon)
				{
					_postFireAimWait -= Time.deltaTime;
				}
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (equippedWeapon.Aiming == WeaponAiming.always)
				{
					if (!_cover.In)
					{
						InputAim();
					}
					else
					{
						InputAimWhenLeavingCover();
					}
				}
				else if (equippedWeapon.Aiming == WeaponAiming.alwaysImmediateTurn)
				{
					if (!_cover.In)
					{
						InputAim();
						InputPossibleImmediateTurn();
					}
					else
					{
						InputAimWhenLeavingCover();
					}
				}
				_coverUpdateTimer += Time.deltaTime;
				_isCrouching = (_wantsToCrouch && (!_cover.In || _cover.IsTall));
				if (_useSprintingAnimation)
				{
					if (_sprintAnimationOffDelay > 0f)
					{
						_sprintAnimationOffDelay -= Time.deltaTime;
					}
					else
					{
						_useSprintingAnimation = false;
					}
				}
				if (_cover.In)
				{
					_coverTime += Time.deltaTime;
				}
				else
				{
					_coverTime = 0f;
				}
				if (_postPumpDelay > float.Epsilon)
				{
					_postPumpDelay -= Time.deltaTime;
				}
				if (_willPerformPump && !_isPumping && _pumpWait > float.Epsilon)
				{
					_pumpWait -= Time.deltaTime;
					if (_pumpWait <= float.Epsilon)
					{
						performPump();
					}
				}
				updateAngles();
				if (IsAlive && !_isClimbing)
				{
					Vector3 vector = new Vector3(0f, Gravity, 0f) * Time.deltaTime;
					if (!_isGrounded && _isRolling)
					{
						_body.velocity -= vector;
					}
					else if (_noMovementTimer < 0.2f || !_isGrounded || _isOnSlope || _groundTimer < 0.2f)
					{
						if (_isOnSlope && _noMovementTimer > float.Epsilon && !_isJumping)
						{
							_body.velocity = Vector3.zero;
						}
						else if (_isGrounded && _jumpTimer < 0.1f && !_isOnSlope)
						{
							_body.velocity -= vector * 2f;
						}
						else
						{
							_body.velocity -= vector;
						}
					}
				}
				if (EquippedWeapon.Gun != null && !IsInCover)
				{
					WeaponDescription equippedWeapon2 = EquippedWeapon;
					if (!equippedWeapon2.PreventArmLowering)
					{
						Vector3 virtualHead = VirtualHead;
						_isWeaponBlocked = !Util.IsFree(base.gameObject, virtualHead, (_aimTarget - virtualHead).normalized, (!IsZooming) ? 1.2f : 0.75f, coverMeansFree: false, actorMeansFree: true);
						goto IL_0437;
					}
				}
				_isWeaponBlocked = false;
				goto IL_0437;
			}
			_isCrouching = false;
			_isWeaponBlocked = false;
			_body.velocity = Vector3.zero;
			updateGround();
			goto IL_07d1;
			IL_07d1:
			updateCapsule();
			updateAnimator();
			_wantedToZoom = _wantsToZoom;
			_wantedToScope = _wantsToScope;
			_keepUsingWeapon = false;
			if (IsAiming)
			{
				_aimTimer += Time.deltaTime;
			}
			else
			{
				_aimTimer = 0f;
			}
			int num = 0;
			for (int i = 0; i < 32; i++)
			{
				int num2 = 1 << i;
				if ((_targetLayer & num2) == num2)
				{
					num = i;
					break;
				}
			}
			Renderer[] renderers = _renderers;
			foreach (Renderer renderer in renderers)
			{
				if (renderer.gameObject.layer != num)
				{
					renderer.gameObject.layer = num;
				}
			}
			bool isZooming = IsZooming;
			if (isZooming && !_wasZooming)
			{
				NotifyZoom();
			}
			else if (!isZooming && _wasZooming)
			{
				NotifyUnzoom();
			}
			_wasZooming = isZooming;
			BaseGun gun = EquippedWeapon.Gun;
			if (gun != null)
			{
				float num3 = gun.Recoil.RecoveryRate * RecoilRecovery * Time.deltaTime;
				if (_verticalRecoil > 0f)
				{
					if (_verticalRecoil > num3)
					{
						_verticalRecoil -= num3;
					}
					else
					{
						_verticalRecoil = 0f;
					}
				}
				else if (_verticalRecoil < 0f - num3)
				{
					_verticalRecoil += num3;
				}
				else
				{
					_verticalRecoil = 0f;
				}
				if (_horizontalRecoil > 0f)
				{
					if (_horizontalRecoil > num3)
					{
						_horizontalRecoil -= num3;
					}
					else
					{
						_horizontalRecoil = 0f;
					}
				}
				else if (_horizontalRecoil < 0f - num3)
				{
					_horizontalRecoil += num3;
				}
				else
				{
					_horizontalRecoil = 0f;
				}
			}
			else
			{
				_horizontalRecoil = 0f;
				_verticalRecoil = 0f;
			}
			if (_inputMovement.IsMoving)
			{
				_inputMovementTimer += Time.deltaTime;
				if (!_wasCountingInputMovement)
				{
					_inputMovementTimer = 0f;
					_maxInputMovementHold = 0f;
					_wasCountingInputMovement = true;
				}
				if (_inputMovement.MinDuration > _maxInputMovementHold)
				{
					_maxInputMovementHold = _inputMovement.MinDuration;
				}
				_lastMovingInputMovement = _inputMovement;
			}
			if (_inputMovementTimer >= _maxInputMovementHold)
			{
				if (_wasCountingInputMovement)
				{
					_wasCountingInputMovement = false;
					_inputMovement = default(CharacterMovement);
				}
			}
			else
			{
				_inputMovementTimer += Time.deltaTime;
				_inputMovement = _lastMovingInputMovement;
			}
			_wasAimingGun = IsAimingGun;
			_targetLayer = Layers.Character;
			_wantsToAim = false;
			_wouldTurnImmediately = false;
			_wantsToAimWhenLeavingCover = false;
			_wantsToJump = false;
			_wantsToClimbCover = null;
			_wantsToTakeCover = false;
			_wantsToSprint = false;
			_wantsToCrouch = false;
			_wantsToFire = false;
			_wantsToHit = false;
			_wantsToCombo = false;
			_wantsToFaceInADirection = false;
			_wantsToImmediatelyUpdatePotentialCover = false;
			_wantsToZoom = false;
			_wantsToScope = false;
			_wantsToRotateSmoothly = false;
			_wantsToLiftArms = false;
			_wantsToMirror = false;
			_wantsToCrouchNearCovers = false;
			_stopAimingWhenEnteringCover = false;
			_checkForCombo = false;
			_isAimingPrecisely = false;
			_needsTarget = false;
			_wantsToBlock = false;
			bool isAlive = IsAlive;
			if (isAlive && !_wasAlive && Resurrected != null)
			{
				Resurrected();
			}
			if (!isAlive && _wasAlive && Died != null)
			{
				Died();
			}
			_wasAlive = isAlive;
			if (_cameraToLateUpdate != null)
			{
				_cameraToLateUpdate.UpdateForCharacterMotor();
				_cameraToLateUpdate = null;
			}
			return;
			IL_0437:
			updateWeapons();
			updateGrenade();
			updateCoverPlane();
			if (_isInProcess && _process.LeaveCover)
			{
				clearPotentialCovers();
			}
			if (_isPerformingCustomAction)
			{
				clearPotentialCovers();
			}
			else if (_isClimbing)
			{
				clearPotentialCovers();
				updateClimb();
			}
			else
			{
				updateCommon();
			}
			moveAndRotate();
			bool flag = false;
			if (IsInTallCover && !IsChangingWeapon)
			{
				flag = ((!IsAiming) ? _ik.HasSwitchedHands : _cover.IsStandingLeft);
			}
			else if (_wantsToMirror && (IsAiming || _keepZoomingAndPotentiallyReloading || _wantsToZoom) && !IsChangingWeapon)
			{
				flag = true;
			}
			if (flag)
			{
				_wasZoomingAndPotentiallyReloading = IsReloading;
				_keepZoomingAndPotentiallyReloading = (!_wantsToZoom || IsReloading);
				mirror();
			}
			else
			{
				unmirror();
			}
			if (!_wasZoomingAndPotentiallyReloading)
			{
				_keepZoomingAndPotentiallyReloading = false;
			}
			if (!IsReloading && !_wantsToZoom)
			{
				_wasZoomingAndPotentiallyReloading = false;
			}
			bool flag2 = _visibility.Length == 0;
			for (int k = 0; k < _visibility.Length; k++)
			{
				if (_visibility[k].IsVisible)
				{
					flag2 = true;
					break;
				}
			}
			if (flag2 || _targetLayer == Layers.Scope)
			{
				updateIK();
			}
			if (EquippedWeapon.Gun != null)
			{
				EquippedWeapon.Gun.UpdateManually();
			}
			if (Mathf.Abs(_movementInput) > float.Epsilon)
			{
				_noMovementTimer = 0f;
			}
			else if (_noMovementTimer < 1f)
			{
				_noMovementTimer += Time.deltaTime;
			}
			if (!_isGrounded)
			{
				_groundTimer = 0f;
				if (_nogroundTimer < 1f)
				{
					_nogroundTimer += Time.deltaTime;
				}
			}
			else
			{
				_nogroundTimer = 0f;
				if (_groundTimer < 1f)
				{
					_groundTimer += Time.deltaTime;
				}
			}
			if (_lastNotifiedCover != _cover.Main)
			{
				_lastNotifiedCover = _cover.Main;
				if (_lastNotifiedCover == null)
				{
					for (int l = 0; l < _coverListeners.Length; l++)
					{
						_coverListeners[l].OnLeaveCover();
					}
					if (ExitedCover != null)
					{
						ExitedCover();
					}
				}
				else
				{
					for (int m = 0; m < _coverListeners.Length; m++)
					{
						_coverListeners[m].OnEnterCover(_lastNotifiedCover);
					}
					if (EnteredCover != null)
					{
						EnteredCover(_lastNotifiedCover);
					}
				}
			}
			goto IL_07d1;
		}

		private void updateCoverPlane()
		{
			BaseGun gun = EquippedWeapon.Gun;
			bool flag;
			bool flag2;
			if (_cover.In && gun != null && !IsReloadingAndNotAiming)
			{
				bool isAimingThroughCoverPlane = _isAimingThroughCoverPlane;
				_isAimingThroughCoverPlane = false;
				flag = false;
				flag2 = false;
				Vector3 conceptualAimOrigin = ConceptualAimOrigin;
				Vector3 direction = _bodyTarget - conceptualAimOrigin;
				direction.y = 0f;
				direction.Normalize();
				float num = _cover.Main.Top - 0.1f;
				if (num < conceptualAimOrigin.y)
				{
					conceptualAimOrigin.y = num;
				}
				if (_cover.Main.IsFrontField(_horizontalAngle, 180f))
				{
					_isAimingThroughCoverPlane = (Physics.RaycastNonAlloc(conceptualAimOrigin, direction, Util.Hits, _capsule.radius * 4f, Layers.Geometry, QueryTriggerInteraction.Ignore) > 0);
					if (_isAimingThroughCoverPlane)
					{
						_hasCoverPlaneAngle = true;
						_coverPlaneAngle = _horizontalAngle;
					}
				}
				if (IsInLowCover && (_isAimingThroughCoverPlane || (gun.HasRaycastSetup && Vector3.Dot(_cover.Main.Forward, gun.RaycastOrigin - _cover.Main.transform.position - _coverOffset) > 0f)))
				{
					if (_verticalAngle < -5f && isAimingThroughCoverPlane)
					{
						goto IL_01e0;
					}
					if (_verticalAngle < -8f && gun != null && gun.HasRaycastSetup)
					{
						Vector3 raycastOrigin = gun.RaycastOrigin;
						if (raycastOrigin.y < _cover.Main.Top + 0.1f)
						{
							goto IL_01e0;
						}
					}
					if (_cover.Main.IsFrontField(_horizontalAngle, 190f + Mathf.Clamp(_verticalAngle * 2f, 0f, 70f)))
					{
						_isAimingThroughCoverPlane = true;
						flag = ((_backOffset != CoverOffsetState.Using && _backOffset != CoverOffsetState.Entering) ? (_verticalAngle > 25f) : (_verticalAngle > 20f));
						if (!flag)
						{
							_hasCoverPlaneAngle = true;
							_coverPlaneAngle = _horizontalAngle;
						}
					}
				}
				goto IL_028b;
			}
			_isAimingThroughCoverPlane = false;
			_hasCoverPlaneAngle = false;
			setCoverOffsets( false, false, Vector3.zero, Vector3.zero);
			return;
			IL_028b:
			if (!_isAimingThroughCoverPlane)
			{
				float num2 = Mathf.DeltaAngle(_horizontalAngle, _coverPlaneAngle);
				if (_hasCoverPlaneAngle && ((IsStandingLeftInCover && num2 < 5f) || (!IsStandingLeftInCover && num2 > -5f)) && !flag2 && !flag)
				{
					_isAimingThroughCoverPlane = true;
				}
				else
				{
					_hasCoverPlaneAngle = false;
				}
			}
			if (_isAimingThroughCoverPlane && IsAimingGun)
			{
				if (IsInLowCover)
				{
					if (flag)
					{
						setCoverOffsets( false, true, Vector3.zero, -_cover.ForwardDirection * 0.4f);
					}
					else
					{
						setCoverOffsets( false, false, Vector3.zero, Vector3.zero);
					}
					return;
				}
				bool flag3 = true;
				bool flag4 = false;
				Vector3 sideOffset = Vector3.zero;
				Vector3 backOffset = Vector3.zero;
				if (!_currentMovement.IsMoving)
				{
					float margin = (!IsZooming) ? 0f : (-10f);
					if (IsStandingLeftInCover && IsByAnOpenLeftCorner && (_inputMovement.Magnitude < 0.5f || _inputMovement.Direction.magnitude < 0.1f || _cover.Main.IsLeft(Util.HorizontalAngle(_inputMovement.Direction), -5f)))
					{
						if (!_cover.HasLeftAdjacent || Mathf.DeltaAngle(_cover.Main.Angle, _cover.LeftAdjacent.Angle) > -30f)
						{
							float t = Mathf.Clamp01((25f - Mathf.DeltaAngle(_horizontalAngle, _cover.Main.Angle + 25f)) / 25f);
							sideOffset = -_cover.Main.Right * Mathf.Lerp(0.25f, 0.45f, t);
							backOffset = -_cover.ForwardDirection * 0.25f;
							flag4 = true;
						}
						flag3 = (!_cover.Main.IsLeft(_horizontalAngle, margin) || !flag4);
					}
					else if (!IsStandingLeftInCover && IsByAnOpenRightCorner && (_inputMovement.Magnitude < 0.5f || _inputMovement.Direction.magnitude < 0.1f || _cover.Main.IsRight(Util.HorizontalAngle(_inputMovement.Direction), -5f)))
					{
						if (!_cover.HasRightAdjacent || Mathf.DeltaAngle(_cover.Main.Angle, _cover.RightAdjacent.Angle) < 30f)
						{
							float t2 = Mathf.Clamp01((25f - Mathf.DeltaAngle(_cover.Main.Angle - 25f, _horizontalAngle)) / 25f);
							sideOffset = _cover.Main.Right * Mathf.Lerp(0.25f, 0.45f, t2);
							backOffset = -_cover.ForwardDirection * 0.25f;
							flag4 = true;
						}
						flag3 = (!_cover.Main.IsRight(_horizontalAngle, margin) || !flag4);
					}
				}
				if (flag3)
				{
					float t3 = Mathf.Clamp01((90f - Mathf.Abs(Mathf.DeltaAngle(_horizontalAngle, _cover.Main.Angle))) / 90f);
					backOffset = -_cover.ForwardDirection * Mathf.Lerp(0.4f, 0.6f, t3);
				}
				setCoverOffsets(flag4, flag3, sideOffset, backOffset);
			}
			else
			{
				setCoverOffsets( false, false, Vector3.zero, Vector3.zero);
			}
			return;
			IL_01e0:
			flag2 = true;
			_isAimingThroughCoverPlane = true;
			_hasCoverPlaneAngle = false;
			goto IL_028b;
		}

		private void setCoverOffsets(bool side, bool back, Vector3 sideOffset, Vector3 backOffset)
		{
			if (_cover.Main == null)
			{
				_backOffset = CoverOffsetState.None;
				_sideOffset = CoverOffsetState.None;
			}
			else if (IsMovingToCoverOffset || (!internalIsWalkingAnimation && !internalIsCoverAnimation))
			{
				if ((_backOffset == CoverOffsetState.Entering || _backOffset == CoverOffsetState.Using) && !back)
				{
					_backOffset = CoverOffsetState.None;
					_coverOffsetBack = backOffset;
					_coverOffsetBackTarget = backOffset;
				}
				else if ((_backOffset == CoverOffsetState.Exiting || _backOffset == CoverOffsetState.None) && back)
				{
					_backOffset = CoverOffsetState.Using;
					_coverOffsetBack = backOffset;
					_coverOffsetBackTarget = backOffset;
				}
				if ((_sideOffset == CoverOffsetState.Entering || _backOffset == CoverOffsetState.Using) && !side)
				{
					_sideOffset = CoverOffsetState.None;
					_coverOffsetSide = sideOffset;
					_coverOffsetSideTarget = sideOffset;
				}
				else if ((_sideOffset == CoverOffsetState.Exiting || _sideOffset == CoverOffsetState.None) && side)
				{
					_sideOffset = CoverOffsetState.Using;
					_coverOffsetSide = sideOffset;
					_coverOffsetSideTarget = sideOffset;
				}
			}
			else if (IsMoving)
			{
				_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
				_backOffset = (back ? CoverOffsetState.Using : CoverOffsetState.None);
				_sideOffset = (side ? CoverOffsetState.Using : CoverOffsetState.None);
				_coverOffsetBack = ((!back) ? Vector3.zero : backOffset);
				_coverOffsetSide = ((!side) ? Vector3.zero : sideOffset);
				_coverOffsetSideIsRight = _cover.IsStandingRight;
				_initialOffsetPosition = base.transform.position;
			}
			else if (back && _backOffset == CoverOffsetState.None)
			{
				if (_sideOffset == CoverOffsetState.Using || IsInLowCover)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					_animator.SetInteger("CoverOffsetDirection", 1);
					_animator.SetTrigger("StepBack");
				}
				else if (side)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = false;
					_animator.SetInteger("CoverOffsetDirection", 1);
					_animator.SetTrigger("CornerAim");
				}
				else if (_coverAim.Step == AimStep.Aiming)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					_animator.SetInteger("CoverOffsetDirection", 1);
					_animator.SetTrigger("StepRight");
				}
				else
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = false;
					_animator.SetInteger("CoverOffsetDirection", 1);
					_animator.SetTrigger("WallAim");
				}
				beginCoverOffsetTransition(side, back, sideOffset, backOffset);
			}
			else if (!back && _backOffset == CoverOffsetState.Using)
			{
				if (side || IsInLowCover)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					_animator.SetInteger("CoverOffsetDirection", -1);
					_animator.SetTrigger("StepBack");
				}
				else if (_coverAim.Step == AimStep.Aiming && !_isAimingThroughCoverPlane)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					_animator.SetInteger("CoverOffsetDirection", -1);
					_animator.SetTrigger("StepRight");
				}
				else
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = false;
					_animator.SetInteger("CoverOffsetDirection", -1);
					_animator.SetTrigger("WallAim");
				}
				beginCoverOffsetTransition(side, back, sideOffset, backOffset);
			}
			else if (side && _sideOffset == CoverOffsetState.None)
			{
				if (_wasAimingGun)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					if (_cover.Main.IsFrontField(_horizontalAngle, 90f))
					{
						_animator.SetInteger("CoverOffsetDirection", 1);
						_animator.SetTrigger("StepRight");
					}
					else
					{
						if (_coverOffsetSideIsRight)
						{
							if (_cover.Main.IsRight(_horizontalAngle))
							{
								_animator.SetInteger("CoverOffsetDirection", -1);
							}
							else
							{
								_animator.SetInteger("CoverOffsetDirection", 1);
							}
						}
						else if (_cover.Main.IsLeft(_horizontalAngle))
						{
							_animator.SetInteger("CoverOffsetDirection", -1);
						}
						else
						{
							_animator.SetInteger("CoverOffsetDirection", 1);
						}
						_animator.SetTrigger("StepBack");
					}
				}
				else
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = false;
					_animator.SetInteger("CoverOffsetDirection", 1);
					_animator.SetTrigger("CornerAim");
				}
				beginCoverOffsetTransition(side, back, sideOffset, backOffset);
			}
			else if (!side && _sideOffset == CoverOffsetState.Using)
			{
				if (IsAiming)
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = true;
					if (_cover.Main.IsFrontField(_horizontalAngle, 90f))
					{
						_animator.SetInteger("CoverOffsetDirection", -1);
						_animator.SetTrigger("StepRight");
					}
					else
					{
						if (_coverOffsetSideIsRight)
						{
							if (_cover.Main.IsRight(_horizontalAngle))
							{
								_animator.SetInteger("CoverOffsetDirection", 1);
							}
							else
							{
								_animator.SetInteger("CoverOffsetDirection", -1);
							}
						}
						else if (_cover.Main.IsLeft(_horizontalAngle))
						{
							_animator.SetInteger("CoverOffsetDirection", 1);
						}
						else
						{
							_animator.SetInteger("CoverOffsetDirection", -1);
						}
						_animator.SetTrigger("StepBack");
					}
				}
				else
				{
					_canAimInThisOffsetAnimationOrIsAtTheEndOfIt = false;
					_animator.SetInteger("CoverOffsetDirection", -1);
					_animator.SetTrigger("CornerAim");
				}
				beginCoverOffsetTransition(side, back, sideOffset, backOffset);
			}
			else
			{
				if (_sideOffset == CoverOffsetState.Using && side)
				{
					_coverOffsetSideTarget = sideOffset;
					_coverOffsetSide = sideOffset;
				}
				if (_backOffset == CoverOffsetState.Using && back)
				{
					_coverOffsetBackTarget = backOffset;
					_coverOffsetBack = backOffset;
				}
			}
		}

		private void beginCoverOffsetTransition(bool side, bool back, Vector3 sideOffset, Vector3 forwardOffset)
		{
			_coverOffsetSideIsRight = _cover.IsStandingRight;
			_initialOffsetPosition = base.transform.position;
			if (side && _sideOffset == CoverOffsetState.None)
			{
				_sideOffset = CoverOffsetState.Entering;
				_coverOffsetSideTarget = sideOffset;
			}
			if (back && _backOffset == CoverOffsetState.None)
			{
				_backOffset = CoverOffsetState.Entering;
				_coverOffsetBackTarget = forwardOffset;
			}
			if (!side && _sideOffset == CoverOffsetState.Using)
			{
				_sideOffset = CoverOffsetState.Exiting;
			}
			if (!back && _backOffset == CoverOffsetState.Using)
			{
				_backOffset = CoverOffsetState.Exiting;
			}
		}

		private void updateAngles()
		{
			Vector3 vector = _bodyTarget - VirtualHead;
			_horizontalAngle = Util.HorizontalAngle(vector);
			_verticalAngle = Util.VerticalAngle(vector);
		}

		private void loadBullet()
		{
			_isLoadingBullet = true;
			_animator.SetTrigger("LoadBullet");
			BaseGun gun = EquippedWeapon.Gun;
			if (gun != null)
			{
				gun.NotifyBulletLoadStart();
			}
		}

		private void showEquippedWeapon(bool showShield)
		{
			if (_equippedWeapon.RightItem != null && !_equippedWeapon.RightItem.activeSelf)
			{
				_equippedWeapon.RightItem.SetActive(value: true);
			}
			if (_equippedWeapon.RightHolster != null && _equippedWeapon.RightHolster.activeSelf)
			{
				_equippedWeapon.RightHolster.SetActive(value: false);
			}
			if (_equippedWeapon.IsDualWielding)
			{
				if (_equippedWeapon.LeftItem != null && !_equippedWeapon.LeftItem.activeSelf)
				{
					_equippedWeapon.LeftItem.SetActive(value: true);
				}
				if (_equippedWeapon.LeftHolster != null && _equippedWeapon.LeftHolster.activeSelf)
				{
					_equippedWeapon.LeftHolster.SetActive(value: false);
				}
			}
			else
			{
				if (_equippedWeapon.LeftItem != null && !_equippedWeapon.LeftItem.activeSelf)
				{
					_equippedWeapon.LeftItem.SetActive(value: false);
				}
				if (_equippedWeapon.LeftHolster != null && !_equippedWeapon.LeftHolster.activeSelf)
				{
					_equippedWeapon.LeftHolster.SetActive(value: true);
				}
			}
			if (showShield && _equippedWeapon.Shield != null && !_equippedWeapon.Shield.activeSelf)
			{
				_equippedWeapon.Shield.SetActive(value: true);
			}
		}

		private void hideEquippedWeapon()
		{
			if (_equippedWeapon.RightItem != null && _equippedWeapon.RightItem.activeSelf)
			{
				_equippedWeapon.RightItem.SetActive(value: false);
			}
			if (_equippedWeapon.RightHolster != null && !_equippedWeapon.RightHolster.activeSelf)
			{
				_equippedWeapon.RightHolster.SetActive(value: true);
			}
			if (_equippedWeapon.LeftItem != null && _equippedWeapon.LeftItem.activeSelf)
			{
				_equippedWeapon.LeftItem.SetActive(value: false);
			}
			if (_equippedWeapon.LeftHolster != null && !_equippedWeapon.LeftHolster.activeSelf)
			{
				_equippedWeapon.LeftHolster.SetActive(value: true);
			}
			if (_equippedWeapon.Shield != null && _equippedWeapon.Shield.activeSelf)
			{
				_equippedWeapon.Shield.SetActive(value: false);
			}
			if (_equippedWeapon.Gun != null)
			{
				_equippedWeapon.Gun.CancelFire();
			}
		}

		private void updateCapsule()
		{
			if (IsAlive)
			{
				if (_capsule.isTrigger)
				{
					_capsule.isTrigger = false;
				}
				float num = (!_isClimbingAVault) ? ClimbSettings.CollisionOff : VaultSettings.CollisionOff;
				float num2 = (!_isClimbingAVault) ? ClimbSettings.CollisionOn : VaultSettings.CollisionOn;
				if (_isClimbing && _normalizedClimbTime >= num && _normalizedClimbTime < num2 && num < num2)
				{
					_capsule.enabled = false;
				}
				else
				{
					if (!_capsule.enabled)
					{
						_groundTimer = 0f;
					}
					_capsule.enabled = true;
				}
				_capsule.height = Util.Lerp(_capsule.height, TargetHeight, 10f);
				CapsuleCollider capsule = _capsule;
				Vector3 center = _capsule.center;
				float x = center.x;
				float y = _defaultCapsuleCenter - (_defaultCapsuleHeight - _capsule.height) * 0.5f;
				Vector3 center2 = _capsule.center;
				capsule.center = new Vector3(x, y, center2.z);
				if (_previousCapsuleHeight != _capsule.height)
				{
					for (int i = 0; i < _heightListeners.Length; i++)
					{
						_heightListeners[i].OnCurrentHeight(_capsule.height);
					}
					if (CurrentHeightChanged != null)
					{
						CurrentHeightChanged(_capsule.height);
					}
				}
			}
			else if (!_capsule.isTrigger)
			{
				_capsule.isTrigger = true;
			}
		}

		private void updateRolling()
		{
			if (_isIntendingToRoll)
			{
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (equippedWeapon.IsHeavy)
				{
					_isIntendingToRoll = false;
				}
			}
			updateGround();
			if (_isIntendingToRoll && !_isRolling)
			{
				Vector3 eulerAngles = base.transform.eulerAngles;
				if (Mathf.Abs(Mathf.DeltaAngle(eulerAngles.y, _rollAngle)) < 60f)
				{
					_animator.SetTrigger("Roll");
					_isIntendingToRoll = false;
					_isRolling = true;
				}
			}
		}

		private void updateUse()
		{
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_isUsingWeapon && !_keepUsingWeapon && _wasWeaponUsed)
			{
				_isUsingWeapon = false;
			}
			if (!_isUsingWeapon)
			{
				_coverAim.Leave();
			}
			else if ((!(equippedWeapon.Tool != null) || !_isUsingWeaponAlternate) ? equippedWeapon.Tool.HasAiming : equippedWeapon.Tool.HasAlternateAiming)
			{
				_coverAim.CoverAim(_horizontalAngle);
			}
		}

		private void hideGrenade(ref GameObject instantiated, GameObject grenade)
		{
			if (instantiated != null)
			{
				UnityEngine.Object.Destroy(instantiated);
				instantiated = null;
			}
			hideGrenade(grenade);
		}

		private void hideGrenade(GameObject grenade)
		{
			if (grenade != null && grenade.activeSelf)
			{
				grenade.SetActive(value: false);
			}
		}

		private void showGrenade(GameObject grenade)
		{
			if (grenade != null && !grenade.activeSelf)
			{
				grenade.SetActive(value: true);
			}
		}

		private void dropThrow()
		{
			if (_isThrowing)
			{
				_throwVelocity = Vector3.zero;
				if (_isGoingToThrowLeft)
				{
					throwGrenade(_leftGrenade, useRigidBody: false);
					_leftGrenade = null;
				}
				else
				{
					throwGrenade(_rightGrenade, useRigidBody: false);
					_rightGrenade = null;
				}
				_isThrowing = false;
				_hasThrown = true;
			}
		}

		private void executeThrow()
		{
			if (_isThrowing)
			{
				if (_isGoingToThrowLeft)
				{
					throwGrenade(_leftGrenade, useRigidBody: true);
					_leftGrenade = null;
				}
				else
				{
					throwGrenade(_rightGrenade, useRigidBody: true);
					_rightGrenade = null;
				}
				_isThrowing = false;
				_hasThrown = true;
			}
		}

		private void throwGrenade(GameObject grenade, bool useRigidBody)
		{
			if (grenade == null)
			{
				return;
			}
			grenade.transform.SetParent(null, worldPositionStays: true);
			Rigidbody component = grenade.GetComponent<Rigidbody>();
			if (component != null)
			{
				component.isKinematic = false;
				if (useRigidBody)
				{
					component.velocity += (Util.HorizontalVector(_throwBodyAngle) + Vector3.up).normalized * Grenade.MaxVelocity;
				}
			}
			Grenade component2 = grenade.GetComponent<Grenade>();
			if (component2 != null)
			{
				component2.Activate(_actor);
				component2.Fly(_throwOrigin, _throwVelocity, Grenade.Gravity);
			}
		}

		private GameObject cloneGrenade(GameObject grenade, GameObject location)
		{
			if (grenade == null)
			{
				return null;
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(grenade);
			gameObject.transform.SetParent(location.transform.parent);
			gameObject.transform.position = location.transform.position;
			gameObject.transform.rotation = location.transform.rotation;
			gameObject.transform.localScale = location.transform.localScale;
			Collider component = gameObject.GetComponent<Collider>();
			if (component != null)
			{
				Physics.IgnoreCollision(_capsule, component, ignore: true);
				Physics.IgnoreCollision(location.GetComponent<Collider>(), component, ignore: true);
			}
			gameObject.SetActive(value: true);
			return gameObject;
		}

		private void recreateGrenades(GameObject grenadeOverride = null)
		{
			hideGrenade(ref _leftGrenade, Grenade.Left);
			hideGrenade(ref _rightGrenade, Grenade.Right);
			_leftGrenade = cloneGrenade((!(grenadeOverride != null)) ? Grenade.Left : grenadeOverride, Grenade.Left);
			_rightGrenade = cloneGrenade((!(grenadeOverride != null)) ? Grenade.Right : grenadeOverride, Grenade.Right);
			updateCloneGrenadeVisibility();
		}

		private void updateGrenade()
		{
			if (_isThrowing)
			{
				if (!_hasBeganThrowAnimation)
				{
					Vector3 eulerAngles = base.transform.eulerAngles;
					if (Mathf.Abs(Mathf.DeltaAngle(eulerAngles.y, _throwBodyAngle)) < 30f)
					{
						_hasBeganThrowAnimation = true;
						_animator.SetTrigger("ThrowGrenade");
					}
				}
			}
			else if (_isGrenadeTakenOut)
			{
				updateCloneGrenadeVisibility();
			}
			else
			{
				hideGrenade(ref _leftGrenade, Grenade.Left);
				hideGrenade(ref _rightGrenade, Grenade.Right);
			}
			if (!internalIsGrenadeAnimation && !_isThrowing)
			{
				if (_hasThrown)
				{
					updateCoverDirection(_throwBodyAngle);
				}
				_hasThrown = false;
			}
		}

		private void performPump()
		{
			_isPumping = true;
			_willPerformPump = false;
			_animator.SetTrigger("Pump");
			BaseGun gun = EquippedWeapon.Gun;
			if (gun != null)
			{
				gun.NotifyPumpStart();
			}
		}

		private void updateCloneGrenadeVisibility()
		{
			if (IsThrowingLeft)
			{
				showGrenade(_leftGrenade);
				hideGrenade(_rightGrenade);
			}
			else
			{
				hideGrenade(_leftGrenade);
				showGrenade(_rightGrenade);
			}
		}

		private Vector3 lerpRelativePosition(Vector3 from, Vector3 to, float speed)
		{
			Vector3 value = from - base.transform.position;
			Vector3 target = to - base.transform.position;
			float magnitude = value.magnitude;
			float magnitude2 = target.magnitude;
			if (magnitude > float.Epsilon)
			{
				value.Normalize();
			}
			if (magnitude2 > float.Epsilon)
			{
				target.Normalize();
			}
			Vector3 a = Util.Lerp(value, target, speed);
			float d = Util.Lerp(magnitude, magnitude2, speed);
			return base.transform.position + a * d;
		}

		private void moveAndRotate()
		{
			if (_isMoving && _useSprintingAnimation)
			{
				_horizontalAngle = Util.HorizontalAngle(_currentMovement.Direction);
			}
			updateBodyAngleDiff();
			_currentBodyTarget = lerpRelativePosition(_currentBodyTarget, _bodyTarget, _bodyTurnSpeed);
			if (_cover.In)
			{
				stickToCover();
			}
			Vector3 vector = _animator.deltaPosition / Time.deltaTime;
			float magnitude = vector.magnitude;
			if (IsAlive)
			{
				if (IsMovingToCoverOffset)
				{
					if (!_canAimInThisOffsetAnimationOrIsAtTheEndOfIt || !IsAiming)
					{
						Transform transform = base.transform;
						Vector3 eulerAngles = _animator.deltaRotation.eulerAngles;
						transform.Rotate(0f, eulerAngles.y, 0f);
					}
					else
					{
						Vector3 eulerAngles2 = base.transform.eulerAngles;
						_horizontalAngleDiff = Mathf.DeltaAngle(eulerAngles2.y, _horizontalAngle);
						turn(TurnSettings.StandingRotationSpeed);
					}
				}
				else if (_isClimbing)
				{
					float y = vector.y;
					vector *= ((!_isClimbingAVault) ? ClimbSettings.HorizontalScale : VaultSettings.HorizontalScale);
					if (_isClimbingAVault)
					{
						if (_normalizedClimbTime >= VaultSettings.PushOn && _normalizedClimbTime < VaultSettings.PushOff)
						{
							vector += _climbDirection * VaultSettings.Push;
						}
					}
					else if (_normalizedClimbTime >= ClimbSettings.PushOn && _normalizedClimbTime < ClimbSettings.PushOff)
					{
						vector += _climbDirection * ClimbSettings.Push;
					}
					if (_isClimbingAVault)
					{
						if (_normalizedClimbTime >= 0.5f && y < 0f)
						{
							Vector3 velocity = _body.velocity;
							vector.y = velocity.y - Gravity * Time.deltaTime;
						}
						else
						{
							vector.y = y * VaultSettings.VerticalScale;
						}
					}
					else
					{
						vector.y = y * ClimbSettings.VerticalScale;
					}
					_body.velocity = vector;
					float num = Mathf.Abs(Mathf.DeltaAngle(_climbAngle, _horizontalAngle)) / 180f;
					num = Mathf.Clamp01((num - 0.5f) * 2f);
					float t = (1f - num * num) * Mathf.Clamp01((_normalizedClimbTime - 0.3f) / 0.599999964f);
					float y2 = Mathf.LerpAngle(_climbAngle, _horizontalAngle, t);
					base.transform.rotation = Util.Lerp(base.transform.rotation, Quaternion.Euler(0f, y2, 0f), 20f);
				}
				else if (_isRolling || _isIntendingToRoll)
				{
					turn(RollSettings.RotationSpeed);
					if (_isRolling && _isGrounded)
					{
						Vector3 velocity2 = _body.velocity;
						vector.y = velocity2.y - Gravity * Time.deltaTime;
						vector = ((!(_potentialCover == null)) ? (vector - _potentialCover.Forward * Vector3.Dot(_potentialCover.Forward, vector)) : (vector - base.transform.right * Vector3.Dot(base.transform.right, vector)));
						applyVelocityToTheGround(vector);
					}
					else if (_isRolling)
					{
						Vector3 Value = _body.velocity;
						Value.y = 0f;
						Util.Lerp(ref Value, Vector3.zero, 1f);
						Rigidbody body = _body;
						float x = Value.x;
						Vector3 velocity3 = _body.velocity;
						body.velocity = new Vector3(x, velocity3.y, Value.z);
					}
				}
				else if (_isJumping || _isIntendingToJump)
				{
					turn(JumpSettings.RotationSpeed);
				}
				else if (!_isGrounded)
				{
					turn(JumpSettings.RotationSpeed);
				}
				else if (_isGettingHit)
				{
					_body.velocity = _animator.deltaPosition / Time.deltaTime;
					base.transform.rotation = _animator.deltaRotation * base.transform.rotation;
				}
				else if (_isPerformingCustomAction || _useMeleeRootMotion)
				{
					if (_useMeleeRootMotion)
					{
						turn(TurnSettings.MeleeAttackRotationSpeed);
					}
					applyVelocityToTheGround(vector);
					base.transform.rotation = _animator.deltaRotation * base.transform.rotation;
				}
				else
				{
					if (_isPerformingCustomAction || _isInProcess || (_wouldTurnImmediately && !isInAnimatedCover && (_aimTimer > 0.2f || !IsInTallCover)))
					{
						base.transform.Rotate(0f, _horizontalAngleDiff, 0f);
						_horizontalAngleDiff = 0f;
					}
					else if (_isThrowing && !_hasThrown)
					{
						turn(TurnSettings.GrenadeRotationSpeed);
					}
					else
					{
						WeaponDescription equippedWeapon = EquippedWeapon;
						float speed = _cover.In ? ((!IsInTallCover) ? CoverSettings.LowRotationSpeed : CoverSettings.TallRotationSpeed) : (IsSprinting ? TurnSettings.SprintingRotationSpeed : ((equippedWeapon.HasMelee && equippedWeapon.Gun == null) ? TurnSettings.MeleeIdleRotationSpeed : ((equippedWeapon.IsNull && !(_movementInput > 0.5f)) ? TurnSettings.StandingRotationSpeed : TurnSettings.RunningRotationSpeed)));
						turn(speed);
					}
					if (_cover.In)
					{
						if (magnitude > float.Epsilon)
						{
							Vector3 vector2 = (!(Vector3.Dot(vector, _cover.Main.Left) > Vector3.Dot(vector, _cover.Main.Right))) ? _cover.Main.Right : _cover.Main.Left;
							applyVelocityToTheGround(MoveMultiplier * vector2 * Vector3.Dot(vector2, vector) * Vector3.Dot(_currentMovement.Direction, vector / magnitude));
						}
						else
						{
							Rigidbody body2 = _body;
							Vector3 velocity4 = _body.velocity;
							body2.velocity = new Vector3(0f, velocity4.y, 0f);
						}
					}
					else if (_movementInput > float.Epsilon)
					{
						float magnitude2 = vector.magnitude;
						if (magnitude2 > float.Epsilon)
						{
							float t2 = 1f;
							Vector3 vector3 = _currentMovement.Direction;
							float magnitude3 = vector3.magnitude;
							if (magnitude3 > float.Epsilon)
							{
								vector3 /= magnitude3;
							}
							else
							{
								t2 = 0f;
							}
							Vector3 a = Vector3.Lerp(vector / magnitude2, vector3, t2);
							applyVelocityToTheGround(MoveMultiplier * a * magnitude2 * _movementInput);
						}
					}
					else
					{
						_body.velocity = Vector3.zero;
					}
				}
			}
			Vector3 eulerAngles3 = base.transform.eulerAngles;
			float num2 = eulerAngles3.y + _horizontalAngleDiff;
			float num3 = Mathf.DeltaAngle(_currentAnimatedAngle, num2);
			_stepCursor += Time.deltaTime / _stepDuration;
			float num4 = (!(num3 >= 0f)) ? (-1f) : 1f;
			if (_currentStep * num4 < 0f)
			{
				_currentStep = 0f;
				_stepCursor = 0f;
			}
			float num5 = num3;
			if (num5 * num4 > _maxAnimatedStep)
			{
				num5 = _maxAnimatedStep * num4;
			}
			else if (num5 * num4 < _minAnimatedStep)
			{
				_currentStep = 0f;
				_stepCursor = 0f;
				num5 = 0f;
			}
			if (_currentStep * num4 < num5 * num4)
			{
				if (num5 * num4 > float.Epsilon)
				{
					_stepCursor *= _currentStep / num5;
				}
				else
				{
					_stepCursor = 0f;
				}
				_currentStep = num5;
			}
			if (_stepCursor >= 1f)
			{
				_currentAnimatedAngle = num2;
				_stepCursor = 0f;
			}
		}

		private void applyVelocityToTheGround(Vector3 velocity)
		{
			velocity.y = 0f;
			if (_isOnSlope && _isGrounded)
			{
				Vector3 axis = Vector3.Cross(_groundNormal, Vector3.up);
				axis.y = 0f;
				if (axis.sqrMagnitude > float.Epsilon)
				{
					axis.Normalize();
				}
				Vector3 velocity2 = Quaternion.AngleAxis(0f - _slope, axis) * velocity;
				float magnitude = velocity2.magnitude;
				if (magnitude > float.Epsilon)
				{
					float num = Mathf.Asin(velocity2.y / magnitude) * 57.29578f;
					if (num >= 26f)
					{
						velocity2 = Quaternion.AngleAxis(-26f, axis) * velocity;
						velocity2 *= 1f - Mathf.Clamp01((num - 26f) / (MaxSlope - 26f));
					}
					_body.velocity = velocity2;
				}
				else
				{
					_body.velocity = Vector3.zero;
				}
			}
			else
			{
				_body.velocity = velocity;
			}
		}

		private void turn(float speed)
		{
			float num = Util.Lerp(0f, _horizontalAngleDiff, speed * 0.3f);
			base.transform.Rotate(0f, num, 0f);
			_horizontalAngleDiff -= num;
		}

		private void clearPotentialCovers()
		{
			_potentialCover = null;
		}

		private void updateClimb()
		{
			if (_isClimbing)
			{
				updateWalk();
				_climbTime += Time.deltaTime;
				Vector3 climbOffset = _climbOffset;
				_climbOffset = Util.Lerp(_climbOffset, Vector3.zero, 100f);
				base.transform.position += _climbOffset - climbOffset;
				_isIntendingToJump = false;
				_isJumping = false;
				_nextJumpTimer = 0f;
				if (_normalizedClimbTime > 0.5f && _isClimbingAVault)
				{
					Vector3 velocity = _body.velocity;
					if (velocity.y < 0f && !findGround(FallThreshold) && !_isFalling)
					{
						_animator.SetTrigger("Fall");
						_isFalling = true;
						_isGrounded = false;
						Vector3 velocity2 = _body.velocity;
						Vector3 vector = base.transform.forward * Vector3.Dot(base.transform.forward, velocity2);
						_body.velocity = new Vector3(vector.x, velocity2.y, vector.z);
					}
				}
			}
			else
			{
				_climbTime = 0f;
			}
			if (!_isFalling)
			{
				updateGround();
			}
		}

		private bool startClimb(Cover cover, bool isVault)
		{
			if (!_isClimbing)
			{
				float top = cover.Top;
				Vector3 position = base.transform.position;
				if (top > position.y + 0.75f)
				{
					_normalizedClimbTime = 0f;
					_isClimbingAVault = isVault;
					_climbTime = 0f;
					_climbAngle = cover.Angle;
					_climbDirection = cover.Forward;
					Vector3 position2 = base.transform.position;
					Vector3 vector = cover.ClosestPointTo(position2 + Vector3.up * 0.2f, 0f - _capsule.radius, _capsule.radius * 0.8f - cover.Depth * 0.5f);
					int num = Physics.RaycastNonAlloc(vector - cover.Forward * _capsule.radius, cover.Forward, Util.Hits, _capsule.radius * 2f, Layers.Geometry, QueryTriggerInteraction.Ignore);
					for (int i = 0; i < num; i++)
					{
						if (!Util.InHiearchyOf(Util.Hits[i].collider.gameObject, base.gameObject))
						{
							vector = Util.Hits[i].point - cover.Forward * _capsule.radius * 0.8f;
							break;
						}
					}
					vector.y = position2.y;
					_climbOffset = position2 - vector;
					_climbHeight = cover.Top - vector.y;
					_vaultPosition = position2.y;
					_cover.Clear();
					_animator.SetTrigger("Climb");
					_isJumping = false;
					_ignoreJumpTimer = 0.2f;
					return true;
				}
			}
			return false;
		}

		private void updateCover(bool isForcedToMaintain)
		{
			if (_cover.In && IsMovingToCoverOffset)
			{
				return;
			}
			bool @in = _cover.In;
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			if (_cover.In)
			{
				flag = IsNearLeftCorner;
				flag2 = IsNearRightCorner;
			}
			else
			{
				_sideOffset = CoverOffsetState.None;
				_backOffset = CoverOffsetState.None;
				_coverOffset = Vector3.zero;
				_coverOffsetBack = Vector3.zero;
				_coverOffsetSide = Vector3.zero;
				flag3 = IsAiming;
			}
			Vector3 vector = (!_cover.In) ? base.transform.position : (base.transform.position - _coverOffset);
			float takeRadius = CoverSettings.EnterDistance + CoverSettings.CornerAimTriggerDistance;
			Vector3 position = _animator.GetBoneTransform(HumanBodyBones.Head).position;
			if (_isGrounded)
			{
				_coverSearch.Update(_cover, vector, position, takeRadius, CoverSettings.MaxCrouchDistance, 0f, _capsule.radius, CoverSettings);
			}
			else
			{
				_coverSearch.Clear();
			}
			if (_cover.In && _isGrounded && (isForcedToMaintain || _inputMovement.IsMoving || !IsAiming))
			{
				_cover.Maintain(_coverSearch, vector);
			}
			_potentialCover = null;
			if (_needToEnterCoverByWalkingToIt)
			{
				if (!_cover.Take(_coverSearch, vector))
				{
					_needToEnterCoverByWalkingToIt = false;
				}
				float angle = Util.HorizontalAngle(_inputMovement.Direction);
				if (_cover.Main == null || _inputMovement.Magnitude < 0.5f || _inputMovement.Direction.magnitude < 0.01f || !_cover.Main.IsFrontField(angle, 160f))
				{
					_cover.Clear();
				}
				else if (_cover.HasLeftCorner && _cover.Main.IsLeft(angle) && Vector3.Dot(_cover.Main.Left, vector - _cover.Main.LeftCorner(vector.y)) > -0.1f)
				{
					_cover.Clear();
				}
				else if (_cover.HasRightCorner && _cover.Main.IsRight(angle) && Vector3.Dot(_cover.Main.Right, vector - _cover.Main.RightCorner(vector.y)) > -0.1f)
				{
					_cover.Clear();
				}
				else
				{
					_coverOffset = Vector3.zero;
					_needToEnterCoverByWalkingToIt = false;
				}
			}
			else if (!_cover.In)
			{
				if (!_isClimbing && _isGrounded && _wantsToTakeCover)
				{
					bool flag4 = _cover.Take(_coverSearch, vector);
					if (_cover.In && _wantsToClimbCover != null)
					{
						_cover.Clear();
					}
					else if (flag4)
					{
						if (!_wantsToFaceInADirection && _cover.Main != null)
						{
							Cover main = _cover.Main;
							Vector3 eulerAngles = base.transform.eulerAngles;
							if (main.IsLeft(eulerAngles.y))
							{
								_cover.StandLeft();
							}
							else
							{
								_cover.StandRight();
							}
							_directionChangeDelay = CoverSettings.DirectionChangeDelay;
						}
						_coverOffset = Vector3.zero;
						instantCoverAnimatorUpdate();
					}
				}
				else
				{
					_potentialCover = _coverSearch.FindClosest();
				}
			}
			if (_cover.In)
			{
				_hasCrouchCover = !_cover.IsTall;
				_crouchCoverPosition = vector;
				if (!@in && _stopAimingWhenEnteringCover)
				{
					_wantsToAim = false;
					_coverAim.ImmediateLeave();
				}
				else if (flag3)
				{
					_coverAim.ImmediateEnter();
				}
				_wantsToJump = false;
			}
			else
			{
				_hasCrouchCover = (_wantsToCrouchNearCovers && !EquippedWeapon.IsNull && _coverSearch.FindClosestCrouchPosition(ref _crouchCoverPosition));
				_wasMovingInCover = false;
			}
		}

		private void unmirror()
		{
			if (_ik.HasSwitchedHands)
			{
				_ik.Unmirror();
				float @float = _animator.GetFloat("CoverDirection");
				_animator.SetFloat("CoverDirection", @float * -1f);
			}
		}

		private void mirror()
		{
			if (!_ik.HasSwitchedHands && IsEquipped)
			{
				WeaponDescription equippedWeapon = EquippedWeapon;
				if (!(equippedWeapon.RightItem == null) || !(equippedWeapon.LeftItem == null))
				{
					Transform right = (!(equippedWeapon.RightItem == null)) ? equippedWeapon.RightItem.transform : null;
					Transform left = (!(equippedWeapon.LeftItem == null)) ? equippedWeapon.LeftItem.transform : null;
					_ik.Mirror(right, left, equippedWeapon.PreferSwapping);
					float @float = _animator.GetFloat("CoverDirection");
					_animator.SetFloat("CoverDirection", @float * -1f);
				}
			}
		}

		private void updateWeapons()
		{
			if ((_weaponEquipState == WeaponEquipState.equipped || _weaponEquipState == WeaponEquipState.unequipped) && _isGrounded && !_isPerformingMelee && !_isGettingHit && !HasGrenadeInHand && !IsReloading && ((!IsEquipped) ? (!_equippedWeapon.IsNull) : (!Weapon.IsTheSame(ref _equippedWeapon))))
			{
				if (_isUsingWeapon && _wasWeaponUsed)
				{
					_isUsingWeapon = false;
					_wasWeaponUsed = false;
				}
				if (!_isUsingWeapon)
				{
					if (_weaponEquipState == WeaponEquipState.equipped)
					{
						unmirror();
						_weaponEquipState = WeaponEquipState.unequipping;
						_animator.ResetTrigger("Hit");
						_animator.ResetTrigger("ComboHit");
						_animator.SetTrigger("Unequip");
						if (_equippedWeapon.Gun != null)
						{
							_equippedWeapon.Gun.CancelFire();
						}
					}
					else if (!_isUnequippedButGoingToGrab)
					{
						unmirror();
						_isUnequippedButGoingToGrab = true;
						_equippedWeapon = default(WeaponDescription);
						_equippingWeapon = Weapon;
						_animator.ResetTrigger("Hit");
						_animator.ResetTrigger("ComboHit");
						_animator.SetTrigger("Equip");
					}
					for (int i = 0; i < _weaponChangeListeners.Length; i++)
					{
						_weaponChangeListeners[i].OnWeaponChangeStart();
					}
					if (WeaponChangeStarted != null)
					{
						WeaponChangeStarted();
					}
				}
			}
			if (HasGrenadeInHand)
			{
				hideEquippedWeapon();
			}
			else if (_weaponEquipState == WeaponEquipState.equipped)
			{
				showEquippedWeapon(showShield: true);
			}
			BaseGun gun = _equippedWeapon.Gun;
			if (gun != null)
			{
				gun.Character = this;
				Vector3 lhs = _aimTarget - base.transform.position;
				lhs.y = 0f;
				lhs.Normalize();
				gun.AddErrorThisFrame(MovementError);
				gun.SetBaseErrorMultiplierThisFrame((!IsZooming) ? 1f : ZoomErrorMultiplier);
				gun.Allow(IsGunReady && !_isFalling && (!_cover.In || _coverAim.Step == AimStep.Aiming) && Vector3.Dot(lhs, base.transform.forward) > 0.5f && _ik.IsAimingArms);
			}
			BaseMelee rightMelee = _equippedWeapon.RightMelee;
			if (rightMelee != null)
			{
				rightMelee.Character = this;
			}
			rightMelee = _equippedWeapon.LeftMelee;
			if (rightMelee != null)
			{
				rightMelee.Character = this;
			}
			if (_isUsingWeapon && internalIsToolAnimation)
			{
				Tool tool = _equippedWeapon.Tool;
				if (tool != null)
				{
					tool.ContinuousUse(this, _isUsingWeaponAlternate);
				}
			}
		}

		private void updateAim()
		{
			_coverAim.Update();
			bool flag = _wantsToAim;
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (!equippedWeapon.IsNull && equippedWeapon.Gun == null && equippedWeapon.Tool != null)
			{
				flag = (_isUsingWeapon && ((!_isUsingWeaponAlternate) ? equippedWeapon.Tool.HasAiming : equippedWeapon.Tool.HasAlternateAiming));
			}
			if (!_isClimbing && flag && IsGunScopeReady)
			{
				_coverAim.IsZoomed = true;
			}
			else
			{
				_coverAim.IsZoomed = false;
			}
		}

		private void updateMelee()
		{
			if (_isClimbing || HasGrenadeInHand || _isGettingHit)
			{
				return;
			}
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (_isPerformingMelee)
			{
				if (_checkForCombo && (_wantsToCombo || _wantsToHit) && !_isWaitingForComboHit)
				{
					_isWaitingForComboHit = true;
					_useMeleeRootMotion = true;
					_animator.SetInteger("MeleeType", meleeType);
					_animator.SetTrigger("ComboHit");
					_animator.ResetTrigger("Hit");
				}
			}
			else if (_wantsToHit && IsMeleeReady)
			{
				_isWaitingForComboHit = false;
				BaseMelee rightMelee = equippedWeapon.RightMelee;
				BaseMelee leftMelee = equippedWeapon.LeftMelee;
				BaseMelee baseMelee = (!(rightMelee == null)) ? rightMelee : leftMelee;
				if (baseMelee.Request())
				{
					_cover.Clear();
					_meleeScan = 0;
					_meleeMoment = 0;
					_animator.SetInteger("MeleeType", meleeType);
					_animator.SetTrigger("Hit");
					_animator.ResetTrigger("ComboHit");
				}
			}
			else
			{
				_isBlocking = _wantsToBlock;
			}
		}

		private void updateFire()
		{
			if (_isClimbing || HasGrenadeInHand)
			{
				return;
			}
			if (wantsToAim)
			{
				if (IsGunReady)
				{
					bool flag = !_isWeaponBlocked && !_isPumping && _postPumpDelay < float.Epsilon;
					BaseGun gun = EquippedWeapon.Gun;
					if (gun == null || gun.LoadedBulletsLeft == 0)
					{
						flag = false;
					}
					if (flag)
					{
						if (_wantsToFire)
						{
							if (_isLoadingBullet)
							{
								_isLoadingBullet = false;
								_animator.SetTrigger("InterruptLoad");
							}
							_coverAim.Angle = _horizontalAngle;
							if (_hasFireCondition)
							{
								gun.SetFireCondition(_fireConditionSide);
							}
							else
							{
								gun.CancelFireCondition();
							}
							if (_cover.In)
							{
								if (!gun.HasJustFired && !gun.IsAllowed)
								{
									gun.FireWhenReady();
								}
								else
								{
									gun.CancelFire();
									gun.TryFireNow();
								}
								if (!IsInTallCover || !_isAimingThroughCoverPlane || _backOffset == CoverOffsetState.Using || _sideOffset == CoverOffsetState.Using)
								{
									_coverAim.CoverAim(_horizontalAngle);
								}
								else
								{
									_coverAim.WaitAim(_horizontalAngle);
								}
							}
							else
							{
								_coverAim.FreeAim(_horizontalAngle);
								gun.CancelFire();
								gun.TryFireNow();
							}
						}
						else
						{
							_coverAim.CoverAim(_horizontalAngle);
						}
					}
					else
					{
						_coverAim.Leave();
					}
				}
				else if (!IsGunScopeReady)
				{
					_coverAim.Leave();
				}
			}
			else
			{
				_coverAim.Leave();
			}
		}

		internal void KeepAiming()
		{
			_postFireAimWait = 0.15f;
		}

		public bool IsFreeToMove(Vector3 direction)
		{
			return IsFree(direction, ObstacleDistance, 0.2f, coverMeansFree: false, actorMeansFree: true);
		}

		public bool IsFreeToMove(Vector3 direction, float distance, float height)
		{
			return IsFree(direction, distance, height, coverMeansFree: false, actorMeansFree: true);
		}

		public bool IsFree(Vector3 direction, float distance, float height, bool coverMeansFree, bool actorMeansFree)
		{
			return Util.IsFree(base.gameObject, base.transform.position + new Vector3(0f, _capsule.height * height, 0f), direction, _capsule.radius + distance, coverMeansFree, actorMeansFree);
		}

		private void updateCommon()
		{
			float num;
			if (!_inputMovement.IsMoving && !_isRolling && !(Vector3.Distance(_lastKnownPosition, base.transform.position) > 0.1f))
			{
				num = ((!_cover.In) ? CoverSettings.Update.IdleNonCover : CoverSettings.Update.IdleCover);
			}
			else
			{
				_lastKnownPosition = base.transform.position;
				num = ((!_cover.In) ? CoverSettings.Update.MovingNonCover : CoverSettings.Update.MovingCover);
			}
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.PreventCovers || _isPerformingMelee)
			{
				_cover.Clear();
			}
			else if (_coverUpdateTimer >= num - float.Epsilon || _needsToUpdateCoverBecauseOfDelay || _wantsToImmediatelyUpdatePotentialCover || (_wantsToTakeCover && _potentialCover != null))
			{
				if (_needsToUpdateCoverBecauseOfDelay)
				{
					_needsToUpdateCoverBecauseOfDelay = false;
					_wantsToTakeCover = true;
				}
				_coverUpdateTimer = UnityEngine.Random.Range(-0.05f, 0.1f);
				updateCover(isForcedToMaintain: false);
			}
			if (_isWeaponBlocked && _hasCrouchCover && wantsToAim)
			{
				_hasCrouchCover = false;
			}
			WeaponDescription equippedWeapon2 = EquippedWeapon;
			if (equippedWeapon2.PreventClimbing)
			{
				_wantsToClimbCover = null;
			}
			if (_wantsToClimbCover != null)
			{
				CoverClimb climb = getClimb(_wantsToClimbCover);
				if (climb != 0)
				{
					startClimb(_wantsToClimbCover, climb == CoverClimb.Vault);
					_wantsToClimbCover = null;
				}
			}
			updateRolling();
			if (_isRolling)
			{
				updateWalk();
				updateVertical();
				return;
			}
			updateAim();
			if (_isPerformingMelee)
			{
				updateMelee();
			}
			else if (_isUsingWeapon)
			{
				updateUse();
			}
			else
			{
				updateMelee();
				if (!_isPerformingMelee && !_isGettingHit)
				{
					updateFire();
				}
			}
			if (_isInProcess && !_process.CanMove)
			{
				updateGround();
				return;
			}
			updateWalk();
			updateVertical();
		}

		private void updateFeet()
		{
			if (!IsAlive)
			{
				return;
			}
			if (!_isGrounded || _isFalling || _isJumping || _isClimbing)
			{
				_previousLeftFootDirection = 0;
				_previousRightFootDirection = 0;
				_previousLeftFootHeight = 0f;
				_previousRightFootHeight = 0f;
				_hasRaisedLeftFoot = false;
				_hasRaisedRightFoot = false;
				return;
			}
			Vector3 position = _leftFoot.transform.position;
			float y = position.y;
			Vector3 position2 = base.transform.position;
			float num = y - position2.y;
			Vector3 position3 = _rightFoot.transform.position;
			float y2 = position3.y;
			Vector3 position4 = base.transform.position;
			float num2 = y2 - position4.y;
			Vector3 lossyScale = base.transform.lossyScale;
			float num3 = 0.005f * lossyScale.y;
			int num4 = (num > _previousLeftFootHeight + num3) ? 1 : ((!(num < _previousLeftFootHeight - num3)) ? _previousLeftFootDirection : (-1));
			int num5 = (num2 > _previousRightFootHeight + num3) ? 1 : ((!(num2 < _previousRightFootHeight - num3)) ? _previousRightFootDirection : (-1));
			Vector3 lossyScale2 = base.transform.lossyScale;
			_feetLevel = 0.14f * lossyScale2.y;
			Vector3 lossyScale3 = base.transform.lossyScale;
			float num6 = 0.05f * lossyScale3.y;
			if (num > _feetLevel + num6 && !_hasRaisedLeftFoot)
			{
				_hasRaisedLeftFoot = true;
			}
			else if (num < _feetLevel && _hasRaisedLeftFoot)
			{
				_hasRaisedLeftFoot = false;
				if (num4 < 0 && _groundTimer > 0.2f)
				{
					for (int i = 0; i < _physicsListeners.Length; i++)
					{
						_physicsListeners[i].OnFootstep(_leftFoot.transform.position);
					}
					if (Stepped != null)
					{
						Stepped();
					}
				}
			}
			if (num2 > _feetLevel + num6 && !_hasRaisedRightFoot)
			{
				_hasRaisedRightFoot = true;
			}
			else if (num2 < _feetLevel && _hasRaisedRightFoot)
			{
				_hasRaisedRightFoot = false;
				if (num5 < 0 && _groundTimer > 0.2f)
				{
					for (int j = 0; j < _physicsListeners.Length; j++)
					{
						_physicsListeners[j].OnFootstep(_rightFoot.transform.position);
					}
					if (Stepped != null)
					{
						Stepped();
					}
				}
			}
			_previousLeftFootDirection = num4;
			_previousRightFootDirection = num5;
			_previousLeftFootHeight = num;
			_previousRightFootHeight = num2;
		}

		private void updateWalk()
		{
			if (_directionChangeDelay > float.Epsilon)
			{
				_directionChangeDelay -= Time.deltaTime;
			}
			_currentMovement = _inputMovement;
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.IsHeavy && _currentMovement.Magnitude > 0.5f)
			{
				_currentMovement.Magnitude = 0.5f;
			}
			if (_cover.In)
			{
				_isMovingAwayFromCover = false;
			}
			else if (_isMovingAwayFromCover)
			{
				if (_currentMovement.IsMoving)
				{
					_currentMovement.Direction = (_currentMovement.Direction + _moveFromCoverDirection).normalized;
				}
				else
				{
					_currentMovement.Direction = _moveFromCoverDirection;
					_currentMovement.Magnitude = 0.5f;
				}
				if (Vector3.Dot(base.transform.position - _moveFromCoverPosition, _moveFromCoverDirection) > 0.5f)
				{
					_isMovingAwayFromCover = false;
				}
			}
			Vector3 target;
			if (_currentMovement.Direction.sqrMagnitude > 0.1f && _currentMovement.IsMoving)
			{
				float d = 1f;
				float num = Util.HorizontalAngle(_currentMovement.Direction);
				if (_cover.In)
				{
					if (_cover.HasLeftAdjacent && _cover.LeftAdjacent.IsFrontField(num, 360f - CoverSettings.ExitBack) && _cover.LeftAdjacent.IsLeft(num, 5f) && ((IsAiming && IsNearLeftCorner && _cover.Main.IsLeft(num) && Vector3.Dot(_cover.Main.Left, _coverOffset) > 0.1f) || Vector3.Distance(_cover.LeftAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon || Vector3.Distance(_cover.LeftAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= Vector3.Distance(_cover.Main.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position)))
					{
						if (_cover.LeftAdjacent.Angle > _cover.Main.Angle || Mathf.Abs(Mathf.DeltaAngle(num, _cover.Main.Angle)) + 0.1f > Mathf.Abs(Mathf.DeltaAngle(num, _cover.LeftAdjacent.Angle)))
						{
							bool isInLowCover = IsInLowCover;
							_cover.MoveToLeftAdjacent();
							_sideOffset = CoverOffsetState.None;
							_coverOffsetSideTarget = Vector3.zero;
							_coverOffsetSide = Vector3.zero;
							if (isInLowCover && IsInTallCover && _cover.Main.IsRight(_horizontalAngle, -30f))
							{
								_cover.StandRight();
							}
						}
					}
					else if (_cover.HasRightAdjacent && _cover.RightAdjacent.IsFrontField(num, 360f - CoverSettings.ExitBack) && _cover.RightAdjacent.IsRight(num, 5f) && ((IsNearRightCorner && _cover.Main.IsRight(num) && Vector3.Dot(_cover.Main.Right, _coverOffset) > 0.1f) || Vector3.Distance(_cover.RightAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon || Vector3.Distance(_cover.RightAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= Vector3.Distance(_cover.Main.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position)))
					{
						if (_cover.RightAdjacent.Angle < _cover.Main.Angle || Mathf.Abs(Mathf.DeltaAngle(num, _cover.Main.Angle)) + 0.1f > Mathf.Abs(Mathf.DeltaAngle(num, _cover.RightAdjacent.Angle)))
						{
							bool isInLowCover2 = IsInLowCover;
							_cover.MoveToRightAdjacent();
							_sideOffset = CoverOffsetState.None;
							_coverOffsetSideTarget = Vector3.zero;
							_coverOffsetSide = Vector3.zero;
							if (isInLowCover2 && IsInTallCover && _cover.Main.IsLeft(_horizontalAngle, -30f))
							{
								_cover.StandLeft();
							}
						}
					}
					else if (!_cover.Main.IsFrontField(num, 360f - CoverSettings.ExitBack))
					{
						moveAwayFromCover(_currentMovement.Direction);
					}
					else if (IsAiming && _cover.Main.IsLeft(num) && IsNearLeftCorner && !_cover.HasLeftAdjacent)
					{
						moveAwayFromCover(_currentMovement.Direction);
					}
					else if (IsAiming && _cover.Main.IsRight(num) && IsNearRightCorner && !_cover.HasRightAdjacent)
					{
						moveAwayFromCover(_currentMovement.Direction);
					}
				}
				if (_cover.In)
				{
					_currentMovement.Magnitude = 1f;
					if (_cover.Main.IsFrontField(num, 90f))
					{
						d = 0f;
					}
					else if (IsFreeToMove(_currentMovement.Direction) && !IsAimingGun && !_wantsToFaceInADirection && !_isRolling && (_directionChangeDelay <= float.Epsilon || IsInTallCover))
					{
						if (_cover.Main.IsLeft(num))
						{
							if (_cover.IsStandingRight)
							{
								_directionChangeDelay = CoverSettings.DirectionChangeDelay;
								_cover.StandLeft();
							}
						}
						else if (_cover.Main.IsRight(num) && _cover.IsStandingLeft)
						{
							_directionChangeDelay = CoverSettings.DirectionChangeDelay;
							_cover.StandRight();
						}
					}
					if (_directionChangeDelay > float.Epsilon && !IsAiming)
					{
						d = 0f;
					}
				}
				else if (!_isClimbing)
				{
					if (_currentMovement.Magnitude < 0.75f)
					{
						if (_lastWalkMode != WalkMode.walk)
						{
							_lastWalkMode = WalkMode.walk;
							for (int i = 0; i < _walkListeners.Length; i++)
							{
								_walkListeners[i].OnWalk();
							}
						}
					}
					else if (_currentMovement.Magnitude < 1.5f)
					{
						if (_lastWalkMode != WalkMode.run)
						{
							_lastWalkMode = WalkMode.run;
							for (int j = 0; j < _walkListeners.Length; j++)
							{
								_walkListeners[j].OnRun();
							}
						}
					}
					else if (_lastWalkMode != WalkMode.sprint)
					{
						_lastWalkMode = WalkMode.sprint;
						for (int k = 0; k < _walkListeners.Length; k++)
						{
							_walkListeners[k].OnSprint();
						}
					}
				}
				float num2 = Util.HorizontalAngle(_currentMovement.Direction);
				Vector3 eulerAngles = base.transform.eulerAngles;
				Vector3 a = Util.HorizontalVector(num2 - eulerAngles.y);
				target = a * _currentMovement.Magnitude * d;
				_wasMovingInCover = (_cover.In && target.magnitude > float.Epsilon);
			}
			else
			{
				_wasMovingInCover = false;
				target = Vector3.zero;
				if (_lastWalkMode != 0)
				{
					_lastWalkMode = WalkMode.none;
					for (int l = 0; l < _walkListeners.Length; l++)
					{
						_walkListeners[l].OnStop();
					}
				}
			}
			Util.Lerp(ref _localMovement, target, 8f);
			_movementInput = Mathf.Clamp(target.magnitude * 2f, 0f, 1f);
		}

		private void moveAwayFromCover(Vector3 direction)
		{
			_isMovingAwayFromCover = true;
			_moveFromCoverDirection = Vector3.Lerp(direction, -_cover.ForwardDirection, 0.5f);
			_moveFromCoverPosition = base.transform.position;
			_needToEnterCoverByWalkingToIt = true;
			_cover.Clear();
		}

		private Vector3 getClosestCoverPosition()
		{
			if (!IsInCover)
			{
				return base.transform.position;
			}
			bool flag = (!_currentMovement.IsMoving && _cover.Main.IsTall && CoverSettings.CanUseTallCorners) || (!_cover.Main.IsTall && CoverSettings.CanUseLowCorners);
			return _cover.Main.ClosestPointTo(base.transform.position, (!flag || !IsByAnOpenLeftCorner) ? (-1000f) : _capsule.radius, (!flag || !IsByAnOpenRightCorner) ? (-1000f) : _capsule.radius, _capsule.radius - _cover.Main.Depth);
		}

		private void stickToCover()
		{
			bool flag = false;
			if (_currentMovement.IsMoving && !IsAiming)
			{
				if (Vector3.Dot(_currentMovement.Direction, _cover.Main.Left) > 0f && IsStandingLeftInCover)
				{
					flag = true;
				}
				else if (Vector3.Dot(_currentMovement.Direction, _cover.Main.Right) > 0f && !IsStandingLeftInCover)
				{
					flag = true;
				}
			}
			Vector3 coverOffset = _coverOffset;
			if (flag)
			{
				_coverOffset = Vector3.zero;
				return;
			}
			Vector3 closestCoverPosition = getClosestCoverPosition();
			Vector3 a = closestCoverPosition + _coverOffsetBack + _coverOffsetSide;
			Vector3 vector = a - base.transform.position;
			if (vector.magnitude > 0.02f && !IsMovingToCoverOffset)
			{
				Vector3 vector2 = vector - Util.Lerp(vector, Vector3.zero, 10f);
				base.transform.position += vector2;
			}
			_coverOffset = base.transform.position - closestCoverPosition;
		}

		private float deltaAngleToTurnTo(float target)
		{
			Vector3 eulerAngles = base.transform.eulerAngles;
			float y = eulerAngles.y;
			float num = Mathf.DeltaAngle(y, target);
			if (_cover.In && Mathf.Abs(num) > 100f && !IsAiming)
			{
				float num2 = Mathf.DeltaAngle(y, _cover.ForwardAngle);
				if (num > 0f && num2 > 40f)
				{
					num = -360f + num;
				}
				else if (num < 0f && num2 < -40f)
				{
					num = 360f + num;
				}
			}
			return num;
		}

		private void updateBodyAngleDiff()
		{
			if (_isThrowing || _hasThrown)
			{
				_horizontalAngleDiff = deltaAngleToTurnTo(_throwBodyAngle);
			}
			else if (_isIntendingToJump || _isJumping)
			{
				_horizontalAngleDiff = deltaAngleToTurnTo(_jumpAngle);
			}
			else if (_isIntendingToRoll || _isRolling)
			{
				_horizontalAngleDiff = deltaAngleToTurnTo(_rollAngle);
			}
			else if (_cover.In)
			{
				if (_sideOffset == CoverOffsetState.Using || _backOffset == CoverOffsetState.Using)
				{
					_horizontalAngleDiff = deltaAngleToTurnTo(_horizontalAngle);
				}
				else if (isInAnimatedCover || _sideOffset == CoverOffsetState.Exiting || _backOffset == CoverOffsetState.Exiting)
				{
					_horizontalAngleDiff = deltaAngleToTurnTo(_cover.FaceAngle(_isCrouching));
				}
				else
				{
					_horizontalAngleDiff = deltaAngleToTurnTo(_horizontalAngle);
				}
				if (IsAiming && !_coverAim.LeaveAfterAiming)
				{
					updateCoverDirection(_horizontalAngle);
				}
				else
				{
					modifyBodyAngleDiffInCover();
				}
			}
			else
			{
				_horizontalAngleDiff = deltaAngleToTurnTo(_horizontalAngle);
			}
		}

		private void updateCoverDirection(float angle)
		{
			if (!_cover.In || _wantsToFaceInADirection)
			{
				return;
			}
			if (_cover.Main.IsRight(angle))
			{
				if (_cover.IsTall)
				{
					if (_cover.IsStandingLeft)
					{
						if (IsMoving)
						{
							if (_cover.Main.IsRight(angle, 50f))
							{
								_cover.StandRight();
							}
						}
						else if ((_cover.Main.IsRight(angle, 20f) && (!IsZooming || IsByAnOpenRightCorner)) || _cover.Main.IsRight(angle, 60f))
						{
							_cover.StandRight();
						}
					}
				}
				else if (_cover.HasRightAdjacent && Vector3.Distance(_cover.RightAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon)
				{
					if (Mathf.Abs(Mathf.DeltaAngle(angle, _cover.Main.Angle)) + 0.1f > Mathf.Abs(Mathf.DeltaAngle(angle, _cover.RightAdjacent.Angle)))
					{
						bool isInLowCover = IsInLowCover;
						_cover.StandRight();
						_cover.MoveToRightAdjacent();
						if (_wantsToAim && isInLowCover && IsInTallCover)
						{
							_backOffset = CoverOffsetState.Using;
						}
					}
					else
					{
						_cover.StandLeft();
					}
				}
				else
				{
					_cover.StandRight();
				}
			}
			else if (_cover.Main.IsLeft(angle))
			{
				if (_cover.IsTall)
				{
					if (_cover.IsStandingRight)
					{
						if (IsMoving)
						{
							if (_cover.Main.IsLeft(angle, 50f))
							{
								_cover.StandLeft();
							}
						}
						else if ((_cover.Main.IsLeft(angle, 20f) && (!IsZooming || IsByAnOpenLeftCorner)) || _cover.Main.IsLeft(angle, 60f))
						{
							_cover.StandLeft();
						}
					}
				}
				else if (_cover.HasLeftAdjacent && Vector3.Distance(_cover.LeftAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon)
				{
					if (Mathf.Abs(Mathf.DeltaAngle(angle, _cover.Main.Angle)) + 0.1f > Mathf.Abs(Mathf.DeltaAngle(angle, _cover.LeftAdjacent.Angle)))
					{
						bool isInLowCover2 = IsInLowCover;
						_cover.StandLeft();
						_cover.MoveToLeftAdjacent();
						if (_wantsToAim && isInLowCover2 && IsInTallCover)
						{
							_backOffset = CoverOffsetState.Using;
						}
					}
					else
					{
						_cover.StandRight();
					}
				}
				else if (_cover.Main.IsLeft(angle, 20f))
				{
					_cover.StandLeft();
				}
			}
			if (!IsInTallCover)
			{
				return;
			}
			if (_cover.IsStandingRight)
			{
				if (_horizontalAngleDiff > 90f && IsInTallCover)
				{
					Cover main = _cover.Main;
					Vector3 eulerAngles = base.transform.eulerAngles;
					if (!main.IsFront(eulerAngles.y))
					{
						_horizontalAngleDiff -= 360f;
					}
				}
			}
			else if (_horizontalAngleDiff < -90f && IsInTallCover)
			{
				Cover main2 = _cover.Main;
				Vector3 eulerAngles2 = base.transform.eulerAngles;
				if (!main2.IsFront(eulerAngles2.y))
				{
					_horizontalAngleDiff = 360f + _horizontalAngleDiff;
				}
			}
		}

		private void modifyBodyAngleDiffInCover()
		{
			if (!_cover.In)
			{
				return;
			}
			if (_cover.IsStandingRight)
			{
				if (_horizontalAngleDiff < -181f && _cover.HasLeftAdjacent && Vector3.Distance(_cover.LeftAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon)
				{
					_horizontalAngleDiff = 360f + _horizontalAngleDiff;
				}
				else if (_horizontalAngleDiff < -90f && IsInTallCover)
				{
					Cover main = _cover.Main;
					Vector3 eulerAngles = base.transform.eulerAngles;
					if (main.IsFront(eulerAngles.y))
					{
						_horizontalAngleDiff = 360f + _horizontalAngleDiff;
					}
				}
			}
			else if (_horizontalAngleDiff > 179f && _cover.HasRightAdjacent && Vector3.Distance(_cover.RightAdjacent.ClosestPointTo(base.transform.position, 0f, 0f), base.transform.position) <= _capsule.radius + float.Epsilon)
			{
				_horizontalAngleDiff -= 360f;
			}
			else if (_horizontalAngleDiff > 90f && IsInTallCover)
			{
				Cover main2 = _cover.Main;
				Vector3 eulerAngles2 = base.transform.eulerAngles;
				if (main2.IsFront(eulerAngles2.y))
				{
					_horizontalAngleDiff -= 360f;
				}
			}
		}

		private void updateVertical()
		{
			if (_jumpTimer < 999f)
			{
				_jumpTimer += Time.deltaTime;
			}
			if (_ignoreFallTimer > 0f)
			{
				_ignoreFallTimer -= Time.deltaTime;
			}
			if (_ignoreJumpTimer > 0f)
			{
				_ignoreJumpTimer -= Time.deltaTime;
			}
			updateGround();
			WeaponDescription equippedWeapon = EquippedWeapon;
			if (equippedWeapon.IsHeavy)
			{
				_isIntendingToJump = false;
			}
			if (_isGrounded)
			{
				if (_nextJumpTimer > -1.401298E-45f)
				{
					_nextJumpTimer -= Time.deltaTime;
				}
				if (!_cover.In && !_isClimbing && !_isJumping && _nextJumpTimer < float.Epsilon && _wantsToJump)
				{
					_isIntendingToJump = true;
				}
			}
			else
			{
				Vector3 velocity = _body.velocity;
				if (velocity.y < -5f)
				{
					_isJumping = false;
				}
			}
			if (_isGrounded && _ignoreJumpTimer <= float.Epsilon)
			{
				if (_isIntendingToJump)
				{
					Vector3 eulerAngles = base.transform.eulerAngles;
					if (Mathf.Abs(Mathf.DeltaAngle(eulerAngles.y, _jumpAngle)) < 10f)
					{
						if (!_isJumping)
						{
							_animator.SetTrigger("Jump");
							_isJumping = true;
							_jumpTimer = 0f;
							for (int i = 0; i < _physicsListeners.Length; i++)
							{
								_physicsListeners[i].OnJump();
							}
							if (Jumped != null)
							{
								Jumped();
							}
						}
						_animator.SetFloat("JumpSpeed", _jumpForwardMultiplier);
						Vector3 velocity2 = _jumpForwardMultiplier * Util.HorizontalVector(_jumpAngle) * JumpSettings.Speed;
						velocity2.y = JumpSettings.Strength;
						_body.velocity = velocity2;
						goto IL_0260;
					}
				}
				if (_isJumping)
				{
					_isJumping = false;
				}
			}
			else
			{
				_isIntendingToJump = false;
			}
			goto IL_0260;
			IL_0260:
			if (_ignoreFallTimer <= float.Epsilon)
			{
				if (!_isFalling)
				{
					if (!_isJumping)
					{
						Vector3 velocity3 = _body.velocity;
						if (velocity3.y < -1f)
						{
							goto IL_02cd;
						}
					}
					if (_isJumping)
					{
						Vector3 velocity4 = _body.velocity;
						if (velocity4.y < -4f)
						{
							goto IL_02cd;
						}
					}
				}
				else if (_isGrounded)
				{
					_isFalling = false;
				}
			}
			else
			{
				_isFalling = false;
			}
			goto IL_0318;
			IL_02cd:
			if (!findGround(FallThreshold))
			{
				_animator.SetTrigger("Fall");
				_isFalling = true;
			}
			goto IL_0318;
            IL_0318:
            Vector3 position;

            if (_isFalling && findEdge(out  position, 0.1f))
			{
				Vector3 a = base.transform.position - position;
				a.y = 0f;
				float magnitude = a.magnitude;
				if (magnitude > 0.01f)
				{
					a /= magnitude;
					base.transform.position += a * Mathf.Clamp(Time.deltaTime * 3f, 0f, magnitude);
				}
			}
		}

		private void updateGround()
		{
			if (_ignoreFallTimer < float.Epsilon)
			{
				findGroundAndSlope(GroundThreshold);
			}
			else
			{
				_isGrounded = true;
			}
			if (_isGrounded && !_wasGrounded && IsAlive && _nogroundTimer >= 0.3f)
			{
				for (int i = 0; i < _physicsListeners.Length; i++)
				{
					_physicsListeners[i].OnLand();
				}
				_nextJumpTimer = 0.2f;
				if (Landed != null)
				{
					Landed();
				}
			}
			_wasGrounded = _isGrounded;
		}

		private void getWeaponProperties(out int body, out int tool, out float variant)
		{
			WeaponDescription weaponDescription = (_weaponEquipState != 0 || _equippedWeapon.IsTheSame(ref Weapon)) ? EquippedWeapon : (IsEquipped ? Weapon : default(WeaponDescription));
			bool hasMelee = weaponDescription.HasMelee;
			if (weaponDescription.Gun != null && (IsAiming || !hasMelee))
			{
				switch (weaponDescription.Gun.Type)
				{
				case WeaponType.Pistol:
				{
					WeaponDescription equippedWeapon2 = EquippedWeapon;
					if (equippedWeapon2.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 1;
						variant = 0f;
					}
					break;
				}
				case WeaponType.Rifle:
				{
					WeaponDescription equippedWeapon4 = EquippedWeapon;
					if (equippedWeapon4.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = (_wantsToScope ? 1 : 0);
					}
					break;
				}
				case WeaponType.Shotgun:
				{
					WeaponDescription equippedWeapon3 = EquippedWeapon;
					if (equippedWeapon3.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = 2f;
					}
					break;
				}
				case WeaponType.Sniper:
				{
					WeaponDescription equippedWeapon = EquippedWeapon;
					if (equippedWeapon.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = (_wantsToScope ? 1 : 0);
					}
					break;
				}
				default:
					body = 0;
					variant = 0f;
					break;
				}
			}
			else if (hasMelee)
			{
				switch ((!(weaponDescription.RightMelee != null)) ? weaponDescription.LeftMelee.Type : weaponDescription.RightMelee.Type)
				{
				case WeaponType.Pistol:
				{
					WeaponDescription equippedWeapon7 = EquippedWeapon;
					if (equippedWeapon7.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 1;
						variant = 0f;
					}
					break;
				}
				case WeaponType.Rifle:
				{
					WeaponDescription equippedWeapon6 = EquippedWeapon;
					if (equippedWeapon6.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = 0f;
					}
					break;
				}
				case WeaponType.Shotgun:
				{
					WeaponDescription equippedWeapon8 = EquippedWeapon;
					if (equippedWeapon8.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = 2f;
					}
					break;
				}
				case WeaponType.Sniper:
				{
					WeaponDescription equippedWeapon5 = EquippedWeapon;
					if (equippedWeapon5.Shield != null)
					{
						body = 3;
						variant = 1f;
					}
					else
					{
						body = 2;
						variant = 0f;
					}
					break;
				}
				case WeaponType.Fist:
					body = 4;
					variant = 0f;
					break;
				case WeaponType.Machete:
					body = 5;
					variant = 0f;
					break;
				default:
					body = 0;
					variant = 0f;
					break;
				}
			}
			else
			{
				body = 0;
				variant = 0f;
			}
			tool = (int)weaponDescription.ToolType;
			if (HasGrenadeInHand)
			{
				body = 0;
				tool = 0;
			}
		}

		private void updateAnimator()
		{
			if (IsAlive)
			{
				if (_immediateIdle)
				{
					if (!_immediateAim)
					{
						_animator.SetTrigger("ImmediateIdle");
					}
					_animator.SetFloat("CrouchToStand", (!_isCrouching) ? 1 : 0);
					_animator.SetFloat("MovementSpeed", 0f);
					_animator.SetFloat("Rotation", 0f);
					base.transform.Rotate(0f, _horizontalAngleDiff, 0f);
					Vector3 eulerAngles = base.transform.eulerAngles;
					_currentAnimatedAngle = eulerAngles.y;
					_currentStep = 0f;
					_immediateIdle = false;
				}
				if (_immediateAim)
				{
					_animator.SetTrigger("ImmediateAim");
					_immediateAim = false;
				}
				_animator.SetFloat("Speed", Speed);
				_animator.SetBool("IsDead", value: false);
				if (_coverOffset.magnitude > float.Epsilon)
				{
					_animator.SetFloat("SmoothRotation", 0f, 0.05f, Time.deltaTime);
					_animator.SetFloat("Rotation", 0f, 0.05f, Time.deltaTime);
				}
				else if (_wantsToRotateSmoothly)
				{
					if (_isGrounded && _movementInput < 0.5f && !_isClimbing && !_isFalling)
					{
						_animator.SetFloat("SmoothRotation", _currentStep, 0.05f, Time.deltaTime);
					}
					else
					{
						_animator.SetFloat("SmoothRotation", 0f, 0.05f, Time.deltaTime);
					}
					_animator.SetFloat("Rotation", 0f, 0.05f, Time.deltaTime);
				}
				else
				{
					_animator.SetFloat("SmoothRotation", 0f, 0.05f, Time.deltaTime);
					_animator.SetFloat("Rotation", _currentStep, 0.05f, Time.deltaTime);
				}
				Vector3 a = _localMovement;
				if (_currentMovement.Magnitude > float.Epsilon)
				{
					a /= _currentMovement.Magnitude;
				}
				if (_ik.HasSwitchedHands)
				{
					a.x *= -1f;
				}
				_animator.SetBool("IsMirrored", _ik.HasSwitchedHands);
				float num = _currentMovement.Magnitude;
				float num2 = 1f;
				if (_hasCrouchCover && !IsAiming && (!_cover.In || !_cover.IsTall))
				{
					num2 = Mathf.Clamp01(Vector3.Distance(base.transform.position, _crouchCoverPosition) / (CoverSettings.MaxCrouchDistance - CoverSettings.MinCrouchDistance) - CoverSettings.MinCrouchDistance);
				}
				if (_useSprintingAnimation)
				{
					num = 2f;
				}
				else if (_isCrouching || _cover.In)
				{
					num = 0.5f;
				}
				else if (num >= 1f && !_useSprintingAnimation)
				{
					num = 1f;
				}
				_animator.SetFloat("ArmLift", _wantsToLiftArms ? 1 : 0, 0.14f, Time.deltaTime);
				if (_movementInput > 0.5f)
				{
					_animator.SetFloat("MovementSpeed", num * _movementInput, AccelerationDamp * 0.1f, Time.deltaTime);
					_animator.SetFloat("MovementX", a.x, AccelerationDamp * 0.02f, Time.deltaTime);
					_animator.SetFloat("MovementZ", a.z, AccelerationDamp * 0.02f, Time.deltaTime);
				}
				else
				{
					_animator.SetFloat("MovementSpeed", 0f, DeccelerationDamp * 0.1f, Time.deltaTime);
					_animator.SetFloat("MovementX", a.x, DeccelerationDamp * 0.02f, Time.deltaTime);
					_animator.SetFloat("MovementZ", a.z, DeccelerationDamp * 0.02f, Time.deltaTime);
				}
				_animator.SetBool("IsFalling", _isFalling && !_isJumping);
				_animator.SetBool("IsGrounded", _isGrounded);
				_animator.SetBool("IsWeaponReady", IsWeaponReady || _isRolling || (_isClimbing && _normalizedClimbTime > 0.7f));
				_animator.SetInteger("GunType", gunType);
				_animator.SetInteger("MeleeType", meleeType);
				if (gunType == 0)
				{
					if (_equippedWeapon.IsNull)
					{
						_animator.SetBool("IsTool", IsEquipped && Weapon.Tool != null);
					}
					else
					{
						_animator.SetBool("IsTool", _equippedWeapon.Tool != null);
					}
				}
				else
				{
					_animator.SetBool("IsTool", value: false);
				}
				_animator.SetBool("IsBlocking", IsBlocking);
                int body, tool; float variant;

                getWeaponProperties(out  body, out  tool, out  variant);
				_animator.SetFloat("BodyValue", body, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue0", (body == 0) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue1", (body == 1) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue2", (body == 2) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue3", (body == 3) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue4", (body == 4) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("BodyValue5", (body == 5) ? 1 : 0, 0.1f, Time.deltaTime);
				_animator.SetFloat("GunVariant", variant, 0.1f, Time.deltaTime);
				_animator.SetFloat("Tool", tool, 0.1f, Time.deltaTime);
				if (IsAiming || (_cover.In && _wantsToLiftArms))
				{
					_animator.SetFloat("IdleToAim", 1f, 0.05f, Time.deltaTime);
				}
				else
				{
					_animator.SetFloat("IdleToAim", 0f, 0.05f, Time.deltaTime);
				}
				BaseGun gun = EquippedWeapon.Gun;
				_dontChangeArmAimingJustYet = false;
				if (gun != null)
				{
					if (_cover.In && (_sideOffset == CoverOffsetState.Using || _backOffset == CoverOffsetState.Using))
					{
						_ik.ImmediateArmAim();
						_dontChangeArmAimingJustYet = true;
						_animator.SetBool("IsUsingWeapon", value: true);
					}
					if (!_dontChangeArmAimingJustYet)
					{
						_animator.SetBool("IsUsingWeapon", !IsGoingToSprint && !IsSprinting && !HasGrenadeInHand && !IsMovingToCoverOffsetAndCantAim && (IsAiming || (_wantsToAim && IsReloading) || (_isRolling && _wantsToAim) || (IsChangingWeapon && _wantsToAim)));
					}
				}
				else
				{
					_animator.SetBool("IsAlternateUse", _isUsingWeaponAlternate);
					_animator.SetBool("IsUsingWeapon", _isUsingWeapon);
				}
				bool isInAnimatedCover = this.isInAnimatedCover;
				if (_cover.In && isInAnimatedCover && !IsMovingToCoverOffset && (_sideOffset == CoverOffsetState.Using || _backOffset == CoverOffsetState.Using))
				{
					setCoverOffsets( false, false, Vector3.zero, Vector3.zero);
				}
				_animator.SetBool("IsInCover", isInAnimatedCover);
				_animator.SetBool("IsInLowCover", isInAnimatedCover && (!_cover.IsTall || _isCrouching));
				_animator.SetBool("IsInTallLeftCover", isInAnimatedCover && _cover.IsTall && !_isCrouching && _cover.IsStandingLeft);
				_animator.SetBool("IsInTallCoverBack", isInAnimatedCover && _cover.IsTall && _cover.Main.IsFrontField(_throwAngle, 180f));
				if (_cover.In)
				{
					_animator.SetFloat("CoverDirection", ((!_ik.HasSwitchedHands) ? 1 : (-1)) * _cover.Direction, 0.2f, Time.deltaTime);
					_animator.SetFloat("CoverHeight", (!_cover.IsTall || _isCrouching) ? 0f : 1f, 0.1f, Time.deltaTime);
					float num3 = (!_isThrowing) ? _horizontalAngle : _throwAngle;
					num3 = (_cover.Main.IsFrontField(num3, 180f) ? Mathf.DeltaAngle(_cover.ForwardAngle, num3) : ((!_cover.IsStandingRight) ? (-90f) : 90f));
					_animator.SetFloat("ThrowAngle", num3);
				}
				_animator.SetFloat("ClimbHeight", _climbHeight);
				_animator.SetBool("IsVault", _isClimbingAVault);
				if (IsAiming && IsInLowCover)
				{
					_animator.SetFloat("CrouchToStand", ((_cover.IsTall && !_isCrouching) || _isAimingThroughCoverPlane) ? num2 : 0f, 0.1f, Time.deltaTime);
				}
				else
				{
					_animator.SetFloat("CrouchToStand", (!_isCrouching) ? num2 : 0f, 0.1f, Time.deltaTime);
				}
				_animator.SetBool("HasGrenade", _isGrenadeTakenOut);
			}
			else
			{
				_animator.SetBool("IsDead", value: true);
				_animator.SetBool("IsUsingWeapon", value: false);
			}
		}

		private void immediateBodyValue(int value)
		{
			_animator.SetFloat("BodyValue", value);
			_animator.SetFloat("BodyValue0", (value == 0) ? 1 : 0);
			_animator.SetFloat("BodyValue1", (value == 1) ? 1 : 0);
			_animator.SetFloat("BodyValue2", (value == 2) ? 1 : 0);
			_animator.SetFloat("BodyValue3", (value == 3) ? 1 : 0);
			_animator.SetFloat("BodyValue4", (value == 4) ? 1 : 0);
			_animator.SetFloat("BodyValue5", (value == 5) ? 1 : 0);
		}

		private void instantCoverAnimatorUpdate()
		{
			_animator.SetFloat("CoverDirection", _cover.Direction);
			_animator.SetFloat("CoverHeight", (!_cover.IsTall || _isCrouching) ? 0f : 1f);
		}

		private void updateIK()
		{
			if (IsAlive)
			{
				BaseGun gun = EquippedWeapon.Gun;
				if (IK.Enabled)
				{
					IKConfig config = default(IKConfig);
					config.Delay = IK.Delay;
					config.MinIterations = IK.MinIterations;
					config.MaxIterations = IK.MaxIterations;
					config.LeftHand = ((!(IK.LeftHandOverride != null)) ? _ik.GetBone(HumanBodyBones.LeftIndexProximal) : IK.LeftHandOverride);
					config.RightHand = ((!(IK.RightHandOverride != null)) ? _ik.GetBone(HumanBodyBones.RightHand) : IK.RightHandOverride);
					config.Sight = ((!(IK.SightOverride != null)) ? _ik.Sight : IK.SightOverride);
					config.HitBone = ((!(IK.HitBoneOverride != null)) ? _ik.GetBone(HumanBodyBones.Spine) : IK.HitBoneOverride);
					config.Gun = gun;
					config.TurnImmediately = _wouldTurnImmediately;
					config.BodyTarget = _bodyTarget;
					config.AimTarget = _aimTarget;
					config.IsPrecise = _isAimingPrecisely;
					_ik.Update(config);
				}
				else
				{
					_ik.Skip();
				}
				if (gun != null && _needsTarget)
				{
					_target = gun.FindCurrentAimedHealthTarget();
				}
			}
		}

		private bool findGround(float threshold)
		{
			float num = 0.2f;
			int num2 = Physics.RaycastNonAlloc(base.transform.position + Vector3.up * num, Vector3.down, Util.Hits, threshold + num, Layers.Geometry);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Util.Hits[i];
				if (!raycastHit.collider.isTrigger && raycastHit.collider.gameObject != base.gameObject)
				{
					return true;
				}
			}
			return false;
		}

		private void findGroundAndSlope(float threshold)
		{
			_isOnSlope = false;
			_isGrounded = false;
			float num = 0.4f;
			float num2 = 0f;
			Vector3 vector = base.transform.position + Vector3.up * num;
			int num3 = Physics.RaycastNonAlloc(vector, Vector3.down, Util.Hits, threshold + num, Layers.Geometry);
			for (int i = 0; i < num3; i++)
			{
				RaycastHit raycastHit = Util.Hits[i];
				if (raycastHit.collider.isTrigger || !(raycastHit.collider.gameObject != base.gameObject))
				{
					continue;
				}
				float num4 = Vector3.Dot(Vector3.up, raycastHit.normal);
				float num5 = Vector3.Distance(raycastHit.point, vector);
				if (!_isGrounded || num5 < num2)
				{
					_slope = Mathf.Acos(num4) * 57.29578f;
					if (num4 > 0.99f)
					{
						_slope = 0f;
					}
					_isOnSlope = (_slope > 20f);
					_groundNormal = raycastHit.normal;
					_isGrounded = true;
					num2 = num5;
				}
				break;
			}
			if (!_isGrounded || _wantsToJump || _isFalling || !(_jumpTimer > 0.1f))
			{
				return;
			}
			float num6 = num2 - num;
			if (_isOnSlope)
			{
				num6 -= (_slope - 20f) / 200f;
			}
			if (num6 > float.Epsilon)
			{
				float num7 = Time.deltaTime * 0.5f;
				if (num7 > num6)
				{
					num7 = num6;
				}
				base.transform.position -= Vector3.up * num7;
			}
		}

		private float getGoundHeight()
		{
			int num = Physics.RaycastNonAlloc(base.transform.position + Vector3.up * 0.1f, Vector3.down, Util.Hits, Layers.Geometry);
			for (int i = 0; i < num; i++)
			{
				RaycastHit raycastHit = Util.Hits[i];
				if (raycastHit.collider.gameObject != base.gameObject)
				{
					Vector3 point = raycastHit.point;
					return point.y;
				}
			}
			return 0f;
		}

		private bool findEdge(out Vector3 position, float threshold)
		{
			Vector3 position2 = base.transform.TransformPoint(_capsule.center - new Vector3(0f, _capsule.height * 0.5f + _capsule.radius, 0f));
			int num = Physics.OverlapSphereNonAlloc(position2, _capsule.radius + threshold, Util.Colliders, Layers.Geometry);
			for (int i = 0; i < num; i++)
			{
				if (Util.Colliders[i].gameObject != base.gameObject)
				{
					position = Util.Colliders[i].ClosestPointOnBounds(position2);
					return true;
				}
			}
			position = Vector3.zero;
			return false;
		}

		private CoverClimb getClimb(Cover cover)
		{
			if (cover == null)
			{
				return CoverClimb.No;
			}
			return cover.GetClimbAt(base.transform.position, _capsule.radius, 3f, 1.05f, 1.1f);
		}
	}
}
