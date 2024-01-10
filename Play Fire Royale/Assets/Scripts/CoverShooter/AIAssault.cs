// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIAssault
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(BaseBrain))]
	public class AIAssault : AIBase, ICharacterSuccessfulHitListener
	{
		[Tooltip("Distance at which the AI stops it's assault if attacking to fire.")]
		public float NonMeleeDistance = 8f;

		[Tooltip("Distance at which the AI will start to try and hit the enemy.")]
		public float MaxMeleeDistance = 1.5f;

		[Tooltip("Distance which the AI tries to maintain against the enemy.")]
		public float MinMeleeDistance = 1f;

		[Tooltip("Successful melee hits required before the assault is stopped.")]
		public int MeleeHits = 3;

		[Tooltip("Maximum time in seconds the AI will perform the assault before moving on to other tactics.")]
		public float MaxDuration = 20f;

		[Tooltip("Chance the AI takes cover after assaulting an enemy.")]
		[Range(0f, 1f)]
		public float TakeCoverChance = 0.5f;

		[Tooltip("Should the AI attack the enemy with melee. If there are no it will approach and fire from close range.")]
		public bool UseMeleeIfPossible = true;

		[Tooltip("Minimum time the AI wait blocking before an attack.")]
		public float MinBlockDuration = 2f;

		[Tooltip("Maximum time the AI will block before attacking, even if the enemy is attacking as well.")]
		public float MaxBlockDuration = 6f;

		[Tooltip("Amount of time before a melee attack to not block incoming melee attacks.")]
		public float PreHitFreezeDuration = 0.5f;

		[Tooltip("Amount of time after a melee attack to not block incoming melee attacks.")]
		public float PostHitFreezeDuration = 0.5f;

		private Actor _actor;

		private CharacterMotor _motor;

		private BaseBrain _brain;

		private bool _isAssaulting;

		private Vector3 _targetPosition;

		private Vector3 _threatPosition;

		private bool _isKeepingCloseTo;

		private KeepCloseTo _keepCloseTo;

		private int _hits;

		private float _wait;

		private bool _wasInMeleeRange;

		private bool _wasEverInMeleeRange;

		private bool _isInMelee;

		private float _blockWait;

		private float _postHitTime;

		private float _preHitTime;

		private bool _isGoingToHit;

		private bool isMelee => _motor.Weapon.HasMelee;

		private bool isGun => _motor.Weapon.Gun != null;

		public void AssaultCheck(Vector3 position)
		{
			if (base.isActiveAndEnabled)
			{
				if (isMelee)
				{
					Message("AssaultResponse");
				}
				else if (isGun && Vector3.Distance(base.transform.position, position) > NonMeleeDistance)
				{
					Message("AssaultResponse");
				}
			}
		}

		public void OnThreatPosition(Vector3 position)
		{
			if (!_isAssaulting || !base.isActiveAndEnabled)
			{
				return;
			}
			_threatPosition = position;
			if (Vector3.Distance(position, _targetPosition) > 0.5f)
			{
				_targetPosition = position;
				if (AIUtil.GetClosestStandablePosition(ref position))
				{
					Message("ToRunTo", position);
				}
				else
				{
					OnPositionUnreachable(position);
				}
			}
		}

		public void OnPositionUnreachable(Vector3 position)
		{
			if (_isAssaulting && Vector3.Distance(base.transform.position, position) > MaxMeleeDistance)
			{
				ToStopAssault();
			}
		}

		public void OnSuccessfulHit(Hit hit)
		{
			if (!hit.IsMelee)
			{
				return;
			}
			Actor actor = Actors.Get(hit.Target);
			if (!(actor == null) && actor.Side != _actor.Side)
			{
				_hits++;
				if (_hits >= MeleeHits)
				{
					ToStopAssault();
				}
			}
		}

		public void ToKeepCloseTo(KeepCloseTo value)
		{
			_isKeepingCloseTo = true;
			_keepCloseTo = value;
		}

		public void ToStartAssault(Vector3 position)
		{
			_targetPosition = position;
			if (!base.isActiveAndEnabled)
			{
				return;
			}
			bool isAssaulting = _isAssaulting;
			if (isMelee || Vector3.Distance(base.transform.position, position) > NonMeleeDistance)
			{
				_hits = 0;
				_isAssaulting = true;
				_wait = 0f;
				_wasInMeleeRange = false;
				_wasEverInMeleeRange = false;
				_isGoingToHit = false;
				_preHitTime = 0f;
				_postHitTime = 0f;
				runTo(position);
				if (!isAssaulting)
				{
					Message("OnAssaultStart");
				}
			}
		}

		public void ToStopAssault()
		{
			if (_isAssaulting)
			{
				_hits = 0;
				_isAssaulting = false;
				Message("ToStopMoving");
				if (Random.Range(0f, 1f) <= TakeCoverChance)
				{
					Message("ToFindCover");
				}
				Message("OnAssaultStop");
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
			_brain = GetComponent<BaseBrain>();
		}

		private void Update()
		{
			if (!_isAssaulting)
			{
				return;
			}
			_wait += Time.deltaTime;
			if (_wait >= MaxDuration)
			{
				ToStopAssault();
			}
			else if (isMelee)
			{
				if (_motor.IsPerformingMelee)
				{
					if (_brain.Threat != null)
					{
						float magnitude = (_brain.Threat.transform.position - base.transform.position).magnitude;
						if (magnitude <= MaxMeleeDistance)
						{
							_motor.InputCombo(_brain.Threat.transform.position);
						}
					}
					_postHitTime = PostHitFreezeDuration;
					_blockWait = 0f;
					return;
				}
				if (_wasEverInMeleeRange)
				{
					_blockWait += Time.deltaTime;
				}
				if (_isGoingToHit)
				{
					_preHitTime -= Time.deltaTime;
				}
				else if (_postHitTime > 0f)
				{
					_postHitTime -= Time.deltaTime;
				}
				bool flag = false;
				if (_brain.Threat != null)
				{
					Vector3 a = _brain.Threat.transform.position - base.transform.position;
					float magnitude2 = a.magnitude;
					Vector3 normalized = a.normalized;
					bool flag2 = !(_brain.Threat.Motor == null) && _brain.Threat.Motor.IsLow;
					if (_wasInMeleeRange && magnitude2 <= MaxMeleeDistance + 1f)
					{
						if (_isGoingToHit)
						{
							if (_preHitTime <= float.Epsilon)
							{
								if (flag2 && magnitude2 < MinMeleeDistance && _motor.IsFreeToMove(-normalized))
								{
									if (magnitude2 < MinMeleeDistance * 0.35f)
									{
										_motor.InputMovement(new CharacterMovement(-normalized, 1f, 0.2f));
									}
									else
									{
										_motor.InputMovement(new CharacterMovement(-normalized, 0.5f, 0.2f));
									}
								}
								else
								{
									_isGoingToHit = false;
									_motor.InputMelee(_brain.Threat.transform.position);
								}
							}
						}
						else if (_postHitTime <= float.Epsilon)
						{
							_motor.InputBlock();
						}
					}
					if (magnitude2 <= MaxMeleeDistance)
					{
						if (flag2)
						{
							_motor.InputVerticalMeleeAngle(30f);
						}
						else
						{
							_motor.InputVerticalMeleeAngle(0f);
						}
						flag = true;
						SendMessage("ToTurnAt", _brain.Threat.transform.position);
						if (magnitude2 < MinMeleeDistance && _motor.IsFreeToMove(-normalized))
						{
							if (magnitude2 < MinMeleeDistance * 0.35f)
							{
								_motor.InputMovement(new CharacterMovement(-normalized, 1f, 0.2f));
							}
							else
							{
								_motor.InputMovement(new CharacterMovement(-normalized, 0.5f, 0.2f));
							}
						}
						else
						{
							bool isGoingToHit = _isGoingToHit;
							if (_blockWait > MaxBlockDuration)
							{
								_isGoingToHit = true;
							}
							else if (_blockWait > MinBlockDuration)
							{
								Character character = Characters.Get(_brain.Threat.gameObject);
								if (character.Motor == null || !character.Motor.IsPerformingMelee)
								{
									_isGoingToHit = true;
								}
							}
							if (_isGoingToHit && !isGoingToHit)
							{
								_preHitTime = PreHitFreezeDuration;
							}
						}
						SendMessage("ToStopMoving");
					}
					else if (_wasInMeleeRange && magnitude2 < MaxMeleeDistance + 1f)
					{
						if (_postHitTime < 0f)
						{
							_motor.InputBlock();
						}
						flag = true;
						_motor.InputMovement(new CharacterMovement(a / magnitude2, 0.5f, 0.2f));
					}
					else if (magnitude2 > MaxMeleeDistance * 10f)
					{
						_wasEverInMeleeRange = false;
					}
				}
				if (flag)
				{
					_wasEverInMeleeRange = true;
					_wasInMeleeRange = true;
					return;
				}
				_motor.InputVerticalMeleeAngle(0f);
				if (_wasInMeleeRange)
				{
					_isGoingToHit = false;
					_blockWait = 0f;
					_wasInMeleeRange = false;
					_targetPosition = _threatPosition;
					runTo(_targetPosition);
				}
			}
			else if (Vector3.Distance(base.transform.position, _targetPosition) <= NonMeleeDistance)
			{
				ToStopAssault();
			}
		}

		private void runTo(Vector3 position)
		{
			if (_isKeepingCloseTo && Vector3.Distance(position, _keepCloseTo.Position) > _keepCloseTo.Distance)
			{
				position = _keepCloseTo.Position + (position - _keepCloseTo.Position).normalized * _keepCloseTo.Distance;
			}
			if (AIUtil.GetClosestStandablePosition(ref position))
			{
				Message("ToRunTo", position);
			}
			else
			{
				OnPositionUnreachable(position);
			}
		}
	}
}
