// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFormation
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(FighterBrain))]
	[RequireComponent(typeof(AIMovement))]
	public class AIFormation : AIBase, ICharacterWalkListener
	{
		[Tooltip("Formation leader.")]
		public AIFormation Leader;

		[Tooltip("Formation to take. Followers use the value presented by the leader ignoring their own.")]
		public FormationType Formation;

		[Tooltip("Are the members of the formation aggressive (overrides FighterBrain.ImmediateThreatReaction).")]
		public bool Aggressive = true;

		[Tooltip("Minimum space the followers keep between each other.")]
		public float FollowerSpacing = 1f;

		[Tooltip("The AI will run only if the stamina is this or higher.")]
		[Range(0f, 1f)]
		public float RunStaminaFraction = 0.5f;

		[Tooltip("AI will run towards the position if the distance to it is greater.")]
		public float MinRunDistance = 4f;

		[Tooltip("AI will avoid staying further from the leader than this given distance.")]
		public float CombatDistance = 8f;

		[Tooltip("Settings for the free roam (in danger) formation.")]
		public FreeRoamInDangerSettings FreeRoamInDanger = FreeRoamInDangerSettings.Default();

		[Tooltip("Settings for the free roam (out of danger) formation.")]
		public FreeRoamOutOfDangerSettings FreeRoamOutOfDanger = FreeRoamOutOfDangerSettings.Default();

		[Tooltip("Settings for the line formation.")]
		public LineFormationSettings Line = LineFormationSettings.Default();

		[Tooltip("Settings for the square formation.")]
		public SquareFormationSettings Square = SquareFormationSettings.Default();

		private Actor _actor;

		private FighterBrain _brain;

		private NavMeshObstacle _obstacle;

		private bool _hadPreviousLeaderPosition;

		private Vector3 _previousLeaderPosition;

		private float _pathTimer;

		private Vector3 _pathTarget;

		private List<AIFormation> _followers = new List<AIFormation>();

		private List<AIFormation> _followerBuild = new List<AIFormation>();

		private List<int> _followerToPositionId = new List<int>();

		private List<int> _positionBuild = new List<int>();

		private List<Vector3> _line = new List<Vector3>();

		private bool _isMaintainingPosition;

		private bool _isInProcess;

		private bool _wasTakingCover;

		private float _takeCoverTimer;

		private float _coverSearchTimer;

		private bool _takeCoverCheck;

		private int _registrationId;

		private Vector3 _direction;

		private Vector3 _lastPosition;

		private CharacterStamina _stamina;

		private bool _isRunning;

		private bool _hasThreat;

		private bool _isRegrouping;

		public float MaxDistance => FreeRoamInDanger.MaxDistance;

		public Vector3 Direction => _direction;

		public Actor Actor => _actor;

		public FighterBrain Brain => _brain;

		protected Vector3 Position
		{
			get
			{
				if (_pathTimer > float.Epsilon)
				{
					return _pathTarget;
				}
				return base.transform.position;
			}
		}

		private bool canRun
		{
			get
			{
				if (_stamina == null)
				{
					return true;
				}
				return _stamina.Stamina / _stamina.MaxStamina >= RunStaminaFraction;
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_brain = GetComponent<FighterBrain>();
			_stamina = GetComponent<CharacterStamina>();
			_obstacle = GetComponent<NavMeshObstacle>();
			_direction = base.transform.forward;
			_lastPosition = base.transform.position;
		}

		public void OnThreat(Actor value)
		{
			_hasThreat = true;
		}

		public void OnNoThreat()
		{
			_hasThreat = false;
		}

		public void OnStop()
		{
			_isRunning = false;
		}

		public void OnRun()
		{
			_isRunning = true;
		}

		public void OnSprint()
		{
			_isRunning = true;
		}

		public void OnWalk()
		{
			_isRunning = false;
		}

		public void OnFoundCover()
		{
			_takeCoverCheck = true;
		}

		protected AIFormation GetFollower(int index)
		{
			if (index < _followers.Count)
			{
				return _followers[index];
			}
			return null;
		}

		protected int Register(AIFormation follower)
		{
			int num = _followerBuild.IndexOf(follower);
			if (num >= 0)
			{
				return num;
			}
			int count = _followerBuild.Count;
			_followerBuild.Add(follower);
			return count;
		}

		public void ToRegroupFormation()
		{
			_isRegrouping = true;
			Message("ToEnterProcess", _hasThreat);
		}

		public void ToEnterProcess()
		{
			_isInProcess = true;
		}

		public void ToExitProcess()
		{
			_isInProcess = false;
		}

		public void ToExitProcessAndMaintainPosition()
		{
			_isInProcess = false;
		}

		public void OnHoldPosition(Vector3 position)
		{
			_isMaintainingPosition = true;
			_pathTarget = position;
			_pathTimer = 999999f;
		}

		public void OnStopHoldingPosition()
		{
			_isMaintainingPosition = false;
			_pathTimer = 0f;
		}

		protected void MoveTo(Vector3 position, float duration)
		{
			_pathTarget = position;
			_pathTimer = duration;
			if ((_isRunning || canRun) && ShouldRun(position))
			{
				Message("ToRunTo", position);
			}
			else
			{
				Message("ToWalkTo", position);
			}
		}

		private bool ShouldRun(Vector3 target)
		{
			return Vector3.Distance(base.transform.position, target) >= MinRunDistance;
		}

		private void OnDisable()
		{
			_isMaintainingPosition = false;
		}

		private void Update()
		{
			if (Vector3.Distance(base.transform.position, _lastPosition) > 0.3f)
			{
				_direction = (base.transform.position - _lastPosition).normalized;
				_lastPosition = base.transform.position;
			}
			if (!_actor.IsAlive || (_isMaintainingPosition && Brain.enabled))
			{
				return;
			}
			if (_brain.enabled && (_brain.Threat != null || _hasThreat) && !_isRegrouping)
			{
				if (Leader != null && _brain.LockedThreat != null)
				{
					Message("ToKeepCloseTo", new KeepCloseTo(Leader.transform.position, CombatDistance));
				}
			}
			else if (this == Leader)
			{
				_brain.ImmediateThreatReaction = Aggressive;
				_followers.Clear();
				_followers.AddRange(_followerBuild);
				_followerBuild.Clear();
				_followerToPositionId.Clear();
				_line.Clear();
				for (int i = 0; i < _followers.Count; i++)
				{
					_followerToPositionId.Add(-1);
				}
				FormationType formationType = Leader.Formation;
				if (_isRegrouping && formationType == FormationType.Free)
				{
					formationType = FormationType.Square;
				}
				switch (formationType)
				{
				case FormationType.Line:
					for (int k = 0; k < _followers.Count; k++)
					{
						int num = -1;
						float num2 = 0f;
						Vector3 item = Vector3.zero;
						for (int l = 0; l < _followers.Count; l++)
						{
							if (_followerToPositionId[l] < 0)
							{
								Vector3 vector = followerLinePositionAt(k, _followers[l].transform.position);
								float num3 = Vector3.Distance(_followers[l].transform.position, vector);
								if (num < 0 || num3 < num2)
								{
									num2 = num3;
									num = l;
									item = vector;
								}
							}
						}
						_line.Add(item);
						_followerToPositionId[num] = k;
					}
					break;
				case FormationType.Square:
				{
					float minDist = 1E+08f;
					_positionBuild.Clear();
					for (int j = 0; j < _followers.Count; j++)
					{
						_positionBuild.Add(-1);
					}
					recursiveEvaluate(formationType, 0, ref minDist);
					break;
				}
				}
				for (int m = 0; m < _followers.Count - 1; m++)
				{
					for (int n = m + 1; n < _followers.Count; n++)
					{
						if (formationType != 0)
						{
							continue;
						}
						float num4 = Vector3.Distance(_followers[m].Position, _followers[n].Position);
						bool flag = false;
						if (num4 < FollowerSpacing)
						{
							for (int num5 = 0; num5 < 6; num5++)
							{
								float d = Random.Range(FollowerSpacing, _followers[m].MaxDistance);
								int num6 = Random.Range(0, 360);
								Vector3 vector2 = base.transform.position + Util.HorizontalVector(num6) * d;
								bool flag2 = true;
								if (!_followers[num5]._isInProcess || _followers[num5]._isRegrouping)
								{
									for (int num7 = n; num7 < _followers.Count; num7++)
									{
										if ((!_followers[num7]._isInProcess || !_followers[num7]._isRegrouping) && Vector3.Distance(vector2, _followers[num7].Position) < FollowerSpacing)
										{
											flag2 = false;
											break;
										}
									}
								}
								if (flag2)
								{
									_followers[m].MoveTo(vector2, 1f);
									flag = true;
									break;
								}
							}
						}
						if (flag)
						{
							break;
						}
					}
				}
				_hadPreviousLeaderPosition = false;
			}
			else
			{
				if (!(Leader != null))
				{
					return;
				}
				_brain.ImmediateThreatReaction = Leader.Aggressive;
				_registrationId = Leader.Register(this);
				bool flag3 = _brain.State == FighterState.maintainPosition || _brain.State == FighterState.avoidGrenade || _brain.State == FighterState.process;
				if (!_isRegrouping && !flag3)
				{
					_brain.SetIdleAlertedState();
				}
				if (_takeCoverTimer > float.Epsilon)
				{
					_takeCoverTimer -= Time.deltaTime;
				}
				if (_coverSearchTimer > float.Epsilon)
				{
					_coverSearchTimer -= Time.deltaTime;
				}
				if (_pathTimer > float.Epsilon)
				{
					_pathTimer -= Time.deltaTime;
				}
				else if (!flag3 || _isRegrouping)
				{
					FormationType formationType2 = Leader.Formation;
					if (_isRegrouping && formationType2 == FormationType.Free)
					{
						formationType2 = FormationType.Square;
					}
					if (!_isInProcess || _isRegrouping)
					{
						switch (formationType2)
						{
						case FormationType.Free:
							if (Leader._brain.IsInDanger)
							{
								updateFreeRoamInDanger();
							}
							else
							{
								updateFreeRoamOutOfDanger();
							}
							break;
						case FormationType.Square:
						case FormationType.Line:
							updatePositional(formationType2);
							break;
						}
					}
				}
				_previousLeaderPosition = Leader.transform.position;
				_hadPreviousLeaderPosition = true;
			}
		}

		private void recursiveEvaluate(FormationType formation, int index, ref float minDist)
		{
			for (int i = 0; i < _followers.Count; i++)
			{
				if (!containsInPositionBuild(index, i))
				{
					_positionBuild[index] = i;
					if (index + 1 == _followers.Count)
					{
						evaluatePositionBuild(formation, ref minDist);
					}
					else
					{
						recursiveEvaluate(formation, index + 1, ref minDist);
					}
				}
			}
		}

		private bool containsInPositionBuild(int index, int value)
		{
			if (index <= 0)
			{
				return false;
			}
			for (int i = 0; i < index; i++)
			{
				if (_positionBuild[i] == value)
				{
					return true;
				}
			}
			return false;
		}

		private void evaluatePositionBuild(FormationType formation, ref float minDist)
		{
			float num = 0f;
			for (int i = 0; i < _followers.Count; i++)
			{
				num += Vector3.Distance(_followers[i].transform.position, followerPositionAt(formation, _positionBuild[i]));
			}
			if (num < minDist)
			{
				minDist = num;
				for (int j = 0; j < _followers.Count; j++)
				{
					_followerToPositionId[j] = _positionBuild[j];
				}
			}
		}

		private Vector3 followerPositionFor(FormationType formation, int index)
		{
			if (_followerToPositionId.Count > index)
			{
				return followerPositionAt(formation, _followerToPositionId[index]);
			}
			return followerPositionAt(formation, index);
		}

		private Vector3 followerLinePositionAt(int index, Vector3 current)
		{
			Vector3 vector = (index > 0) ? _line[index - 1] : base.transform.position;
			return vector + (current - vector).normalized * Line.Distance;
		}

		private Vector3 followerPositionAt(FormationType formation, int index)
		{
			switch (formation)
			{
			case FormationType.Square:
			{
				Vector3 a = Vector3.Cross(Direction, Vector3.up);
				Vector3 position;
				switch (index)
				{
				case 0:
					position = base.transform.position - (a + Direction).normalized * Square.Distance;
					break;
				case 1:
					position = base.transform.position - (-a + Direction).normalized * Square.Distance;
					break;
				default:
					position = base.transform.position - Direction * Square.Distance * index;
					break;
				}
				Vector3 b = position;
				AIUtil.GetClosestStandablePosition(ref position);
				Vector3 vector = Vector3.zero;
				bool flag = false;
				float num = 0f;
				for (int i = 0; i < _followers.Count; i++)
				{
					float num2 = Vector3.Distance(_followers[i].transform.position, b);
					if (_followers[i]._obstacle != null && _followers[i]._obstacle.enabled && num2 <= _followers[i]._obstacle.radius + float.Epsilon)
					{
						num2 = 0f;
					}
					if (!flag || num2 < num)
					{
						vector = _followers[i].transform.position;
						num = num2;
						flag = true;
					}
				}
				if (flag && Vector3.Distance(position, b) > num)
				{
					position = vector;
				}
				return position;
			}
			case FormationType.Line:
				return _line[index];
			default:
				return Vector3.zero;
			}
		}

		private void updatePositional(FormationType formation)
		{
			if (Leader._followerToPositionId.Count < Leader._followers.Count || Leader._followers.Count <= _registrationId)
			{
				return;
			}
			Vector3 vector = Leader.followerPositionFor(formation, _registrationId);
			if (Vector3.Distance(vector, base.transform.position) < 0.2f)
			{
				if (_isRegrouping)
				{
					_isRegrouping = false;
					Message("ToExitProcess");
				}
			}
			else if ((ShouldRun(vector) || Leader._isRunning) && (_isRunning || canRun))
			{
				Message("ToRunTo", vector);
			}
			else
			{
				Message("ToWalkTo", vector);
			}
		}

		private void updateFreeRoamInDanger()
		{
			if (_wasTakingCover && _takeCoverTimer <= float.Epsilon)
			{
				_wasTakingCover = false;
			}
			if ((_wasTakingCover || _actor.Cover != null) && !(Vector3.Distance(Leader.transform.position, base.transform.position) > FreeRoamInDanger.MaxDistance))
			{
				return;
			}
			bool flag = true;
			if (_coverSearchTimer <= float.Epsilon)
			{
				_takeCoverCheck = false;
				Message("OnMaxCoverPivotDistance", FreeRoamInDanger.MaxDistance);
				Message("ToFindDefenseCover", Leader.transform.position);
				if (_takeCoverCheck)
				{
					_wasTakingCover = true;
					_takeCoverTimer = 2f;
				}
				else
				{
					flag = true;
				}
				_coverSearchTimer = 0.5f;
			}
			if (!flag)
			{
				return;
			}
			Vector3 a = Vector3.zero;
			if (_hadPreviousLeaderPosition)
			{
				a = Leader.transform.position - _previousLeaderPosition;
			}
			Vector3 vector = Leader.transform.position - base.transform.position;
			float magnitude = vector.magnitude;
			if (!(magnitude > MaxDistance) && (!(magnitude > FreeRoamInDanger.FollowDistance) || !(a.magnitude > 0.1f)))
			{
				return;
			}
			Vector3 vector2 = (!(a.magnitude > 0.1f) || !(Util.DistanceToSegment(Leader.transform.position, base.transform.position, base.transform.position + a * 1000f) < MaxDistance)) ? vector.normalized : a.normalized;
			if (!Util.IsFree(base.gameObject, base.transform.position + Vector3.up * 0.25f, vector2, 2f, coverMeansFree: false, actorMeansFree: true))
			{
				MoveTo(Leader.transform.position - vector.normalized * FreeRoamInDanger.FollowDistance, 0.5f);
			}
			else if (!_isRegrouping)
			{
				if (Leader._isRunning && (_isRunning || canRun))
				{
					Message("ToRunInDirection", vector2);
				}
				else
				{
					Message("ToWalkInDirection", vector2);
				}
			}
		}

		private void updateFreeRoamOutOfDanger()
		{
			Vector3 a = Vector3.zero;
			if (_hadPreviousLeaderPosition)
			{
				a = Leader.transform.position - _previousLeaderPosition;
			}
			Vector3 vector = Leader.transform.position - base.transform.position;
			float magnitude = vector.magnitude;
			if (!(magnitude > MaxDistance) && (!(magnitude > FreeRoamOutOfDanger.FollowDistance) || !(a.magnitude > 0.1f)))
			{
				return;
			}
			Vector3 vector2 = (!(a.magnitude > 0.1f) || !(Util.DistanceToSegment(Leader.transform.position, base.transform.position, base.transform.position + a * 1000f) < MaxDistance)) ? vector.normalized : a.normalized;
			if (!Util.IsFree(base.gameObject, base.transform.position + Vector3.up * 0.25f, vector2, 2f, coverMeansFree: false, actorMeansFree: true))
			{
				MoveTo(Leader.transform.position - vector.normalized * FreeRoamOutOfDanger.FollowDistance, 0.5f);
			}
			else if (!_isRegrouping)
			{
				if (Leader._isRunning && (_isRunning || canRun))
				{
					Message("ToRunInDirection", vector2);
				}
				else
				{
					Message("ToWalkInDirection", vector2);
				}
			}
		}
	}
}
