// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CivilianBrain
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	public class CivilianBrain : BaseBrain, IAlertListener
	{
		[Tooltip("The civilian is only alarmed by enemies with weapons in hands.")]
		public bool OnlyAlarmedByWeapons = true;

		private CivilianState _previousState;

		private CivilianState _state;

		private CivilianState _futureSetState;

		private float _stateTime;

		private bool _wasAlerted;

		private bool _wasAlarmed;

		private bool _wasThreatArmed;

		private bool _waypointCheck;

		public bool IsAlerted => _state != 0 && _state != CivilianState.walkAround;

		public bool IsScared => _state == CivilianState.flee;

		public CivilianState State => _state;

		public override void ToForget()
		{
			base.ToForget();
			setState(CivilianState.walkAround);
		}

		public void ToBecomeScared()
		{
			setState(CivilianState.flee);
		}

		public void ToMakeCall()
		{
			setState(CivilianState.call);
		}

		public void OnCallMade()
		{
			if (_state == CivilianState.call)
			{
				setState(_previousState);
			}
		}

		public void OnHit(Hit hit)
		{
			if (!(hit.Attacker != null))
			{
				return;
			}
			Actor component = hit.Attacker.GetComponent<Actor>();
			if (component != null && component.Side != base.Actor.Side)
			{
				if (base.Threat == component && base.CanSeeTheThreat)
				{
					SetThreat(component, component.transform.position, component.Cover);
				}
				else
				{
					SetUnseenThreat( true,  true, component, component.transform.position, component.Cover);
				}
			}
		}

		public void OnAlert(ref GeneratedAlert alert)
		{
			if (alert.Actor != null && alert.Actor.Side != base.Actor.Side)
			{
				if (base.Threat == null)
				{
					SetUnseenThreat( true, alert.IsDirect, alert.Actor, alert.Position, null);
				}
				else if (alert.Actor == base.Threat && !base.CanSeeTheThreat)
				{
					SetUnseenThreat( true, alert.IsDirect, alert.Actor, alert.Position, base.Threat.Cover);
				}
				else if (Time.timeSinceLevelLoad - base.LastSeenThreatTime > 3f)
				{
					SetUnseenThreat( true, alert.IsDirect, alert.Actor, alert.Position, (!alert.IsDirect) ? null : alert.Actor.Cover);
				}
				if (!alert.IsHostile && !IsScared && !IsAlerted)
				{
					setState(CivilianState.follow);
				}
			}
		}

		public void OnSeeActor(Actor actor)
		{
			if (actor.Side != base.Actor.Side && (base.Threat == null || base.Threat == actor || Time.timeSinceLevelLoad - base.LastSeenThreatTime > 3f))
			{
				SetThreat(actor, actor.transform.position, actor.Cover);
				if (!IsAlerted && !IsScared)
				{
					setState(CivilianState.follow);
				}
			}
		}

		public void OnUnseeActor(Actor actor)
		{
			if (base.Threat == actor)
			{
				UnseeThreat();
			}
		}

		public void OnWaypointsFound()
		{
			_waypointCheck = true;
		}

		protected override void Awake()
		{
			base.Awake();
			base.Actor.IsAggressive = false;
		}

		private void Update()
		{
			if (base.Actor == null || !base.Actor.IsAlive)
			{
				return;
			}
			_stateTime += Time.deltaTime;
			if (base.Threat != null && base.CanSeeTheThreat)
			{
				SetThreat(base.Threat, base.Threat.transform.position, base.Threat.Cover);
			}
			if (_futureSetState != 0)
			{
				CivilianState futureSetState = _futureSetState;
				_futureSetState = CivilianState.idle;
				setState(futureSetState);
			}
			switch (_state)
			{
			case CivilianState.walkAround:
				break;
			case CivilianState.flee:
				break;
			case CivilianState.idle:
				setState(CivilianState.walkAround);
				break;
			case CivilianState.follow:
				if (!_wasThreatArmed)
				{
					_wasThreatArmed = base.Threat.IsArmed;
					if (_wasThreatArmed)
					{
						alarm();
					}
				}
				break;
			}
		}

		private void setState(CivilianState state, bool forceRestart = false)
		{
			if (_state != state || forceRestart)
			{
				if (_state != state)
				{
					_previousState = _state;
				}
				closeState(_state, state);
				_stateTime = 0f;
				_state = state;
				openState(_state, _previousState);
				if (!_wasAlerted && IsAlerted)
				{
					_wasAlerted = true;
					Message("OnAlerted");
				}
			}
		}

		private void openState(CivilianState state, CivilianState previous)
		{
			switch (state)
			{
			case CivilianState.idle:
				if (Vector3.Distance(base.transform.position, base.StartingLocation) > 0.25f)
				{
					Message("ToWalkTo", base.StartingLocation);
					Message("ToFaceWalkDirection");
				}
				break;
			case CivilianState.walkAround:
				if (base.Actor.Cover != null)
				{
					Message("ToLeaveCover");
				}
				_waypointCheck = false;
				Message("ToStartVisitingWaypoints");
				if (!_waypointCheck)
				{
					setState(CivilianState.idle);
				}
				break;
			case CivilianState.follow:
				Message("ToStartFollowing", base.LastKnownThreatPosition);
				Message("ToTakePhone");
				Message("ToStartFilming");
				_wasThreatArmed = base.Threat.IsArmed;
				if (_wasThreatArmed || !OnlyAlarmedByWeapons)
				{
					alarm();
				}
				break;
			case CivilianState.call:
				Message("ToTakePhone");
				Message("ToCall");
				break;
			case CivilianState.flee:
				Message("ToStartFleeing", base.LastKnownThreatPosition);
				alarm();
				break;
			}
		}

		private void closeState(CivilianState state, CivilianState next)
		{
			switch (state)
			{
			case CivilianState.walkAround:
				Message("ToStopVisitingWaypoints");
				break;
			case CivilianState.follow:
				Message("ToStopFollowing");
				Message("ToStopFilming");
				Message("ToHidePhone");
				break;
			case CivilianState.call:
				if (next != CivilianState.follow)
				{
					Message("ToHidePhone");
				}
				break;
			case CivilianState.flee:
				Message("ToStopFleeing");
				break;
			}
		}

		private void alarm()
		{
			if (!_wasAlarmed)
			{
				_wasAlarmed = true;
				Message("OnAlarmed");
			}
		}
	}
}
