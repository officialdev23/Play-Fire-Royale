// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIMovement
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class AIMovement : AIBase
	{
		private enum Mode
		{
			none,
			inDirection,
			toPosition,
			fromPosition,
			circle
		}

		[Tooltip("The AI will roll if it is ordered to sprint from a position closer than this property.")]
		public float RollTriggerDistance = 2f;

		[Tooltip("Seconds to wait before changing the direction of circling.")]
		public float CircleDelay = 2f;

		[Tooltip("The AI will move out of the way of other actors that are closer than the threshold.")]
		public float ObstructionRadius = 1.5f;

		[Tooltip("Should a line to destination be drawn in the editor.")]
		public bool DebugDestination;

		[Tooltip("Should a path to destination be drawn in the editor.")]
		public bool DebugPath;

		private CharacterMotor _motor;

		private Actor _actor;

		private Mode _mode;

		private Vector3 _target;

		private float _speed = 1f;

		private float _inDirectionLeft;

		private NavMeshPath _path;

		private Vector3[] _pathPoints = new Vector3[64];

		private int _pathLength;

		private int _currentPathIndex;

		private Vector3 _direction;

		private bool _isCrouching;

		private int _side;

		private bool _wasMoving;

		private bool _isMoving;

		private NavMeshObstacle _obstacle;

		private bool _isRunningAwayTemp;

		private int _runningAwayFramesLeft;

		private bool _hasCheckedIfReachable;

		private Vector3 _positionToCheckIfReachable;

		private float _circleWait;

		private int _futureCircleDirection;

		private static Dictionary<Actor, AIMovement> _movements = new Dictionary<Actor, AIMovement>();

		private bool _isAvoidingMover;

		private float _avoidingTimer;

		private Vector3 _avoidDirection;

		private float _avoidSpeed;

		public Vector3 Destination
		{
			get
			{
				if (_mode == Mode.toPosition)
				{
					return _target;
				}
				return base.transform.position;
			}
		}

		public void OnThreatPosition(Vector3 value)
		{
			if (_mode == Mode.circle || _mode == Mode.fromPosition)
			{
				_target = value;
			}
		}

		public void ToCrouch()
		{
			_isCrouching = true;
		}

		public void ToStopCrouching()
		{
			_isCrouching = false;
		}

		public void ToCircle(Vector3 threat)
		{
			_mode = Mode.circle;
			_target = threat;
			_speed = 0.5f;
			_side = 0;
			Cover resultCover = null;
			Vector3 resultPosition = Vector3.zero;
			if (!Util.GetClosestCover(threat, 3f, ref resultCover, ref resultPosition))
			{
				return;
			}
			Vector3 rhs = resultPosition - base.transform.position;
			float num = Vector3.Dot(resultCover.Forward, rhs);
			if (num < 2f)
			{
				float num2 = Vector3.Dot(resultCover.Right, rhs);
				if (num2 > 0f)
				{
					_side = -1;
				}
				else
				{
					_side = 1;
				}
			}
		}

		public void ToWalkInDirection(Vector3 vector)
		{
			_mode = Mode.inDirection;
			_speed = 0.5f;
			_inDirectionLeft = 0.3f;
			updateDirection(vector, force: true);
		}

		public void ToRunInDirection(Vector3 vector)
		{
			_mode = Mode.inDirection;
			_speed = 1f;
			_inDirectionLeft = 0.3f;
			updateDirection(vector, force: true);
		}

		public void ToSprintInDirection(Vector3 vector)
		{
			_mode = Mode.inDirection;
			_speed = 2f;
			_inDirectionLeft = 0.3f;
			updateDirection(vector, force: true);
		}

		public void ToWalkTo(Vector3 destination)
		{
			moveTo(destination, 0.5f);
		}

		public void ToRunTo(Vector3 destination)
		{
			moveTo(destination, 1f);
		}

		public void ToSprintTo(Vector3 destination)
		{
			moveTo(destination, 2f);
		}

		public void ToWalkFrom(Vector3 target)
		{
			moveFrom(target, 0.5f);
		}

		public void ToRunFrom(Vector3 target)
		{
			moveFrom(target, 0.5f);
		}

		public void ToSprintFrom(Vector3 target)
		{
			Vector3 vector = base.transform.position - target;
			float magnitude = vector.magnitude;
			if (magnitude < RollTriggerDistance)
			{
				if (magnitude > 0.01f)
				{
					_motor.InputRoll(Util.RandomUnobstructedAngle(base.gameObject, base.transform.position + Vector3.up * 0.5f, Util.HorizontalAngle(vector), 90f, 2f));
				}
				else
				{
					_motor.InputRoll(Util.RandomUnobstructedAngle(base.gameObject, base.transform.position + Vector3.up * 0.5f, 2f));
				}
			}
			_isRunningAwayTemp = false;
			moveFrom(target, 0.5f);
		}

		public void ToKeepSprintingFrom(Vector3 target)
		{
			_isRunningAwayTemp = true;
			_runningAwayFramesLeft = 3;
			moveFrom(target, 0.5f);
		}

		public void ToStopMoving()
		{
			_mode = Mode.none;
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
			_obstacle = GetComponent<NavMeshObstacle>();
			_path = new NavMeshPath();
		}

		private void OnEnable()
		{
			_movements.Add(_actor, this);
		}

		private void OnDisable()
		{
			_movements.Remove(_actor);
			_mode = Mode.none;
		}

		private void Update()
		{
			_isMoving = false;
			if (_obstacle != null && _obstacle.enabled)
			{
				_obstacle.enabled = false;
			}
			if (_motor == null || !_motor.IsAlive)
			{
				if (_wasMoving)
				{
					Message("OnStopMoving");
					_wasMoving = false;
				}
				_mode = Mode.none;
				return;
			}
			if (_isCrouching)
			{
				_motor.InputCrouch();
			}
			if (_isAvoidingMover)
			{
				if (_avoidingTimer > float.Epsilon)
				{
					_avoidingTimer -= Time.deltaTime;
					move(_avoidDirection, 1f, noPath: false);
				}
				else
				{
					_isAvoidingMover = false;
				}
			}
			if (_mode == Mode.none)
			{
				if (_wasMoving)
				{
					Message("OnStopMoving");
					_wasMoving = false;
				}
				checkIncomingCollisions(Vector3.zero, 1f);
				return;
			}
			if (DebugDestination)
			{
				UnityEngine.Debug.DrawLine(base.transform.position, _target, Color.blue);
			}
			if (DebugPath)
			{
				for (int i = 0; i < _pathLength - 1; i++)
				{
					if (i == _currentPathIndex)
					{
						UnityEngine.Debug.DrawLine(_pathPoints[i], _pathPoints[i + 1], Color.cyan);
						UnityEngine.Debug.DrawLine(_pathPoints[i + 1], _pathPoints[i + 1] + Vector3.up, Color.cyan);
					}
					else
					{
						UnityEngine.Debug.DrawLine(_pathPoints[i], _pathPoints[i + 1], Color.green);
					}
				}
			}
			Vector3 vector = _target - base.transform.position;
			vector.y = 0f;
			Vector3 vector2 = vector.normalized;
			Vector3 vector3 = Vector3.Cross(vector2, Vector3.up);
			if (_futureCircleDirection == 0)
			{
				_circleWait = 0f;
			}
			switch (_mode)
			{
			case Mode.inDirection:
				if (!checkIncomingCollisions(_direction, _speed))
				{
					if (canMoveInDirection(_direction))
					{
						move(_direction, _speed, noPath: true);
					}
					_inDirectionLeft -= Time.deltaTime;
					if (_inDirectionLeft <= float.Epsilon)
					{
						_mode = Mode.none;
					}
				}
				break;
			case Mode.toPosition:
			{
				Vector3 b = Vector3.zero;
				bool flag = false;
				float num = 0f;
				if (_currentPathIndex <= _pathLength - 1)
				{
					b = Util.VectorToSegment(base.transform.position, _pathPoints[_currentPathIndex], _pathPoints[_currentPathIndex + 1]);
					num = b.magnitude;
					flag = (num < 0.5f);
				}
				if (!flag)
				{
					updatePath();
				}
				bool flag2 = _currentPathIndex >= _pathLength - 2 && _path.status == NavMeshPathStatus.PathPartial;
				if (_path.status != NavMeshPathStatus.PathInvalid && !_hasCheckedIfReachable)
				{
					if (_pathLength == 0 || Vector3.Distance(_pathPoints[_pathLength - 1], _positionToCheckIfReachable) >= 0.2f)
					{
						Message("OnPositionUnreachable", _positionToCheckIfReachable);
					}
					_hasCheckedIfReachable = true;
				}
				if (vector.magnitude >= 0.3f && !flag2)
				{
					if (_path.status == NavMeshPathStatus.PathInvalid || _pathLength == 0)
					{
						updatePath();
					}
					Vector3 vector4 = (_currentPathIndex + 1 >= _pathLength) ? _target : _pathPoints[_currentPathIndex + 1];
					if (!AIUtil.IsPositionOnNavMesh(vector4))
					{
						updatePath();
					}
					vector2 = vector4 - base.transform.position;
					vector2.y = 0f;
					float magnitude = vector2.magnitude;
					if (magnitude > float.Epsilon)
					{
						vector2 /= magnitude;
					}
					if (checkIncomingCollisions(vector2, _speed))
					{
						break;
					}
					if (magnitude < 0.2f && _currentPathIndex + 1 < _pathLength)
					{
						int currentPathIndex = _currentPathIndex;
						if (magnitude > 0.07f && _currentPathIndex + 2 < _pathLength)
						{
							if (Vector3.Dot(vector4 - base.transform.position, _pathPoints[_currentPathIndex + 2] - base.transform.position) <= 0.1f)
							{
								_currentPathIndex++;
							}
						}
						else
						{
							_currentPathIndex++;
						}
					}
					if (num > 0.12f)
					{
						vector2 = (vector2 + b).normalized;
					}
					if (Vector3.Dot(vector2, _direction) < 0.9f)
					{
						updateDirection(vector2, force: false);
					}
					move(vector2, _speed, noPath: false);
				}
				else if (vector.magnitude > 0.03f)
				{
					if (!checkIncomingCollisions(vector2, _speed))
					{
						if (vector.magnitude < 0.2f)
						{
							_motor.InputImmediateCoverSearch();
							base.transform.position = Util.Lerp(base.transform.position, _target, 6f);
						}
						else if (_motor.IsInCover)
						{
							move(vector2, 1f, noPath: false);
						}
						else
						{
							move(vector2, 0.5f, noPath: false);
						}
					}
				}
				else
				{
					_motor.transform.position = _target;
					_mode = Mode.none;
				}
				break;
			}
			case Mode.fromPosition:
				_pathLength = 0;
				if (checkIncomingCollisions(-vector2, _speed))
				{
					break;
				}
				vector2 = -vector2;
				if (canMoveInDirection(vector2))
				{
					_motor.InputMovement(new CharacterMovement(vector2, 1f));
					_isMoving = true;
				}
				else
				{
					if (_side == 0)
					{
						if (Random.Range(0, 10) < 5 && _motor.IsFreeToMove(vector3, 0.5f, 0.25f))
						{
							_side = 1;
						}
						else
						{
							_side = -1;
						}
					}
					if (!canMoveInDirection(vector3 * _side))
					{
						if (!_motor.IsFreeToMove(-vector3 * _side, 0.5f, 0.25f))
						{
							Message("OnMoveFromFail");
						}
						else
						{
							_side = -_side;
						}
					}
					move(vector3 * _side, 1f, noPath: true);
				}
				updateDirection(vector2, force: false);
				if (_isRunningAwayTemp)
				{
					_runningAwayFramesLeft--;
					if (_runningAwayFramesLeft <= 0)
					{
						ToStopMoving();
					}
				}
				break;
			case Mode.circle:
				_pathLength = 0;
				if (_futureCircleDirection != 0)
				{
					if (_circleWait > float.Epsilon)
					{
						_circleWait -= Time.deltaTime;
					}
					if (_circleWait < float.Epsilon)
					{
						_circleWait = 0f;
						_side = _futureCircleDirection;
						_futureCircleDirection = 0;
					}
				}
				if (_futureCircleDirection != 0)
				{
					break;
				}
				if (_side == 0)
				{
					if (Random.Range(0, 10) < 5 && canMoveInDirection(vector3))
					{
						_side = 1;
					}
					else
					{
						_side = -1;
					}
				}
				if (!canMoveInDirection(vector3 * _side))
				{
					if (!canMoveInDirection(-vector3 * _side))
					{
						Message("OnCircleFail");
					}
					else
					{
						_futureCircleDirection = -_side;
						_circleWait = CircleDelay;
					}
				}
				vector2 = vector3 * _side;
				if (!checkIncomingCollisions(vector2, _speed))
				{
					move(vector2, 1f, noPath: true);
					updateDirection(vector2, force: false);
				}
				break;
			}
			if (_isMoving && !_wasMoving)
			{
				Message("OnMoving");
			}
			else if (!_isMoving && _wasMoving)
			{
				Message("OnStopMoving");
			}
			_wasMoving = _isMoving;
		}

		private bool checkIncomingCollisions(Vector3 ownMovement, float speed)
		{
			int num = AIUtil.FindActors(base.transform.position, ObstructionRadius, _actor);
			float magnitude = ownMovement.magnitude;
			bool flag = magnitude > 0.25f;
			Vector3 lhs = ownMovement / magnitude;
			float num2 = 0f;
			Vector3 vector = Vector3.zero;
			Vector3 a = Vector3.zero;
			Vector3 a2 = Vector3.zero;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			for (int i = 0; i < num; i++)
			{
				Actor actor = AIUtil.Actors[i];
				if (actor.Side != _actor.Side && actor.IsAggressive && _actor.IsAggressive)
				{
					continue;
				}
				AIMovement aIMovement = (!_movements.ContainsKey(actor)) ? null : _movements[actor];
				bool flag5 = false;
				Vector3 a3;
				float num3;
				if (aIMovement != null && aIMovement._isAvoidingMover)
				{
					a3 = aIMovement._avoidDirection;
					num3 = 1f;
				}
				else
				{
					a3 = actor.Motor.MovementDirection;
					num3 = a3.magnitude;
					if (num3 < 0.1f)
					{
						Rigidbody body = actor.Body;
						if (body == null)
						{
							continue;
						}
						a3 = body.velocity;
						num3 = a3.magnitude;
						if (num3 < 0.1f)
						{
							if (!flag)
							{
								continue;
							}
							flag5 = true;
							a3 = -ownMovement;
							num3 = 1f;
						}
					}
				}
				Vector3 vector2 = a3 / num3;
				if (flag && Vector3.Dot(lhs, vector2) > -0.5f)
				{
					continue;
				}
				Vector3 normalized = (base.transform.position - actor.transform.position).normalized;
				float num4 = Vector3.Dot(vector2, normalized);
				if (!(num4 < 0.7f))
				{
					bool flag6 = (aIMovement == null || !aIMovement._isAvoidingMover) && !flag5;
					if (!flag4 || (flag3 && !flag5) || (flag6 && !flag2) || (flag6 && num4 > num2) || (!flag6 && !flag2 && num4 > num2))
					{
						flag4 = true;
						flag2 = flag6;
						flag3 = flag5;
						a2 = actor.transform.position;
						a = vector2;
						vector = normalized;
						num2 = num4;
					}
				}
			}
			if (flag4)
			{
				if (!flag2 && !flag3 && !flag && canMoveInDirection(vector))
				{
					return avoid(vector, speed);
				}
				Vector3 b = Util.FindClosestToPath(a2, a2 + a * 100f, base.transform.position);
				Vector3 a4 = base.transform.position - b;
				float magnitude2 = a4.magnitude;
				if (magnitude2 < 0.1f)
				{
					Vector3 vector3 = Vector3.Cross(vector, Vector3.up);
					Vector3 vector4 = -vector3;
					if (flag && flag3)
					{
						vector3 = (vector3 + ownMovement).normalized;
						vector4 = (vector4 + ownMovement).normalized;
					}
					if (canMoveInDirection(vector3))
					{
						return avoid(vector3, speed);
					}
					if (canMoveInDirection(vector4))
					{
						return avoid(vector4, speed);
					}
				}
				else
				{
					Vector3 vector5 = a4 / magnitude2;
					if (flag && flag3)
					{
						vector5 = (vector5 + ownMovement).normalized;
					}
					if (canMoveInDirection(vector5))
					{
						return avoid(vector5, speed);
					}
				}
				if (flag2 && !flag3 && !flag && canMoveInDirection(vector))
				{
					return avoid(vector, speed);
				}
			}
			return false;
		}

		private bool avoid(Vector3 direction, float speed)
		{
			_avoidingTimer = 0.15f;
			_isAvoidingMover = true;
			_avoidDirection = direction;
			_avoidSpeed = speed;
			move(direction, speed, noPath: true);
			return true;
		}

		private void move(Vector3 direction, float speed, bool noPath)
		{
			Vector3 vector = base.transform.position + Vector3.up * 0.5f;
			Vector3 vector2 = vector + direction;
			if (!Util.IsFree(base.gameObject, vector, direction, 0.5f, coverMeansFree: false, actorMeansFree: true))
			{
				if (noPath)
				{
					Vector3 vector3 = Vector3.Cross(direction, Vector3.up);
					if (Util.IsFree(base.gameObject, vector, vector3, 0.5f, coverMeansFree: false, actorMeansFree: true))
					{
						direction = vector3;
					}
					else if (Util.IsFree(base.gameObject, vector, -vector3, 0.5f, coverMeansFree: false, actorMeansFree: true))
					{
						direction = -vector3;
					}
				}
				else
				{
					updatePath();
				}
			}
			_motor.InputMovement(new CharacterMovement(direction, speed));
			_isMoving = true;
		}

		private void updateDirection(Vector3 value, bool force)
		{
			if (force || Vector3.Dot(_direction, value) < 0.95f)
			{
				_direction = value;
				Message("OnWalkDirection", _direction);
			}
		}

		private bool canMoveInDirection(Vector3 vector)
		{
			if (AIUtil.IsNavigationBlocked(base.transform.position, base.transform.position + vector))
			{
				return false;
			}
			return true;
		}

		private void moveTo(Vector3 destination, float speed)
		{
			_mode = Mode.toPosition;
			if (Vector3.Distance(_target, destination) > 0.3f)
			{
				_target = destination;
				updatePath();
			}
			_speed = speed;
		}

		private void moveFrom(Vector3 target, float speed)
		{
			_mode = Mode.fromPosition;
			_target = target;
			_speed = speed;
			_side = 0;
		}

		private void updatePath()
		{
			AIUtil.Path(ref _path, base.transform.position, _target);
			_pathLength = _path.GetCornersNonAlloc(_pathPoints);
			_currentPathIndex = 0;
			if (_pathLength > _pathPoints.Length)
			{
				_pathLength = _pathPoints.Length;
			}
			if (_pathLength > 1)
			{
				Vector3 a = _pathPoints[1] - _pathPoints[0];
				float magnitude = a.magnitude;
				if (magnitude > 0.3f)
				{
					updateDirection(a / magnitude, force: true);
				}
			}
			_hasCheckedIfReachable = false;
			_positionToCheckIfReachable = _target;
		}
	}
}
