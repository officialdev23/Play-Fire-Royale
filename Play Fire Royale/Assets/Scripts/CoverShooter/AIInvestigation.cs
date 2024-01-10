// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIInvestigation
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIInvestigation : AIBase
	{
		[Tooltip("Distance to the investigation position for it to be marked as investigated.")]
		public float VerifyDistance = 10f;

		[Tooltip("At which height the AI confirms the point as investigated.")]
		public float VerifyHeight = 0.3f;

		[Tooltip("Radius of an investigation point when it's close to a cover. AI tries to verify all of it is clear of enemies when investigating. Aiming is done at the central point so keep the radius small.")]
		[HideInInspector]
		public float VerifyRadius = 1f;

		[Tooltip("Field of view when checking an investigation position.")]
		public float FieldOfView = 90f;

		[Tooltip("Distance to a cover to maintain when approaching to see behind it.")]
		public float CoverOffset = 2f;

		[Tooltip("Cover search radius around an investigation point. Closest cover will be checked when investigating.")]
		[HideInInspector]
		public float CoverSearchDistance = 3f;

		private Actor _actor;

		private bool _isInvestigating;

		private Vector3 _positionToInvestigate;

		private Vector3 _positionAskedToInvestigate;

		private Cover _coverToInvestigate;

		private bool _hasReachedCoverLine;

		private Vector3 _approachPosition;

		private float _verifyDistance;

		private Vector3 _walkingTo;

		private bool _isWalkingTo;

		private NavMeshPath _path;

		private Vector3[] _corners = new Vector3[32];

		public void InvestigationCheck()
		{
			if (base.isActiveAndEnabled)
			{
				Message("InvestigationResponse");
			}
		}

		public void ToInvestigatePosition(Vector3 position)
		{
			_isInvestigating = true;
			_positionAskedToInvestigate = position;
			_positionToInvestigate = position;
			Util.GetClosestCover(position, CoverSearchDistance, ref _coverToInvestigate, ref _positionToInvestigate);
			_verifyDistance = Util.GetViewDistance(_positionToInvestigate, VerifyDistance, isAlerted: true);
			if (_coverToInvestigate == null)
			{
				_hasReachedCoverLine = false;
				if (base.isActiveAndEnabled)
				{
					walkTo(position);
					Message("OnInvestigationStart");
				}
				return;
			}
			Vector3 a = _positionToInvestigate - base.transform.position;
			_hasReachedCoverLine = (Vector3.Dot(_coverToInvestigate.Forward, a + _coverToInvestigate.Forward * 0.2f) > 0f);
			if (_hasReachedCoverLine)
			{
				if (base.isActiveAndEnabled)
				{
					walkTo(_positionToInvestigate);
					Message("OnInvestigationStart");
				}
				return;
			}
			Vector3 position2 = base.transform.position;
			if (AIUtil.GetClosestStandablePosition(ref position2))
			{
				Vector3 origin = _coverToInvestigate.LeftCorner(_coverToInvestigate.Bottom) - _coverToInvestigate.Forward * 1f;
				Vector3 origin2 = _coverToInvestigate.RightCorner(_coverToInvestigate.Bottom) - _coverToInvestigate.Forward * 1f;
				Vector3 position3 = _coverToInvestigate.LeftCorner(_coverToInvestigate.Bottom, CoverOffset) - _coverToInvestigate.Forward * 1f;
				Vector3 position4 = _coverToInvestigate.RightCorner(_coverToInvestigate.Bottom, CoverOffset) - _coverToInvestigate.Forward * 1f;
				Vector3 vector = position3;
				Vector3 vector2 = position4;
				bool flag = AIUtil.GetClosestStandablePosition(ref position3) && !AIUtil.IsNavigationBlocked(origin, position3);
				bool flag2 = AIUtil.GetClosestStandablePosition(ref position4) && !AIUtil.IsNavigationBlocked(origin2, position4);
				if (flag || flag2)
				{
					float num = 999999f;
					float num2 = 999999f;
					if (flag)
					{
						AIUtil.Path(ref _path, position2, position3);
						if (_path.status != NavMeshPathStatus.PathInvalid)
						{
							num = 0f;
							int cornersNonAlloc = _path.GetCornersNonAlloc(_corners);
							for (int i = 1; i < cornersNonAlloc; i++)
							{
								num += Vector3.Distance(_corners[i], _corners[i - 1]);
							}
						}
					}
					if (flag2)
					{
						AIUtil.Path(ref _path, position2, position4);
						if (_path.status != NavMeshPathStatus.PathInvalid)
						{
							num2 = 0f;
							int cornersNonAlloc2 = _path.GetCornersNonAlloc(_corners);
							for (int j = 1; j < cornersNonAlloc2; j++)
							{
								num2 += Vector3.Distance(_corners[j], _corners[j - 1]);
							}
						}
					}
					if (num < num2)
					{
						_approachPosition = position3;
					}
					else
					{
						_approachPosition = position4;
					}
				}
				else
				{
					_approachPosition = position;
				}
			}
			else
			{
				_approachPosition = position;
			}
			float num3 = Vector3.Distance(_approachPosition, _positionToInvestigate);
			if (num3 + VerifyRadius > _verifyDistance)
			{
				_approachPosition = _positionToInvestigate + Vector3.Normalize(_approachPosition - _positionToInvestigate) * (_verifyDistance + VerifyRadius - 0.1f);
			}
			if (base.isActiveAndEnabled)
			{
				walkTo(_approachPosition);
				Message("OnInvestigationStart");
			}
		}

		public void ToStopInvestigation()
		{
			_isWalkingTo = false;
			_isInvestigating = false;
			Message("OnInvestigationStop");
		}

		public void OnPositionUnreachable(Vector3 position)
		{
			if (_isWalkingTo && Vector3.Distance(_walkingTo, position) <= 0.2f)
			{
				_isWalkingTo = false;
				if (_isInvestigating)
				{
					done();
				}
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_path = new NavMeshPath();
		}

		private void Update()
		{
			if (!_isInvestigating)
			{
				return;
			}
			if (_coverToInvestigate != null)
			{
				if (!_hasReachedCoverLine && Vector3.Dot(_coverToInvestigate.Forward, _approachPosition - base.transform.position + _coverToInvestigate.Forward * 0.2f) > 0f)
				{
					_hasReachedCoverLine = true;
					walkTo(_positionToInvestigate);
				}
				if (verify(_positionToInvestigate) && verify(_positionToInvestigate + _coverToInvestigate.Right * VerifyRadius) && verify(_positionToInvestigate - _coverToInvestigate.Left * VerifyRadius))
				{
					done();
				}
			}
			else if (verify(_positionToInvestigate))
			{
				done();
			}
		}

		private bool verify(Vector3 position)
		{
			float num = Vector3.Distance(base.transform.position, position);
			if (num <= VerifyRadius + 0.1f || (num <= _verifyDistance + 0.1f && _verifyDistance <= VerifyRadius))
			{
				return true;
			}
			return AIUtil.IsInSight(_actor, position + Vector3.up * VerifyHeight, _verifyDistance, FieldOfView);
		}

		private void walkTo(Vector3 position)
		{
			_isWalkingTo = true;
			_walkingTo = position;
			Message("ToWalkTo", position);
		}

		private void done()
		{
			_isWalkingTo = false;
			Message("ToMarkPointInspected", _positionToInvestigate);
			if (Vector3.Distance(_positionAskedToInvestigate, _positionToInvestigate) > float.Epsilon)
			{
				Message("OnPointInvestigated", _positionAskedToInvestigate);
			}
			Message("OnPointInvestigated", _positionToInvestigate);
		}
	}
}
