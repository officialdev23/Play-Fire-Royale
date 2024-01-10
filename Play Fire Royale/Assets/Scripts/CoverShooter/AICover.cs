// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AICover
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	public class AICover : AIBase
	{
		private enum TakeMode
		{
			none,
			takeCover,
			takeCoverAgainst,
			takeDefense,
			switchCover,
			takeCloseTo
		}

		[Tooltip("Maximum angle of a low cover relative to the enemy.")]
		public float MaxLowCoverThreatAngle = 60f;

		[Tooltip("Maximum angle of a tall cover relative to the enemy.")]
		public float MaxTallCoverThreatAngle = 40f;

		[Tooltip("Maximum angle of a cover relative to the defense position.")]
		public float MaxDefenseAngle = 85f;

		[Tooltip("If an enemy is on the same cover side as the AI, the cover will be taken if only the distance is greater than this value.")]
		public float MinDefenselessDistance = 30f;

		[Tooltip("Maximum distance of a cover for AI to take.")]
		public float MaxCoverDistance = 30f;

		[Tooltip("AI won't switch to cover positions closer than this distance.")]
		public float MinSwitchDistance = 6f;

		[Tooltip("AI avoids taking covers that are closer to the enemy.")]
		public float AvoidDistance = 6f;

		private Actor _actor;

		private CharacterMotor _motor;

		private NavMeshPath _path;

		private Vector3[] _corners = new Vector3[32];

		private bool _isRunning = true;

		private Cover _targetCover;

		private Vector3 _targetPosition;

		private int _targetDirection;

		private Vector3 _pivotPosition;

		private bool _hasPivot;

		private bool _isPivotThreat;

		private Cover _registeredCover;

		private CoverCache _covers = new CoverCache();

		private bool _hasAskedToStopMoving;

		private bool _hasTakenTheRightCover;

		private bool _hasMaxPivotDistance = true;

		private float _maxPivotDistance;

		private bool _takeAnyCover;

		private bool _isKeepingCloseTo;

		private KeepCloseTo _keepCloseTo;

		private Actor[] _cachedEnemies;

		private bool _hasCachedEnemies;

		private int _cachedEnemyCount;

		private TakeMode _mode;

		private int _modeWait;

		private Cover _unreachableCover;

		private float _takeCloseToRadius;

		private Vector3 _takeCloseToPosition;

		public void OnThreatPosition(Vector3 position)
		{
			_pivotPosition = position;
			_isPivotThreat = true;
		}

		public void OnMaxCoverPivotDistance(float value)
		{
			_hasMaxPivotDistance = true;
			_maxPivotDistance = value;
		}

		public void OnNoMaxCoverPivotDistance()
		{
			_hasMaxPivotDistance = false;
		}

		public void OnHoldPosition(Vector3 position)
		{
			_takeAnyCover = true;
			nullCover();
			updateRegistration();
		}

		public void OnPositionUnreachable(Vector3 position)
		{
			if (_targetCover != null && Vector3.Distance(_targetPosition, position) <= 0.2f)
			{
				_unreachableCover = _targetCover;
			}
		}

		public void ToKeepCloseTo(KeepCloseTo value)
		{
			_isKeepingCloseTo = true;
			_keepCloseTo = value;
		}

		public void ToRunToCovers()
		{
			_isRunning = true;
		}

		public void ToWalkToCovers()
		{
			_isRunning = false;
		}

		public void ToTakeCover()
		{
			_hasPivot = false;
			_takeAnyCover = false;
			nullCover();
			if (base.isActiveAndEnabled)
			{
				if (_isKeepingCloseTo)
				{
					_covers.Reset(_keepCloseTo.Position, _keepCloseTo.Distance);
				}
				else
				{
					_covers.Reset(base.transform.position, MaxCoverDistance);
				}
				_mode = TakeMode.takeCover;
				_modeWait = 2;
				Message("OnCoverSearch");
			}
			updateRegistration();
		}

		public void ToTakeCoverAgainst(Vector3 position)
		{
			_hasPivot = true;
			_pivotPosition = position;
			_takeAnyCover = false;
			_isPivotThreat = true;
			nullCover();
			if (base.isActiveAndEnabled)
			{
				if (_isKeepingCloseTo)
				{
					_covers.Reset(_keepCloseTo.Position, _keepCloseTo.Distance);
				}
				else
				{
					_covers.Reset(base.transform.position, MaxCoverDistance);
				}
				_mode = TakeMode.takeCoverAgainst;
				_modeWait = 2;
				Message("OnCoverSearch");
			}
			updateRegistration();
		}

		public void ToTakeDefenseCover(Vector3 position)
		{
			_hasPivot = true;
			_pivotPosition = position;
			_takeAnyCover = false;
			_isPivotThreat = false;
			nullCover();
			if (base.isActiveAndEnabled)
			{
				if (_isKeepingCloseTo)
				{
					_covers.Reset(_keepCloseTo.Position, _keepCloseTo.Distance);
				}
				else
				{
					_covers.Reset(base.transform.position, MaxCoverDistance);
				}
				_mode = TakeMode.takeDefense;
				_modeWait = 2;
				Message("OnCoverSearch");
			}
			updateRegistration();
		}

		public void ToSwitchCover()
		{
			_takeAnyCover = false;
			nullCover();
			if (base.isActiveAndEnabled)
			{
				if (_isKeepingCloseTo)
				{
					_covers.Reset(_keepCloseTo.Position, _keepCloseTo.Distance);
				}
				else
				{
					_covers.Reset(base.transform.position, MaxCoverDistance);
				}
				_mode = TakeMode.switchCover;
				_modeWait = 2;
				Message("OnCoverSearch");
			}
			updateRegistration();
		}

		public void ToTakeCoverCloseTo(AIBaseRegrouper regrouper)
		{
			_takeAnyCover = false;
			nullCover();
			if (base.isActiveAndEnabled)
			{
				_takeCloseToRadius = regrouper.Radius;
				AIMovement component = regrouper.GetComponent<AIMovement>();
				_takeCloseToPosition = regrouper.transform.position;
				if (component != null)
				{
					_takeCloseToPosition = component.Destination;
				}
				_covers.Reset(_takeCloseToPosition, MaxCoverDistance);
				_mode = TakeMode.takeCloseTo;
				_modeWait = 2;
				Message("OnCoverSearch");
			}
			updateRegistration();
		}

		public void ToStopMoving()
		{
			if (_actor.Cover != _targetCover)
			{
				_takeAnyCover = false;
				nullCover();
			}
		}

		public void ToLeaveCover()
		{
			_takeAnyCover = false;
			nullCover();
			updateRegistration();
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
			_path = new NavMeshPath();
		}

		private void Update()
		{
			if (_actor == null || !_actor.IsAlive)
			{
				return;
			}
			updateRegistration();
			if (_modeWait > 0)
			{
				_modeWait--;
			}
			else
			{
				switch (_mode)
				{
				case TakeMode.takeCover:
				{
					_mode = TakeMode.none;
					_targetCover = null;
					WeaponDescription equippedWeapon4 = _motor.EquippedWeapon;
					if (equippedWeapon4.IsNull || !equippedWeapon4.PreventCovers)
					{
						for (int l = 0; l < _covers.Items.Count; l++)
						{
							CoverItem coverItem4 = _covers.Items[l];
							if (isValidCover(coverItem4.Cover, coverItem4.Position, coverItem4.Direction,  true, avoidPivot: false))
							{
								takeCover(coverItem4.Cover, coverItem4.Position, coverItem4.Direction, 1f);
								break;
							}
						}
					}
					if (_targetCover != null)
					{
						Message("OnFoundCover");
					}
					else
					{
						Message("OnNoCover");
					}
					break;
				}
				case TakeMode.takeCoverAgainst:
				{
					_mode = TakeMode.none;
					_targetCover = null;
					WeaponDescription equippedWeapon5 = _motor.EquippedWeapon;
					if (equippedWeapon5.IsNull || !equippedWeapon5.PreventCovers)
					{
						bool flag2 = Vector3.Distance(base.transform.position, _pivotPosition) < AvoidDistance;
						for (int m = 0; m < _covers.Items.Count; m++)
						{
							CoverItem coverItem5 = _covers.Items[m];
							if (isValidCover(coverItem5.Cover, coverItem5.Position, coverItem5.Direction,  true, !flag2))
							{
								takeCover(coverItem5.Cover, coverItem5.Position, coverItem5.Direction, 1f);
								break;
							}
						}
					}
					if (_targetCover != null)
					{
						Message("OnFoundCover");
					}
					else
					{
						Message("OnNoCover");
					}
					break;
				}
				case TakeMode.takeDefense:
				{
					_mode = TakeMode.none;
					_targetCover = null;
					WeaponDescription equippedWeapon3 = _motor.EquippedWeapon;
					if (equippedWeapon3.IsNull || !equippedWeapon3.PreventCovers)
					{
						for (int k = 0; k < _covers.Items.Count; k++)
						{
							CoverItem coverItem3 = _covers.Items[k];
							if (isValidCover(coverItem3.Cover, coverItem3.Position, coverItem3.Direction,  true, avoidPivot: false))
							{
								takeCover(coverItem3.Cover, coverItem3.Position, coverItem3.Direction, 1f);
								break;
							}
						}
					}
					if (_targetCover != null)
					{
						Message("OnFoundCover");
					}
					else
					{
						Message("OnNoCover");
					}
					break;
				}
				case TakeMode.switchCover:
				{
					_mode = TakeMode.none;
					_targetCover = null;
					WeaponDescription equippedWeapon2 = _motor.EquippedWeapon;
					if (equippedWeapon2.IsNull || !equippedWeapon2.PreventCovers)
					{
						float num = Vector3.Distance(base.transform.position, _pivotPosition);
						bool flag = num < AvoidDistance;
						for (int j = 0; j < _covers.Items.Count; j++)
						{
							CoverItem coverItem2 = _covers.Items[j];
							if (Vector3.Distance(base.transform.position, coverItem2.Position) >= MinSwitchDistance && Vector3.Distance(coverItem2.Position, _pivotPosition) < num && isValidCover(coverItem2.Cover, coverItem2.Position, coverItem2.Direction,  true, !flag))
							{
								takeCover(coverItem2.Cover, coverItem2.Position, coverItem2.Direction, 1f);
								break;
							}
						}
					}
					if (_targetCover != null)
					{
						Message("OnFoundCover");
					}
					else
					{
						Message("OnNoCover");
					}
					break;
				}
				case TakeMode.takeCloseTo:
				{
					_mode = TakeMode.none;
					_targetCover = null;
					WeaponDescription equippedWeapon = _motor.EquippedWeapon;
					if (equippedWeapon.IsNull || !equippedWeapon.PreventCovers)
					{
						for (int i = 0; i < _covers.Items.Count; i++)
						{
							CoverItem coverItem = _covers.Items[i];
							if (Vector3.Distance(coverItem.Position, _takeCloseToPosition) <= _takeCloseToRadius && isValidCover(coverItem.Cover, coverItem.Position, coverItem.Direction,  true, avoidPivot: false))
							{
								takeCover(coverItem.Cover, coverItem.Position, coverItem.Direction, 1f);
								break;
							}
						}
					}
					if (_targetCover != null)
					{
						Message("OnFoundCover");
					}
					else
					{
						Message("OnNoCover");
					}
					break;
				}
				}
			}
			if (_targetCover == null)
			{
				if (_takeAnyCover && _motor.PotentialCover != null)
				{
					_targetCover = _motor.PotentialCover;
					_motor.InputTakeCover();
				}
				else if (!_takeAnyCover && _motor.Cover != null)
				{
					_motor.InputLeaveCover();
				}
			}
			if (_motor.Cover != _targetCover && _targetCover != null)
			{
				if (_motor.PotentialCover != null && (_motor.PotentialCover == _targetCover || _motor.PotentialCover.LeftAdjacent == _targetCover || _motor.PotentialCover.RightAdjacent == _targetCover))
				{
					_motor.InputTakeCover();
				}
				else if (_motor.Cover != null && _motor.Cover.LeftAdjacent != _targetCover && _motor.Cover.RightAdjacent != _targetCover)
				{
					_motor.InputLeaveCover();
				}
				else if (Vector3.Distance(base.transform.position, _targetPosition) < 0.5f)
				{
					_motor.InputImmediateCoverSearch();
				}
			}
			if (_targetCover != null)
			{
				WeaponDescription equippedWeapon6 = _motor.EquippedWeapon;
				if (!equippedWeapon6.IsNull && equippedWeapon6.PreventCovers)
				{
					_targetCover = null;
					Message("OnInvalidCover");
				}
				else if (_hasPivot && !isValidCover(_targetCover, _targetPosition, _targetDirection,  false))
				{
					Message("OnInvalidCover");
				}
			}
			if (_targetCover != null && _targetCover == _motor.Cover && _targetCover.IsTall)
			{
				if (_targetDirection > 0)
				{
					_motor.InputStandRight();
					if (!_motor.IsNearRightCorner)
					{
						_motor.InputMovement(new CharacterMovement(_targetCover.Right, 0.5f));
					}
				}
				else
				{
					_motor.InputStandLeft();
					if (!_motor.IsNearLeftCorner)
					{
						_motor.InputMovement(new CharacterMovement(_targetCover.Left, 0.5f));
					}
				}
			}
			if (_targetCover != null && _motor.Cover != null && Vector3.Distance(_actor.transform.position, _targetPosition) < 0.5f && (_motor.Cover == _targetCover || _motor.Cover.LeftAdjacent == _targetCover || _motor.Cover.RightAdjacent == _targetCover))
			{
				if (!_hasTakenTheRightCover)
				{
					_hasTakenTheRightCover = true;
					Message("OnFinishTakeCover");
				}
				if (!_hasAskedToStopMoving)
				{
					_hasAskedToStopMoving = true;
					Message("ToStopMoving");
				}
			}
			else
			{
				_hasAskedToStopMoving = false;
			}
			_hasCachedEnemies = false;
		}

		private void updateRegistration()
		{
			if (_registeredCover != _targetCover)
			{
				if (_registeredCover != null)
				{
					_registeredCover.UnregisterUser(_actor);
				}
				_registeredCover = _targetCover;
			}
			if (_registeredCover != null)
			{
				if (_actor.Cover == _registeredCover)
				{
					_registeredCover.RegisterUser(_actor, _actor.transform.position);
				}
				else
				{
					_registeredCover.RegisterUser(_actor, _targetPosition);
				}
			}
		}

		private void takeCover(Cover cover, Vector3 position, int direction, float speed)
		{
			_targetPosition = position;
			_targetCover = cover;
			_targetDirection = direction;
			_hasTakenTheRightCover = false;
			_hasAskedToStopMoving = false;
			updateRegistration();
			if (_isRunning)
			{
				Message("ToRunTo", position);
			}
			else
			{
				Message("ToWalkTo", position);
			}
		}

		private void nullCover()
		{
			if (_targetCover != null)
			{
				_targetCover = null;
			}
		}

		private bool isValidCover(Cover cover, Vector3 position, int direction, bool checkPath, bool avoidPivot = true)
		{
			if (cover == _unreachableCover)
			{
				return false;
			}
			if (_isKeepingCloseTo && Vector3.Distance(position, _keepCloseTo.Position) > _keepCloseTo.Distance)
			{
				return false;
			}
			if (!_hasPivot)
			{
				if (!AIUtil.IsCoverPositionFree(cover, position, 1f, _actor))
				{
					return false;
				}
				return true;
			}
			if (!_hasCachedEnemies)
			{
				_cachedEnemyCount = 0;
				_hasCachedEnemies = true;
				int num = AIUtil.FindActors(position, MinDefenselessDistance, _actor);
				if (num > 0)
				{
					int num2 = 0;
					for (int i = 0; i < num; i++)
					{
						if (AIUtil.Actors[i].Side != _actor.Side)
						{
							num2++;
						}
					}
					if (num2 > 0)
					{
						if (_cachedEnemies == null || _cachedEnemies.Length < num2)
						{
							_cachedEnemies = new Actor[num2];
						}
						int num3 = 0;
						for (int j = 0; j < num; j++)
						{
							if (AIUtil.Actors[j].Side != _actor.Side)
							{
								_cachedEnemies[num3++] = AIUtil.Actors[j];
							}
						}
						_cachedEnemyCount = num3;
					}
				}
			}
			for (int k = 0; k < _cachedEnemyCount; k++)
			{
				Actor actor = _cachedEnemies[k];
				if (actor.Side != _actor.Side)
				{
					Vector3 position2 = actor.transform.position;
					float num5 = Vector3.Distance(position, position2);
					if (num5 < AvoidDistance)
					{
						return false;
					}
					if (!AIUtil.IsGoodAngle(MaxTallCoverThreatAngle, MaxLowCoverThreatAngle, cover, position, position2, cover.IsTall))
					{
						return false;
					}
				}
			}
			if (_isPivotThreat)
			{
				float num6 = Vector3.Distance(position, _pivotPosition);
				if (_hasMaxPivotDistance && num6 > _maxPivotDistance)
				{
					return false;
				}
				if (AIUtil.IsObstructed(position + (_actor.StandingTopPosition - base.transform.position), _pivotPosition + Vector3.up * 2f))
				{
					return false;
				}
			}
			else
			{
				float num7 = Vector3.Distance(position, _pivotPosition);
				if (_hasMaxPivotDistance && num7 > _maxPivotDistance)
				{
					return false;
				}
				if (!AIUtil.IsGoodAngle(MaxDefenseAngle, MaxDefenseAngle, cover, _pivotPosition, position, cover.IsTall))
				{
					return false;
				}
			}
			if (!AIUtil.IsCoverPositionFree(cover, position, 1f, _actor))
			{
				return false;
			}
			if (checkPath)
			{
				if (!NavMesh.CalculatePath(base.transform.position, position, 1, _path))
				{
					return false;
				}
				if (avoidPivot)
				{
					int cornersNonAlloc = _path.GetCornersNonAlloc(_corners);
					for (int l = 0; l < cornersNonAlloc; l++)
					{
						Vector3 a = (l != 0) ? _corners[l - 1] : base.transform.position;
						Vector3 b = _corners[l];
						Vector3 a2 = Util.FindClosestToPath(a, b, _pivotPosition);
						if (Vector3.Distance(a2, _pivotPosition) < AvoidDistance)
						{
							return false;
						}
					}
				}
			}
			return true;
		}
	}
}
