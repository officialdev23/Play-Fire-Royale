// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFlee
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIFlee : AIBase
	{
		[Tooltip("Distance to the enemy at which the AI changes their flee direction.")]
		public float AvoidDistance = 10f;

		private bool _isFleeing;

		private bool _wasTooClose;

		private Vector3 _threatPosition;

		private Vector3 _targetPosition;

		private FleeZone _targetBlock;

		private NavMeshPath _path;

		private Vector3[] _corners = new Vector3[32];

		private FleeZone _zone;

		private bool _wasRegistered;

		public void OnThreatPosition(Vector3 position)
		{
			if (_isFleeing)
			{
				_threatPosition = position;
			}
		}

		private void OnTriggerEnter(Collider other)
		{
			FleeZone component = other.GetComponent<FleeZone>();
			if (component != null)
			{
				if (_zone != null)
				{
					_zone.Unregister(base.gameObject);
				}
				_zone = component;
				if (_isFleeing)
				{
					_zone.Register(base.gameObject);
					_wasRegistered = true;
				}
			}
		}

		private void OnTriggerExit(Collider other)
		{
			FleeZone component = other.GetComponent<FleeZone>();
			if (component != null && component == _zone)
			{
				_zone.Unregister(base.gameObject);
				_wasRegistered = false;
				_zone = null;
			}
		}

		public void ToStartFleeing(Vector3 threatPosition)
		{
			_isFleeing = true;
			_threatPosition = threatPosition;
			_wasTooClose = (Vector3.Distance(_threatPosition, base.transform.position) < AvoidDistance);
			if (base.isActiveAndEnabled)
			{
				findNewFleePosition(_wasTooClose);
			}
		}

		public void ToStopFleeing()
		{
			if (_isFleeing && base.isActiveAndEnabled)
			{
				Message("ToStopMoving");
			}
			_isFleeing = false;
			_targetBlock = null;
		}

		private void Awake()
		{
			_path = new NavMeshPath();
		}

		private void Update()
		{
			if (!_isFleeing)
			{
				return;
			}
			if (_isFleeing && !_wasRegistered)
			{
				if (_zone != null)
				{
					_zone.Register(base.gameObject);
					_wasRegistered = true;
				}
			}
			else if (!_isFleeing && _wasRegistered)
			{
				if (_zone != null)
				{
					_zone.Unregister(base.gameObject);
				}
				_wasRegistered = false;
			}
			bool flag = Vector3.Distance(_threatPosition, base.transform.position) < AvoidDistance;
			if ((flag && !_wasTooClose) || _targetBlock == null || Vector3.Distance(_threatPosition, _targetPosition) < AvoidDistance)
			{
				findNewFleePosition(flag);
			}
			_wasTooClose = flag;
		}

		private void findNewFleePosition(bool isAlreadyTooClose)
		{
			Vector3 vector = base.transform.position;
			float num = -10f;
			Vector3 rhs = base.transform.position - _threatPosition;
			rhs.y = 0f;
			rhs.Normalize();
			FleeZone targetBlock = null;
			for (int i = 0; i < Zone<FleeZone>.Count; i++)
			{
				FleeZone fleeZone = Zone<FleeZone>.Get(i);
				Vector3 position = fleeZone.transform.position;
				position.y = fleeZone.Bottom;
				if (Vector3.Distance(position, _threatPosition) < AvoidDistance || fleeZone == _targetBlock)
				{
					continue;
				}
				float num2 = -1f;
				if (!NavMesh.CalculatePath(base.transform.position, position, 1, _path))
				{
					continue;
				}
				int cornersNonAlloc = _path.GetCornersNonAlloc(_corners);
				if (cornersNonAlloc < 1)
				{
					continue;
				}
				if (!isAlreadyTooClose)
				{
					bool flag = true;
					for (int j = 0; j < cornersNonAlloc; j++)
					{
						Vector3 a = (j != 0) ? _corners[j - 1] : base.transform.position;
						Vector3 b = _corners[j];
						Vector3 a2 = Util.FindClosestToPath(a, b, _threatPosition);
						if (Vector3.Distance(a2, _threatPosition) < AvoidDistance)
						{
							flag = false;
							break;
						}
					}
					if (!flag)
					{
						continue;
					}
				}
				Vector3 a3 = _corners[0];
				if (cornersNonAlloc > 1)
				{
					a3 = _corners[1];
				}
				Vector3 lhs = a3 - base.transform.position;
				lhs.y = 0f;
				lhs.Normalize();
				num2 = Vector3.Dot(lhs, rhs) * Vector3.Distance(position, base.transform.position);
				if (num2 > num)
				{
					num = num2;
					vector = position + ((0f - fleeZone.Width) * 0.5f + Random.Range(0f, fleeZone.Width)) * fleeZone.transform.right + ((0f - fleeZone.Depth) * 0.5f + Random.Range(0f, fleeZone.Depth)) * fleeZone.transform.forward;
					targetBlock = fleeZone;
				}
			}
			_targetBlock = targetBlock;
			_targetPosition = vector;
			Message("ToSprintTo", vector);
			Message("ToFaceWalkDirection", vector);
		}
	}
}
