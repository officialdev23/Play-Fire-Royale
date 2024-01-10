// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIAim
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class AIAim : AIBase
	{
		private enum BodyMode
		{
			none,
			actor,
			position,
			direction,
			walk,
			scan
		}

		private enum AimMode
		{
			none,
			actor,
			position,
			direction,
			walk,
			scan
		}

		[Tooltip("Speed at which the AI turns.")]
		public float Speed = 6f;

		[Tooltip("Speed at which the AI turns when in slow mode.")]
		public float SlowSpeed = 2f;

		[Tooltip("Duration of sweeping in a single direction. Afterwards a new direction is picked.")]
		public float MinScanDuration = 3.5f;

		[Tooltip("Duration of sweeping in a single direction. Afterwards a new direction is picked.")]
		public float MaxScanDuration = 5f;

		[Tooltip("Minimal unobstructed distance in a direction for it to be scanned.")]
		public float MinScanDistance = 6f;

		[Tooltip("Duration of a single sweep.")]
		public float MinSweepDuration = 4f;

		[Tooltip("Duration of a single sweep.")]
		public float MaxSweepDuration = 6f;

		[Tooltip("How wide is a single sweep in degrees.")]
		public float SweepFOV = 30f;

		[Tooltip("Maximum degrees of error the AI can make when firing.")]
		public float AccuracyError = 2f;

		[Tooltip("Position of the enemy the AI is aiming at.")]
		public AITargetSettings Target = new AITargetSettings(0.5f, 0.8f);

		[Tooltip("Should a debug rays be displayed.")]
		public bool DebugAim;

		private Actor _actor;

		private CharacterMotor _motor;

		private Vector3 _body;

		private Vector3 _aim;

		private ActorTarget _target;

		private bool _hasBodyAim;

		private bool _hasAim;

		private bool _isAimingSlowly;

		private bool _isTurningSlowly;

		private Vector3 _currentAim;

		private BodyMode _bodyMode;

		private AimMode _aimMode;

		private Vector3 _walkDirection;

		private bool _hasWalkDirection;

		private float _aimDelay;

		private float _currentTargetHeight;

		private float _targetHeight;

		private float _targetHeightTime;

		private Vector3 _lastWalkPosition;

		private float _scanLeft;

		private float _scanAngle;

		private float _sweepDelta;

		private int _sweepDirection;

		private float _sweepDuration;

		private float _sweepFOV;

		private float[] _snapWork = new float[_snaps.Length];

		private static float[] _snaps = new float[4]
		{
			0f,
			-90f,
			90f,
			180f
		};

		public void OnWalkDirection(Vector3 value)
		{
			_walkDirection = value;
			_hasWalkDirection = true;
			if (_aimMode != AimMode.scan)
			{
				return;
			}
			float num = Vector3.Distance(base.transform.position, _lastWalkPosition);
			if (num > 1f)
			{
				_lastWalkPosition = base.transform.position;
				if (Mathf.Abs(Mathf.DeltaAngle(Util.HorizontalAngle(value), _scanAngle)) > 30f)
				{
					scanAtWalkDirection();
				}
			}
		}

		public void ToScan()
		{
			if (_bodyMode != BodyMode.scan)
			{
				findNewScanDirection();
			}
			_bodyMode = BodyMode.scan;
			_aimMode = AimMode.scan;
			_hasBodyAim = true;
			_hasAim = true;
		}

		public void ToFaceWalkDirection()
		{
			_bodyMode = BodyMode.walk;
			_aimMode = AimMode.walk;
			_hasBodyAim = true;
			_hasAim = true;
		}

		public void ToTurnToWalkDirection()
		{
			_bodyMode = BodyMode.walk;
			_hasBodyAim = true;
		}

		public void ToTurnAt(Vector3 position)
		{
			_body = position;
			_bodyMode = BodyMode.position;
			_hasBodyAim = true;
			_isTurningSlowly = false;
			if (!_hasAim)
			{
				ToAimAt(position);
			}
		}

		public void ToTurnTo(Vector3 direction)
		{
			_body = direction;
			_bodyMode = BodyMode.direction;
			_hasBodyAim = true;
			_isTurningSlowly = false;
			if (!_hasAim)
			{
				ToAimTo(direction);
			}
		}

		public void ToAimAt(Vector3 position)
		{
			aimAt(position);
			_isAimingSlowly = false;
			_aimDelay = 0f;
		}

		public void ToAimTo(Vector3 direction)
		{
			aimTo(direction);
			_isAimingSlowly = false;
			_aimDelay = 0f;
		}

		public void ToTarget(ActorTarget target)
		{
			_target = target;
			_bodyMode = BodyMode.actor;
			_aimMode = AimMode.actor;
			_hasBodyAim = true;
			_hasAim = true;
			_isTurningSlowly = false;
		}

		public void ToSlowlyTurnAt(Vector3 position)
		{
			ToTurnAt(position);
			_isTurningSlowly = true;
		}

		public void ToSlowlyTurnTo(Vector3 direction)
		{
			ToTurnTo(direction);
			_isTurningSlowly = true;
		}

		public void ToSlowlyAimAt(Vector3 position)
		{
			aimAt(position);
			_isAimingSlowly = true;
			_aimDelay = 0.5f;
		}

		public void ToSlowlyAimTo(Vector3 direction)
		{
			aimTo(direction);
			_isAimingSlowly = true;
			_aimDelay = 0.5f;
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
			_walkDirection = base.transform.position;
			_currentAim = base.transform.forward;
			_targetHeight = Random.Range(Target.Min, Target.Max);
			_currentTargetHeight = _targetHeight;
			_targetHeightTime = Time.timeSinceLevelLoad;
		}

		private void Update()
		{
			if (!_actor.IsAlive)
			{
				return;
			}
			if (Time.timeSinceLevelLoad - _targetHeightTime > 3f)
			{
				_targetHeight = Random.Range(Target.Min, Target.Max);
				_targetHeightTime = Time.timeSinceLevelLoad;
			}
			Util.Lerp(ref _currentTargetHeight, _targetHeight, 1f);
			if (!_hasBodyAim)
			{
				ToTurnTo(base.transform.forward);
			}
			switch (_bodyMode)
			{
			case BodyMode.actor:
				aimBodyTo(_target.Position + _target.RelativeTopPosition * _currentTargetHeight, (!_isTurningSlowly) ? Speed : SlowSpeed);
				break;
			case BodyMode.position:
				aimBodyTo(_body, (!_isTurningSlowly) ? Speed : SlowSpeed);
				break;
			case BodyMode.direction:
				aimBodyTo(base.transform.position + _body * 8f, (!_isTurningSlowly) ? Speed : SlowSpeed);
				break;
			case BodyMode.walk:
				aimBodyTo(base.transform.position + _walkDirection * 8f, ((!_isTurningSlowly) ? Speed : SlowSpeed) * 2f);
				break;
			case BodyMode.scan:
				_scanLeft -= Time.deltaTime;
				if (_scanLeft < float.Epsilon)
				{
					findNewScanDirection();
				}
				aimBodyTo(base.transform.position + Util.HorizontalVector(_scanAngle) * 100f, Speed);
				if (DebugAim)
				{
					UnityEngine.Debug.DrawLine(base.transform.position, _motor.BodyLookTarget, Color.black);
				}
				break;
			}
			switch (_aimMode)
			{
			case AimMode.actor:
				turn(ref _currentAim, _target.Position + _target.RelativeTopPosition * _currentTargetHeight, _isAimingSlowly);
				break;
			case AimMode.position:
				turn(ref _currentAim, _aim, _isAimingSlowly);
				break;
			case AimMode.direction:
				turn(ref _currentAim, base.transform.position + _aim * 8f, _isAimingSlowly);
				break;
			case AimMode.walk:
				turn(ref _currentAim, base.transform.position + _walkDirection * 8f, _isAimingSlowly);
				break;
			case AimMode.scan:
			{
				float num = _scanAngle + (_sweepDelta - 0.5f) * _sweepFOV;
				Vector3 vector = base.transform.position + Util.HorizontalVector(num) * 100f;
				if (Mathf.Abs(Mathf.DeltaAngle(Util.HorizontalAngle(_currentAim - base.transform.position), num)) > 20f)
				{
					turn(ref _currentAim, vector, isSlow: false);
				}
				else
				{
					_currentAim = vector;
				}
				_sweepDelta += (float)_sweepDirection * Time.deltaTime / _sweepDuration;
				if (_sweepDelta >= 1f && _sweepDirection > 0)
				{
					_sweepDirection = -1;
				}
				else if (_sweepDelta <= -1f && _sweepDirection < 0)
				{
					_sweepDirection = 1;
				}
				_motor.InputAim();
				break;
			}
			}
			aimMotorAt(_currentAim);
			if (_aimDelay >= 0f)
			{
				_aimDelay -= Time.deltaTime;
			}
		}

		private void aimBodyTo(Vector3 position, float speed)
		{
			if (!_hasWalkDirection)
			{
				_motor.SetBodyTarget(position, speed);
				return;
			}
			float num = Util.HorizontalAngle(_walkDirection);
			float num2 = Util.HorizontalAngle(position - base.transform.position);
			for (int i = 0; i < _snaps.Length; i++)
			{
				_snapWork[i] = Mathf.Abs(Mathf.DeltaAngle(num + _snaps[i], num2));
			}
			for (int j = 0; j < _snaps.Length; j++)
			{
				bool flag = true;
				for (int k = j + 1; k < _snaps.Length; k++)
				{
					if (_snapWork[k] < _snapWork[j])
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					num2 = num + _snaps[j];
					break;
				}
			}
			_motor.SetBodyTarget(base.transform.position + Util.HorizontalVector(num2) * 10f, speed);
		}

		private void scanAtWalkDirection()
		{
			_scanAngle = Util.HorizontalAngle(_walkDirection);
			_scanLeft = Random.Range(MinScanDuration, MaxScanDuration);
			_sweepDuration = Random.Range(MinSweepDuration, MaxSweepDuration);
			_sweepDelta = 0f;
			_sweepFOV = 0f;
		}

		private void findNewScanDirection()
		{
			_scanAngle = Util.RandomUnobstructedAngle(base.gameObject, base.transform.position + Vector3.up * 1.5f, _scanAngle, SweepFOV, MinScanDistance);
			_scanLeft = Random.Range(MinScanDuration, MaxScanDuration);
			float num = Mathf.DeltaAngle(_scanAngle, Util.HorizontalAngle(_currentAim));
			if (num < 0f)
			{
				_sweepDirection = 1;
			}
			else
			{
				_sweepDirection = -1;
			}
			_sweepDuration = Random.Range(MinSweepDuration, MaxSweepDuration);
			_sweepDelta = Mathf.Clamp01((num - 0.5f) / SweepFOV);
			_sweepFOV = SweepFOV;
		}

		public void aimAt(Vector3 position)
		{
			_aim = position;
			_aimMode = AimMode.position;
			_hasAim = true;
			if (!_hasBodyAim)
			{
				ToTurnAt(position);
			}
		}

		public void aimTo(Vector3 direction)
		{
			_aim = direction;
			_aimMode = AimMode.direction;
			_hasAim = true;
			if (!_hasBodyAim)
			{
				ToTurnTo(direction);
			}
		}

		private void turn(ref Vector3 current, Vector3 target, bool isSlow, float multiplier = 1f)
		{
			if (_motor.IsInCover && !_motor.IsAimingGun && !_motor.IsAimingTool)
			{
				current = target;
			}
			else if (_aimDelay <= float.Epsilon)
			{
				float num = ((!isSlow) ? Speed : SlowSpeed) * multiplier;
				Vector3 vector = current - base.transform.position;
				Vector3 vector2 = target - base.transform.position;
				float current2 = Util.HorizontalAngle(vector);
				float target2 = Util.HorizontalAngle(vector2);
				float current3 = Util.VerticalAngle(vector);
				float target3 = Util.VerticalAngle(vector2);
				float num2 = num * Time.deltaTime * 60f;
				float num3 = Mathf.DeltaAngle(current2, target2);
				float num4 = Mathf.DeltaAngle(current3, target3);
				float num5 = num3 + num4;
				Vector3 b;
				if (num5 > float.Epsilon)
				{
					float num6 = num2 / num5;
					if (num6 > 1f)
					{
						num6 = 1f;
					}
					b = Vector3.Slerp(vector, vector2, num);
				}
				else
				{
					b = vector2;
				}
				current = base.transform.position + b;
			}
			if (DebugAim)
			{
				UnityEngine.Debug.DrawLine(base.transform.position, current, Color.magenta);
				UnityEngine.Debug.DrawLine(base.transform.position, target, Color.green);
			}
		}

		private void aimMotorAt(Vector3 position)
		{
			if (_motor.IsInTallCover)
			{
				Vector3 rhs = position - base.transform.position;
				if (Vector3.Dot(_motor.Cover.Forward, rhs) > 0f)
				{
					bool isNearLeftCorner = _motor.IsNearLeftCorner;
					bool isNearRightCorner = _motor.IsNearRightCorner;
					if (isNearLeftCorner && isNearRightCorner)
					{
						if (Vector3.Dot(_motor.Cover.Left, rhs) > 0f)
						{
							position = base.transform.position + (_motor.Cover.Forward + _motor.Cover.Left).normalized * 8f;
							_motor.InputStandLeft();
						}
						else
						{
							position = base.transform.position + (_motor.Cover.Forward + _motor.Cover.Right).normalized * 8f;
							_motor.InputStandRight();
						}
					}
					else if (isNearLeftCorner)
					{
						position = base.transform.position + (_motor.Cover.Forward + _motor.Cover.Left).normalized * 8f;
						_motor.InputStandLeft();
					}
					else
					{
						position = base.transform.position + (_motor.Cover.Forward + _motor.Cover.Right).normalized * 8f;
						_motor.InputStandRight();
					}
				}
			}
			_motor.SetAimTarget(position);
			if (DebugAim)
			{
				UnityEngine.Debug.DrawLine(_motor.GunOrigin, position, Color.red);
			}
			BaseGun gun = _motor.EquippedWeapon.Gun;
			if (gun != null)
			{
				gun.AddErrorThisFrame(AccuracyError);
			}
		}
	}
}
