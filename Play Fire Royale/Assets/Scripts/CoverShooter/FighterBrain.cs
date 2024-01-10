// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.FighterBrain
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	public class FighterBrain : BaseBrain, IAlertListener, ICharacterHealthListener
	{
		[Tooltip("Enemy distance to trigger slow retreat.")]
		public float AvoidDistance = 4f;

		[Tooltip("AI will avoid standing to allies closer than this distance.")]
		public float AllySpacing = 1.2f;

		[Tooltip("Duration in seconds to stand fighting before changing state.")]
		public float StandDuration = 2f;

		[Tooltip("Duration in seconds to fight circling the enemy before changing state.")]
		public float CircleDuration = 2f;

		[Tooltip("Time in seconds for the AI to wait before switching to a better cover.")]
		public float CoverSwitchWait = 10f;

		[Tooltip("Distance at which the AI guesses the position on hearing instead of knowing it precisely.")]
		public float GuessDistance = 30f;

		[Tooltip("Chance the AI will take cover immediately after learning of existance of an enemy.")]
		[Range(0f, 1f)]
		public float TakeCoverImmediatelyChance;

		[Tooltip("AI won't go to cover if it is closer to the enemy than this value. Only used when the enemy has been known for awhile.")]
		public float DistanceToGoToCoverFromStandOrCircle = 6f;

		[Tooltip("Should the AI attack threats immedietaly on seeing them.")]
		public bool ImmediateThreatReaction = true;

		[Tooltip("Should the AI switch to attacking enemies that deal damage to the AI.")]
		public bool AttackAggressors = true;

		[Tooltip("Settings for AI startup.")]
		public AIStartSettings Start = AIStartSettings.Default();

		[Tooltip("Speed of the motor during various AI states.")]
		public FighterSpeedSettings Speed = FighterSpeedSettings.Default();

		[Tooltip("How accurately the AI guesses the position of an enemy.")]
		public AIApproximationSettings Approximation = new AIApproximationSettings(0f, 10f, 5f, 30f);

		[Tooltip("Settings for AI retreats.")]
		public FighterRetreatSettings Retreat = FighterRetreatSettings.Default();

		[Tooltip("Settings for how long the AI waits before investigating.")]
		public FighterInvestigationWaitSettings Investigation = FighterInvestigationWaitSettings.Default();

		[Tooltip("Settings for how the fighter avoids other grenades.")]
		public FighterGrenadeAvoidSettings GrenadeAvoidance = FighterGrenadeAvoidSettings.Default();

		[Tooltip("Settings for AI fighting and aiming.")]
		public AIGrenadeSettings Grenades = AIGrenadeSettings.Default();

		[Tooltip("Should a debug line be drawn towards the current threat.")]
		public bool DebugThreat;

		private CharacterMotor _motor;

		private CharacterInventory _inventory;

		private CharacterHealth _health;

		private AISight _sight;

		private bool _isInAggressiveMode;

		private int _thrownGrenadeCount;

		private HashSet<BaseBrain> _friends = new HashSet<BaseBrain>();

		private HashSet<Actor> _friendsThatCanSeeMe = new HashSet<Actor>();

		private HashSet<Actor> _visibleCivilians = new HashSet<Actor>();

		private FighterState _previousState;

		private FighterState _state;

		private float _stateTime;

		private Vector3 _maintainPosition;

		private bool _maintainPositionIndefinitely;

		private float _maintainDuration;

		private bool _hasReachedMaintainPosition;

		private float _maintainPositionReachTime;

		private AIBaseRegrouper _regrouper;

		private Vector3 _defensePosition;

		private bool _failedToAvoidInThisState;

		private Vector3 _avoidedGrenadePosition;

		private float _avoidedGrenadeRange;

		private float _grenadeAvoidReaction;

		private float _grenadeTimer;

		private float _grenadeCheckTimer;

		private bool _hasThrowFirstGrenade;

		private Vector3[] _grenadePath = new Vector3[128];

		private FighterState _futureSetState;

		private bool _hasFailedToFindCover;

		private bool _hasSucceededToFindCover;

		private bool _isLookingForCover;

		private bool _wasAlerted;

		private bool _wasAlarmed;

		private bool _assaultCheck;

		private bool _callCheck;

		private bool _investigationCheck;

		private bool _searchCheck;

		private bool _waypointCheck;

		private bool _isInDarkness;

		private Actor _lockedTarget;

		private bool _isCombatProcess;

		private List<Actor> _visibleActors = new List<Actor>();

		private KeepCloseTo _keepCloseTo;

		private Vector3 _moveTarget;

		private bool _hasMoveTarget;

		private bool _hadMoveTargetBeforeAllySpacing;

		private Vector3 _moveTargetBeforeAllySpacing;

		private bool _hasOpenFire;

		private bool _hasCheckedIfTheLastKnownPositionIsNearCover;

		private NavMeshPath _reachablePath;

		private bool _hasCheckedReachabilityAndFailed;

		private float _reachabilityCheckTime;

		private float _invisibleTime;

		public bool IsAlerted
		{
			get
			{
				int result;
				switch (State)
				{
				case FighterState.search:
					result = ((base.Threat != null) ? 1 : 0);
					break;
				default:
					result = 1;
					break;
				case FighterState.none:
				case FighterState.idle:
				case FighterState.idleButAlerted:
				case FighterState.patrol:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		public FighterState State
		{
			get
			{
				if (_futureSetState != 0)
				{
					return _futureSetState;
				}
				return _state;
			}
		}

		public float InvestigationWait => (!base.ThreatCover) ? Investigation.WaitForUncovered : Investigation.WaitForCovered;

		public bool IsInAggressiveMode => _isInAggressiveMode;

		public Actor LockedThreat => _lockedTarget;

		private bool canLeavePosition => State != FighterState.maintainPosition || !_maintainPositionIndefinitely;

		private bool canChangeTarget => base.Threat == null || !base.Threat.IsAlive || base.Threat != _lockedTarget;

		private bool canSetThreat => _isInAggressiveMode || ImmediateThreatReaction;

		public void ToOpenFire()
		{
			_hasOpenFire = true;
		}

		public void ToCloseFire()
		{
			_hasOpenFire = false;
		}

		public void ToSprintTo(Vector3 position)
		{
			_moveTarget = position;
			_hasMoveTarget = true;
			if (_hadMoveTargetBeforeAllySpacing)
			{
				_moveTargetBeforeAllySpacing = position;
			}
		}

		public void ToRunTo(Vector3 position)
		{
			_moveTarget = position;
			_hasMoveTarget = true;
			if (_hadMoveTargetBeforeAllySpacing)
			{
				_moveTargetBeforeAllySpacing = position;
			}
		}

		public void ToWalkTo(Vector3 position)
		{
			_moveTarget = position;
			_hasMoveTarget = true;
			if (_hadMoveTargetBeforeAllySpacing)
			{
				_moveTargetBeforeAllySpacing = position;
			}
		}

		public void ToStopMoving()
		{
			_hasMoveTarget = false;
			_hadMoveTargetBeforeAllySpacing = false;
		}

		public void ToCircle(Vector3 threat)
		{
			_hasMoveTarget = false;
		}

		public void ToWalkInDirection(Vector3 vector)
		{
			_hasMoveTarget = false;
		}

		public void ToRunInDirection(Vector3 vector)
		{
			_hasMoveTarget = false;
		}

		public void ToSprintInDirection(Vector3 vector)
		{
			_hasMoveTarget = false;
		}

		public void ToWalkFrom(Vector3 target)
		{
			_hasMoveTarget = false;
		}

		public void ToRunFrom(Vector3 target)
		{
			_hasMoveTarget = false;
		}

		public void ToSprintFrom(Vector3 target)
		{
			_hasMoveTarget = false;
		}

		public void ToKeepCloseTo(KeepCloseTo value)
		{
			_keepCloseTo.Distance = value.Distance;
			if (State != FighterState.avoidGrenade && Vector3.Distance(base.transform.position, value.Position) > value.Distance && (!_hasMoveTarget || Vector3.Distance(_moveTarget, value.Position) > value.Distance))
			{
				_keepCloseTo.Position = value.Position;
				setState(FighterState.keepCloseTo, forceRestart: true);
			}
		}

		public void SetIdleAlertedState()
		{
			setState(FighterState.idleButAlerted);
		}

		public void ToAttack(Actor target)
		{
			_lockedTarget = target;
			setSeenThreat(target, target.transform.position, target.Cover);
			if (State == FighterState.maintainPosition)
			{
				takeCoverOrAssault();
			}
		}

		public void ToEnterProcess(bool isFighting)
		{
			_isCombatProcess = isFighting;
			setState(FighterState.process, forceRestart: true);
		}

		public void ToExitProcess()
		{
			if (State == FighterState.process)
			{
				setState(FighterState.idleButAlerted, forceRestart: false, allowCancelProcess: true);
			}
		}

		public void ToExitProcessAndMaintainPosition()
		{
			if (State == FighterState.process)
			{
				if (_previousState == FighterState.maintainPosition)
				{
					setState(_previousState, forceRestart: false, allowCancelProcess: true);
				}
				else
				{
					setState(FighterState.idleButAlerted, forceRestart: false, allowCancelProcess: true);
				}
			}
		}

		public void ToSetThreat(Threat threat)
		{
			_lockedTarget = threat.Actor;
			setSeenThreat(threat.Actor, threat.Position, null);
		}

		public void ToHoldPosition(Vector3 position)
		{
			_maintainPosition = position;
			_maintainPositionIndefinitely = true;
			setState(FighterState.maintainPosition, forceRestart: true);
		}

		public void ToStopActions()
		{
			RemoveThreat();
			setState(FighterState.idleButAlerted);
		}

		public override void ToForget()
		{
			base.ToForget();
			setState(FighterState.patrol);
		}

		public void ToBecomeScared()
		{
			setState(FighterState.flee);
		}

		public void ToMakeCall()
		{
			setState(FighterState.call);
		}

		public void ToFindCover()
		{
			setState(FighterState.takeCover, forceRestart: true);
		}

		public void ToFindDefenseCover(Vector3 position)
		{
			_defensePosition = position;
			setState(FighterState.takeDefenseCover, forceRestart: true);
		}

		public void ToRegroupAround(AIBaseRegrouper regrouper)
		{
			_regrouper = regrouper;
			setState(FighterState.takeCover, forceRestart: true);
		}

		public void ToFindAndMaintainPosition(AIBaseRegrouper regrouper)
		{
			_regrouper = regrouper;
			_maintainDuration = regrouper.UncoveredDuration;
			AIMovement component = regrouper.GetComponent<AIMovement>();
			Vector3 a = regrouper.transform.position;
			if (component != null)
			{
				a = component.Destination;
			}
			int num = 0;
			Vector3 position;
			while (true)
			{
				if (num < 6)
				{
					float d = Random.Range(1f, regrouper.Radius);
					float angle = Random.Range(0f, 360f);
					position = a + Util.HorizontalVector(angle) * d;
					if (AIUtil.GetClosestStandablePosition(ref position) && !regrouper.IsPositionTaken(position))
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			regrouper.TakePosition(position);
			_maintainPosition = position;
			_maintainPositionIndefinitely = false;
			setState(FighterState.maintainPosition, forceRestart: true);
		}

		public void AssaultResponse()
		{
			_assaultCheck = true;
		}

		public void CallResponse()
		{
			_callCheck = true;
		}

		public void InvestigationResponse()
		{
			_investigationCheck = true;
		}

		public void SearchResponse()
		{
			_searchCheck = true;
		}

		private bool tryAssault()
		{
			_assaultCheck = false;
			Message("AssaultCheck", base.LastKnownThreatPosition);
			return _assaultCheck;
		}

		private bool tryInvestigate()
		{
			_investigationCheck = false;
			Message("InvestigationCheck");
			return _investigationCheck;
		}

		private bool trySearch()
		{
			_searchCheck = false;
			Message("SearchCheck");
			return _searchCheck;
		}

		public void OnFinishSearch()
		{
			ToForget();
		}

		public void OnResurrect()
		{
			setState(FighterState.idleButAlerted, forceRestart: true);
		}

		public void OnDead()
		{
		}

		public void OnAssaultStop()
		{
			if (State == FighterState.assault)
			{
				setState(FighterState.circle);
			}
		}

		public void OnSeeDeath(Actor actor)
		{
			if (_visibleActors.Contains(actor))
			{
				_visibleActors.Remove(actor);
			}
			if (actor != base.Threat)
			{
				return;
			}
			RemoveThreat();
			float num = 0f;
			Actor actor2 = null;
			for (int i = 0; i < _visibleActors.Count; i++)
			{
				Actor actor3 = _visibleActors[i];
				if (actor3.Side != base.Actor.Side && actor3.IsAlive)
				{
					float num2 = Vector3.Distance(actor3.transform.position, base.transform.position);
					if (num2 < num || actor2 == null)
					{
						actor2 = actor3;
						num = num2;
					}
				}
			}
			if (actor2 != null)
			{
				setSeenThreat(actor2, actor2.transform.position, actor2.Cover);
			}
			else if (canLeavePosition)
			{
				if (tryInvestigate())
				{
					setState(FighterState.investigate);
				}
				else if (trySearch())
				{
					setState(FighterState.search);
				}
				else
				{
					fightOrRunAway();
				}
			}
		}

		public void OnWaypointsFound()
		{
			_waypointCheck = true;
			if (State == FighterState.patrol && _isInDarkness)
			{
				Message("ToLight");
			}
		}

		public void OnSpawn(Actor caller)
		{
			BaseBrain baseBrain = (!(caller != null)) ? null : caller.GetComponent<BaseBrain>();
			if (baseBrain != null)
			{
				setThreat( false,false,  false,  true, baseBrain.Threat, baseBrain.LastKnownThreatPosition, baseBrain.ThreatCover, baseBrain.LastSeenThreatTime);
			}
			else if (caller != null)
			{
				setThreat( false,false,  false,  false, null, caller.transform.position, null, Time.timeSinceLevelLoad);
			}
			else if (trySearch())
			{
				setState(FighterState.search);
			}
			else
			{
				setState(FighterState.patrol);
			}
		}

		public void OnNeedLight()
		{
			_isInDarkness = true;
			if (State == FighterState.patrol || State == FighterState.investigate || State == FighterState.search)
			{
				Message("ToLight");
			}
			else
			{
				Message("ToTurnOnLight");
			}
		}

		public void OnDontNeedLight()
		{
			_isInDarkness = false;
			if (State == FighterState.patrol || State == FighterState.investigate || State == FighterState.search)
			{
				Message("ToHideFlashlight");
			}
			else
			{
				Message("ToUnlight");
			}
		}

		public void OnCallMade()
		{
			if (State == FighterState.call)
			{
				setState(_previousState);
			}
		}

		public void OnHit(Hit hit)
		{
			if (hit.Attacker != null && canSetThreat && (base.Threat == null || !base.Threat.IsAlive || AttackAggressors))
			{
				Actor component = hit.Attacker.GetComponent<Actor>();
				if (component != null && component.Side != base.Actor.Side && canChangeTarget)
				{
					if (_visibleActors.Contains(component) || Vector3.Distance(component.transform.position, base.transform.position) <= GuessDistance)
					{
						setSeenThreat(component, component.transform.position, component.Cover);
					}
					else
					{
						guessThreat(component, component.transform.position,true);
					}
				}
			}
			if (_health != null && _health.Health <= Retreat.Health + float.Epsilon && State != FighterState.flee)
			{
				if ((base.Actor.Cover == null && canLeavePosition) || base.Threat == null || !base.Threat.IsAlive)
				{
					setState(FighterState.retreatToCover);
				}
				else if (_state == FighterState.hideInCover && _stateTime > 0.5f)
				{
					setState(FighterState.fightInCover);
				}
				else if (_state == FighterState.fightInCover && _stateTime > 0.5f)
				{
					setState(FighterState.hideInCover);
				}
			}
			foreach (BaseBrain friend in _friends)
			{
				friend.Message("OnFriendHit", base.Actor);
			}
		}

		public void OnFriendHit(Actor friend)
		{
			if (!canSetThreat || (!(base.Threat == null) && base.Threat.IsAlive && !AttackAggressors))
			{
				return;
			}
			FighterBrain component = friend.GetComponent<FighterBrain>();
			if (!(component != null))
			{
				return;
			}
			Actor threat = component.Threat;
			if (threat != null && threat.Side != base.Actor.Side && canChangeTarget)
			{
				if (_visibleActors.Contains(threat))
				{
					setSeenThreat(threat, threat.transform.position, threat.Cover);
				}
				else if (Vector3.Distance(threat.transform.position, base.transform.position) <= GuessDistance)
				{
					setUnseenThreat( false,  true, component.CanSeeTheThreat, threat, threat.transform.position, threat.Cover);
				}
				else
				{
					guessThreat(threat, threat.transform.position,false);
				}
			}
		}

		public void OnFinishTakeCover()
		{
			switch (State)
			{
			case FighterState.takeCover:
			case FighterState.takeDefenseCover:
			case FighterState.switchCover:
				if (base.Threat != null && base.Threat.IsAlive)
				{
					setState(FighterState.fightInCover);
				}
				else
				{
					setState(FighterState.hideInCover);
				}
				break;
			case FighterState.retreatToCover:
				setState(FighterState.hideInCover);
				break;
			}
		}

		public void OnAlert(ref GeneratedAlert alert)
		{
			if (!canChangeTarget || !(alert.Actor != null) || !(alert.Actor.gameObject != base.gameObject))
			{
				return;
			}
			if (alert.Actor.Side != base.Actor.Side)
			{
				if (alert.Actor.IsAlive && (base.Threat == null || !base.Threat.IsAlive || (alert.Actor == base.Threat && !base.CanSeeTheThreat && alert.IsDirect) || (InvestigationWait < base.ThreatAge && !base.CanSeeTheThreat)))
				{
					if (Vector3.Distance(alert.Position, base.transform.position) >= GuessDistance)
					{
						guessThreat(alert.Actor, alert.Position,true);
					}
					else
					{
						setUnseenThreat( true,  false,  false, alert.Actor, alert.Position, null);
					}
				}
			}
			else
			{
				if (!(base.Threat == null) && base.Threat.IsAlive && !(InvestigationWait < base.ThreatAge))
				{
					return;
				}
				BaseBrain component = alert.Actor.GetComponent<BaseBrain>();
				if (component != null)
				{
					if (component.Threat != null && component.CanSeeTheThreat && component.Threat.IsAlive)
					{
						setUnseenThreat( false,  false,  true, component.Threat, alert.Position, null);
					}
				}
				else if (alert.IsHostile)
				{
					setUnseenThreat( false,  false,  false, null, alert.Position, null);
				}
			}
		}

		public void OnFoundFriend(Actor friend)
		{
			FighterBrain component = friend.GetComponent<FighterBrain>();
			if (!(component != null) || _friends.Contains(component))
			{
				return;
			}
			_friends.Add(component);
			if (component.Threat != null)
			{
				if (component.HasSeenTheEnemy && component.ThreatAge < component.InvestigationWait)
				{
					Message("OnFriendFoundEnemy", friend);
				}
				else
				{
					Message("OnFriendKnowsEnemy", friend);
				}
			}
		}

		public void OnLostFriend(Actor friend)
		{
			BaseBrain component = friend.GetComponent<BaseBrain>();
			if (component != null && _friends.Contains(component))
			{
				_friends.Remove(component);
			}
		}

		public void OnCivilianAlerted(Actor actor)
		{
			if ((base.Threat == null || !base.Threat.IsAlive) && canSetThreat)
			{
				BaseBrain component = actor.GetComponent<BaseBrain>();
				if (component != null)
				{
					setThreat( false,false,  false,  false, component.Threat, actor.transform.position, null, Time.timeSinceLevelLoad);
				}
			}
		}

		public void OnFriendKnowsEnemy(Actor friend)
		{
			if (!(friend == null) && friend.Side == base.Actor.Side && (!(base.Threat != null) || base.Threat.IsAlive) && canSetThreat)
			{
				FighterBrain component = friend.GetComponent<FighterBrain>();
				if (!(component == null) && component.Threat != base.Threat && component.Threat != base.ForgottenThreat)
				{
					setThreat( false,false, component.IsActualThreatPosition, component.IsActualThreatPosition, component.Threat, component.LastKnownThreatPosition, component.ThreatCover, component.LastSeenThreatTime);
				}
			}
		}

		public void OnFriendFoundEnemy(Actor friend)
		{
			if (friend == null || friend.Side != base.Actor.Side)
			{
				return;
			}
			FighterBrain component = friend.GetComponent<FighterBrain>();
			if (!(component == null) && component.HasSeenTheEnemy && component.IsActualThreatPosition && (!(base.Threat != null) || !base.Threat.IsAlive || !base.CanSeeTheThreat) && canSetThreat)
			{
				bool flag = false;
				if (base.Threat == null || !base.Threat.IsAlive)
				{
					flag = true;
				}
				else if (!base.HasSeenTheEnemy)
				{
					flag = (component.LastSeenThreatTime > base.LastSeenThreatTime + 0.1f);
				}
				else if (!base.IsActualThreatPosition)
				{
					flag = (component.LastSeenThreatTime > base.LastSeenThreatTime + 0.1f);
				}
				else if (InvestigationWait < base.ThreatAge && component.InvestigationWait > component.ThreatAge)
				{
					flag = true;
				}
				if (flag)
				{
					setThreat( false,false, component.IsActualThreatPosition, component.IsActualThreatPosition, component.Threat, component.LastKnownThreatPosition, component.ThreatCover, component.LastSeenThreatTime);
				}
			}
		}

		public void OnSeenByFriend(Actor friend)
		{
			if (!_friendsThatCanSeeMe.Contains(friend))
			{
				_friendsThatCanSeeMe.Add(friend);
			}
		}

		public void OnUnseenByFriend(Actor friend)
		{
			if (_friendsThatCanSeeMe.Contains(friend))
			{
				_friendsThatCanSeeMe.Remove(friend);
			}
		}

		public void OnSeeActor(Actor actor)
		{
			_visibleActors.Add(actor);
			if (actor.Side == base.Actor.Side)
			{
				if (actor.IsAggressive)
				{
					actor.SendMessage("OnSeenByFriend", base.Actor, SendMessageOptions.DontRequireReceiver);
				}
				else
				{
					_visibleCivilians.Add(actor);
				}
			}
			else if (canChangeTarget && canSetThreat && (base.Threat == null || !base.Threat.IsAlive || InvestigationWait < base.ThreatAge || base.Threat == actor))
			{
				setSeenThreat(actor, actor.transform.position, actor.Cover);
			}
		}

		public void OnUnseeActor(Actor actor)
		{
			_visibleActors.Remove(actor);
			if (actor.Side == base.Actor.Side)
			{
				if (actor.IsAggressive)
				{
					actor.SendMessage("OnUnseenByFriend", base.Actor, SendMessageOptions.DontRequireReceiver);
				}
				else
				{
					_visibleCivilians.Remove(actor);
				}
			}
			else
			{
				if (!(base.Threat == actor))
				{
					return;
				}
				UnseeThreat();
				if (State == FighterState.standAndFight && canLeavePosition)
				{
					if (base.ThreatCover == null && tryInvestigate())
					{
						setState(FighterState.investigate);
					}
					else
					{
						takeCoverOrAssault();
					}
				}
			}
		}

		public void OnInvalidCover()
		{
			if (State == FighterState.takeCover || State == FighterState.fightInCover)
			{
				setState(FighterState.takeCover, forceRestart: true);
			}
			else if (State == FighterState.retreatToCover || State == FighterState.hideInCover)
			{
				setState(FighterState.retreatToCover, forceRestart: true);
			}
		}

		public void OnFoundCover()
		{
			_hasSucceededToFindCover = true;
			_hasFailedToFindCover = false;
		}

		public void OnNoCover()
		{
			_hasSucceededToFindCover = false;
			_hasFailedToFindCover = true;
		}

		public void OnCoverSearch()
		{
			_isLookingForCover = true;
			_hasSucceededToFindCover = false;
			_hasFailedToFindCover = false;
		}

		public void OnCircleFail()
		{
			if (State == FighterState.circle)
			{
				if (tryInvestigate())
				{
					setState(FighterState.investigate);
				}
				else
				{
					takeCoverOrAssault();
				}
			}
		}

		public void OnMoveFromFail()
		{
			if (State == FighterState.avoidAndFight)
			{
				_failedToAvoidInThisState = true;
				fightOrRunAway();
			}
		}

		public void OnPointInvestigated(Vector3 position)
		{
			if (State != FighterState.investigate)
			{
				return;
			}
			if (Vector3.Distance(base.LastKnownThreatPosition, position) < 0.5f)
			{
				if (base.IsActualThreatPosition && Time.timeSinceLevelLoad - base.LastSeenThreatTime < 1f)
				{
					fightOrRunAway();
				}
				else if (trySearch())
				{
					setState(FighterState.search);
				}
				else
				{
					fightOrRunAway();
				}
			}
			else
			{
				Message("ToInvestigatePosition", base.LastKnownThreatPosition);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			base.Actor.IsAggressive = true;
			_health = GetComponent<CharacterHealth>();
			_motor = GetComponent<CharacterMotor>();
			_inventory = GetComponent<CharacterInventory>();
			_sight = GetComponent<AISight>();
			_reachablePath = new NavMeshPath();
			switch (Start.Mode)
			{
			case AIStartMode.idle:
				_futureSetState = FighterState.idle;
				break;
			case AIStartMode.alerted:
				_futureSetState = FighterState.idleButAlerted;
				break;
			case AIStartMode.patrol:
				_futureSetState = FighterState.patrol;
				break;
			case AIStartMode.searchAround:
			case AIStartMode.searchPosition:
				_futureSetState = FighterState.search;
				break;
			case AIStartMode.investigate:
				_futureSetState = FighterState.investigate;
				break;
			}
		}

		private void Update()
		{
			if (base.Actor == null || !base.Actor.IsAlive)
			{
				return;
			}
			_stateTime += Time.deltaTime;
			if (_futureSetState != 0)
			{
				FighterState futureSetState = _futureSetState;
				_futureSetState = FighterState.none;
				setStateImmediately(futureSetState);
			}
			if (base.Threat == null || !base.Threat.IsAlive)
			{
				foreach (Actor visibleCivilian in _visibleCivilians)
				{
					if (visibleCivilian.IsAlerted)
					{
						OnCivilianAlerted(visibleCivilian);
						break;
					}
				}
			}
			if (base.Threat != null && base.CanSeeTheThreat)
			{
				if (_sight != null)
				{
					_sight.DoubleCheck(base.Threat);
				}
				if (base.CanSeeTheThreat)
				{
					setSeenThreat(base.Threat, base.Threat.transform.position, base.Threat.Cover);
					_invisibleTime = 0f;
				}
				else
				{
					_invisibleTime += Time.deltaTime;
				}
			}
			else
			{
				_invisibleTime += Time.deltaTime;
			}
			if (DebugThreat && base.Threat != null)
			{
				UnityEngine.Debug.DrawLine(base.transform.position, base.LastKnownThreatPosition, Color.cyan);
			}
			if (canLeavePosition)
			{
				findGrenades();
			}
			switch (_state)
			{
			case FighterState.idle:
				break;
			case FighterState.idleButAlerted:
				break;
			case FighterState.patrol:
				break;
			case FighterState.search:
				break;
			case FighterState.flee:
			case FighterState.call:
				break;
			case FighterState.none:
				setState(FighterState.patrol);
				break;
			case FighterState.investigate:
				if (_stateTime > 2.5f && _hasOpenFire)
				{
					Message("ToCloseFire");
				}
				break;
			case FighterState.avoidGrenade:
				if (_stateTime > GrenadeAvoidance.Duration || Vector3.Distance(_avoidedGrenadePosition, base.transform.position) > _avoidedGrenadeRange)
				{
					if (_previousState != FighterState.avoidGrenade)
					{
						setState(_previousState);
					}
					else
					{
						setState(FighterState.idleButAlerted);
					}
				}
				else
				{
					Message("ToKeepSprintingFrom", _avoidedGrenadePosition);
				}
				break;
			case FighterState.process:
				if (!_isCombatProcess)
				{
					break;
				}
				turnAndAimAtTheThreat();
				if (base.Threat != null)
				{
					if (!_hasOpenFire)
					{
						Message("ToOpenFire");
					}
				}
				else if (_hasOpenFire)
				{
					Message("ToCloseFire");
				}
				break;
			case FighterState.standAndFight:
				if (_stateTime >= StandDuration)
				{
					if (Vector3.Distance(base.transform.position, base.LastKnownThreatPosition) > DistanceToGoToCoverFromStandOrCircle)
					{
						takeCoverOrAssault();
					}
					else if (tryAssault())
					{
						setState(FighterState.assault);
					}
					else
					{
						setState(FighterState.circle);
					}
				}
				else
				{
					turnAndAimAtTheThreat();
					if (!_failedToAvoidInThisState)
					{
						checkAllySpacingAndMoveIfNeeded();
						checkAvoidanceAndSetTheState();
					}
				}
				checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: true);
				checkAndThrowGrenade();
				break;
			case FighterState.keepCloseTo:
				if (Vector3.Distance(base.transform.position, _keepCloseTo.Position) < _keepCloseTo.Distance * 0.9f)
				{
					takeCoverOrAssault();
				}
				else
				{
					turnAndAimAtTheThreat();
					if (!_failedToAvoidInThisState)
					{
						checkAvoidanceAndSetTheState();
					}
				}
				checkAndThrowGrenade();
				break;
			case FighterState.maintainPosition:
				_regrouper = null;
				if (!_hasReachedMaintainPosition && Vector3.Distance(base.transform.position, _maintainPosition) < 1f)
				{
					_maintainPositionReachTime = _stateTime;
					_hasReachedMaintainPosition = true;
					Message("ToCrouch");
				}
				if (!_maintainPositionIndefinitely && _hasReachedMaintainPosition && _stateTime > _maintainDuration + _maintainPositionReachTime)
				{
					takeCoverOrAssault();
				}
				else
				{
					if (base.Threat != null)
					{
						if (checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: true, startInvestigation: false))
						{
							if (_hasOpenFire)
							{
								Message("ToCloseFire");
							}
							RemoveThreat();
						}
						else
						{
							turnAndAimAtTheThreat();
						}
					}
					if (!_failedToAvoidInThisState && !_maintainPositionIndefinitely)
					{
						checkAvoidanceAndSetTheState();
					}
				}
				checkAndThrowGrenade();
				break;
			case FighterState.takeCover:
			case FighterState.takeDefenseCover:
				if (_hasSucceededToFindCover)
				{
					if (_isLookingForCover)
					{
						Message("ToArm");
						if (base.Threat != null)
						{
							Message("ToOpenFire");
						}
						else
						{
							Message("ToFaceWalkDirection");
						}
						_isLookingForCover = false;
					}
					turnAndAimAtTheThreat();
					checkAvoidanceAndSetTheState();
					checkInvestigationManageFireAndSetTheState(checkVisibility: false, checkTime: true);
				}
				else if (_hasFailedToFindCover)
				{
					if (_regrouper != null)
					{
						ToFindAndMaintainPosition(_regrouper);
					}
					else if (base.Threat == null || !base.Threat.IsAlive)
					{
						setState(FighterState.idleButAlerted);
					}
					else if (tryAssault())
					{
						setState(FighterState.assault);
					}
					else
					{
						setState(FighterState.circle);
					}
				}
				break;
			case FighterState.switchCover:
				if (_hasSucceededToFindCover)
				{
					if (_isLookingForCover)
					{
						Message("ToArm");
						if (base.Threat != null)
						{
							Message("ToOpenFire");
						}
						Message("OnCoverSwitch");
						_isLookingForCover = false;
					}
					turnAndAimAtTheThreat();
					checkAvoidanceAndSetTheState();
					checkInvestigationManageFireAndSetTheState(checkVisibility: false, checkTime: true);
				}
				else if (base.CanSeeTheThreat || base.Actor.Cover != null)
				{
					fightOrRunAway();
				}
				else if (tryInvestigate())
				{
					setState(FighterState.investigate);
				}
				else
				{
					setState(FighterState.takeCover);
				}
				break;
			case FighterState.retreatToCover:
				turnAndAimAtTheThreat();
				checkAvoidanceAndSetTheState();
				break;
			case FighterState.fightInCover:
				turnAndAimAtTheThreat();
				if (base.Actor.Cover == null)
				{
					setState(FighterState.takeCover);
				}
				else if (_stateTime > CoverSwitchWait)
				{
					setState(FighterState.switchCover);
				}
				checkAvoidanceAndSetTheState();
				checkAllySpacingAndMoveIfNeeded();
				checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: true);
				checkAndThrowGrenade();
				break;
			case FighterState.hideInCover:
				if (!checkAvoidanceAndSetTheState() && !checkAllySpacingAndMoveIfNeeded() && _stateTime > Retreat.HideDuration && base.Threat != null)
				{
					setState(FighterState.fightInCover);
				}
				break;
			case FighterState.avoidAndFight:
				turnAndAimAtTheThreat();
				if (_stateTime > 2f && !checkAvoidanceAndSetTheState())
				{
					if (tryFire())
					{
						setState(FighterState.standAndFight);
					}
					else if (tryAssault())
					{
						setState(FighterState.assault);
					}
				}
				checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: true);
				break;
			case FighterState.runAway:
				Message("ToFaceWalkDirection");
				if (_stateTime > 8f)
				{
					if (tryFire())
					{
						setState(FighterState.standAndFight);
					}
					else if (tryAssault())
					{
						setState(FighterState.assault);
					}
				}
				break;
			case FighterState.circle:
				if (_stateTime >= CircleDuration)
				{
					if (Vector3.Distance(base.transform.position, base.LastKnownThreatPosition) > DistanceToGoToCoverFromStandOrCircle)
					{
						takeCoverOrAssault();
					}
					else
					{
						fightOrRunAway();
					}
				}
				else
				{
					turnAndAimAtTheThreat();
					checkAvoidanceAndSetTheState();
					checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: true);
				}
				break;
			case FighterState.assault:
				turnAndAimAtTheThreat();
				checkInvestigationManageFireAndSetTheState(checkVisibility: true, checkTime: false);
				break;
			}
		}

		private void setState(FighterState state, bool forceRestart = false, bool allowCancelProcess = false)
		{
			if (_state == FighterState.process && !allowCancelProcess)
			{
				return;
			}
			switch (state)
			{
			}
			if (_futureSetState != 0 || _state != state || forceRestart)
			{
				_futureSetState = state;
			}
		}

		private void setStateImmediately(FighterState state)
		{
			if (_state != state)
			{
				_previousState = _state;
			}
			_failedToAvoidInThisState = false;
			_hasOpenFire = false;
			closeState(_state, state);
			_stateTime = 0f;
			_state = state;
			openState(_state, _previousState);
			if (IsAlerted)
			{
				if (!_wasAlerted)
				{
					_wasAlerted = true;
					Message("OnAlerted");
				}
			}
			else
			{
				_wasAlerted = false;
			}
		}

		private void openState(FighterState state, FighterState previous)
		{
			switch (state)
			{
			case FighterState.none:
			case FighterState.idle:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Patrol;
				}
				Message("ToDisarm");
				if (Start.ReturnOnIdle && Vector3.Distance(base.transform.position, base.StartingLocation) > 0.25f)
				{
					Message("ToWalkTo", base.StartingLocation);
					Message("ToFaceWalkDirection");
				}
				else
				{
					Message("ToStopMoving");
				}
				break;
			case FighterState.idleButAlerted:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Patrol;
				}
				Message("ToArm");
				Message("ToStopMoving");
				Message("ToScan");
				break;
			case FighterState.flee:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Flee;
				}
				Message("ToCloseFire");
				Message("ToLeaveCover");
				Message("ToStartFleeing", base.LastKnownThreatPosition);
				Message("OnScared");
				alarm();
				break;
			case FighterState.patrol:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Patrol;
				}
				if (base.Actor.Cover != null)
				{
					Message("ToLeaveCover");
				}
				Message("ToDisarm");
				_waypointCheck = false;
				Message("ToStartVisitingWaypoints");
				if (!_waypointCheck)
				{
					setState(FighterState.idle);
				}
				break;
			case FighterState.standAndFight:
				Message("ToStopMoving");
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				alarm();
				break;
			case FighterState.process:
				Message("ToStopMoving");
				if (_isCombatProcess)
				{
					Message("ToArm");
					if (base.Threat != null)
					{
						turnAndAimAtTheThreat();
						Message("ToOpenFire");
					}
					alarm();
				}
				break;
			case FighterState.keepCloseTo:
				Message("ToRunTo", _keepCloseTo.Position);
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				alarm();
				break;
			case FighterState.maintainPosition:
				_hasReachedMaintainPosition = false;
				Message("ToRunTo", _maintainPosition);
				Message("ToArm");
				if (base.Threat != null)
				{
					turnAndAimAtTheThreat();
					Message("ToOpenFire");
				}
				else
				{
					Message("ToFaceWalkDirection");
				}
				alarm();
				if (_maintainPositionIndefinitely)
				{
					Message("OnHoldPosition", _maintainPosition);
				}
				break;
			case FighterState.takeCover:
			case FighterState.takeDefenseCover:
			case FighterState.retreatToCover:
				if (Speed.Enabled)
				{
					if (state == FighterState.takeCover)
					{
						_motor.Speed = Speed.TakeCover;
					}
					else
					{
						_motor.Speed = Speed.RetreatToCover;
					}
				}
				Message("ToRunToCovers");
				_isLookingForCover = false;
				_hasSucceededToFindCover = false;
				_hasFailedToFindCover = true;
				if (State == FighterState.takeDefenseCover)
				{
					Message("ToTakeDefenseCover", _defensePosition);
				}
				else
				{
					Message("OnNoMaxCoverPivotDistance");
					if (_regrouper != null)
					{
						Message("ToTakeCoverCloseTo", _regrouper);
					}
					else if (base.Threat != null)
					{
						Message("ToTakeCoverAgainst", base.LastKnownThreatPosition);
					}
					else
					{
						Message("ToTakeCover");
					}
				}
				_regrouper = null;
				alarm();
				if (state == FighterState.retreatToCover)
				{
					Message("OnRetreat");
				}
				break;
			case FighterState.switchCover:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.SwitchCover;
				}
				_isLookingForCover = false;
				_hasFailedToFindCover = true;
				_hasSucceededToFindCover = false;
				Message("ToRunToCovers");
				Message("ToSwitchCover");
				break;
			case FighterState.investigate:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Investigate;
				}
				if (!base.HasSeenTheEnemy && Start.Mode == AIStartMode.investigate)
				{
					SetThreat( false,false,  false, null, Start.Position, null, 0f);
				}
				Message("ToArm");
				if (_isInDarkness)
				{
					Message("ToLight");
				}
				turnAndAimAtTheThreat();
				Message("ToStartAiming");
				Message("ToCloseFire");
				if (base.ThreatCover != null)
				{
					if (base.IsActualThreatPosition && base.Threat != null && base.HasSeenTheEnemy)
					{
						Message("ToHideFlashlight");
						Message("ToArm");
						Message("ToOpenFire");
					}
					Message("ToInvestigatePosition", base.LastKnownThreatPosition);
				}
				else if (base.HasSeenTheEnemy || base.HasHeardTheEnemy || Start.Mode == AIStartMode.investigate)
				{
					Message("ToInvestigatePosition", base.LastKnownThreatPosition);
				}
				else if (trySearch())
				{
					setState(FighterState.search);
				}
				else
				{
					fightOrRunAway();
				}
				break;
			case FighterState.fightInCover:
				if (base.Actor.Cover == null)
				{
					setState(FighterState.takeCover);
					break;
				}
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				alarm();
				break;
			case FighterState.hideInCover:
				Message("ToCloseFire");
				Message("ToStopAiming");
				if (base.Actor.Cover == null)
				{
					setState(FighterState.retreatToCover);
				}
				break;
			case FighterState.avoidAndFight:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Avoid;
				}
				Message("ToRunFrom", base.LastKnownThreatPosition);
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				alarm();
				break;
			case FighterState.runAway:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Flee;
				}
				Message("ToRunFrom", base.LastKnownThreatPosition);
				alarm();
				break;
			case FighterState.avoidGrenade:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Avoid;
				}
				Message("ToCloseFire");
				Message("ToSprintFrom", _avoidedGrenadePosition);
				alarm();
				break;
			case FighterState.circle:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Circle;
				}
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				Message("ToCircle", base.LastKnownThreatPosition);
				alarm();
				break;
			case FighterState.assault:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Assault;
				}
				Message("ToArm");
				turnAndAimAtTheThreat();
				Message("ToOpenFire");
				Message("ToStartAssault", base.LastKnownThreatPosition);
				alarm();
				break;
			case FighterState.search:
				if (Speed.Enabled)
				{
					_motor.Speed = Speed.Search;
				}
				if (base.Threat == null)
				{
					if (previous == FighterState.none && Start.Mode == AIStartMode.searchPosition)
					{
						Message("ToSearchAt", new SearchPoint(Start.Position, (base.transform.position - Start.Position).normalized, requiresReaching: false));
					}
					else
					{
						Message("ToSearch");
					}
				}
				else
				{
					Message("ToSearchAt", new SearchPoint(base.LastKnownThreatPosition, (!(base.ThreatCover != null)) ? (base.transform.position - base.LastKnownThreatPosition).normalized : (-base.ThreatCover.Forward), base.ThreatCover == null));
				}
				Message("ToArm");
				if (_isInDarkness)
				{
					Message("ToLight");
				}
				Message("ToStartAiming");
				Message("OnSearch");
				break;
			case FighterState.call:
				Message("ToHideFlashlight");
				Message("ToDisarm");
				Message("ToTakeRadio");
				_callCheck = false;
				Message("ToCall");
				if (!_callCheck)
				{
					setState(_previousState);
				}
				break;
			}
			if (IsAlerted && _isInDarkness)
			{
				Message("ToTurnOnLight");
			}
		}

		private void closeState(FighterState state, FighterState next)
		{
			switch (state)
			{
			case FighterState.search:
				if (_isInDarkness)
				{
					Message("ToHideFlashlight");
				}
				Message("ToStopSearch");
				break;
			case FighterState.avoidGrenade:
				Message("ToStopMoving");
				break;
			case FighterState.maintainPosition:
				if (_maintainPositionIndefinitely)
				{
					Message("OnStopHoldingPosition");
				}
				Message("ToStopCrouching");
				break;
			case FighterState.flee:
				Message("ToStopFleeing");
				break;
			case FighterState.patrol:
				if (_isInDarkness)
				{
					Message("ToHideFlashlight");
				}
				Message("ToStopVisitingWaypoints");
				break;
			case FighterState.takeCover:
			case FighterState.takeDefenseCover:
			case FighterState.switchCover:
			case FighterState.retreatToCover:
			case FighterState.fightInCover:
				if (next != FighterState.fightInCover && next != FighterState.hideInCover)
				{
					Message("ToLeaveCover");
				}
				break;
			case FighterState.investigate:
				if (_isInDarkness)
				{
					Message("ToHideFlashlight");
				}
				Message("ToStopInvestigation");
				break;
			case FighterState.call:
				Message("ToHideRadio");
				break;
			case FighterState.assault:
				Message("ToStopAssault");
				break;
			}
			switch (state)
			{
			case FighterState.switchCover:
			case FighterState.retreatToCover:
			case FighterState.hideInCover:
			case FighterState.avoidAndFight:
			case FighterState.runAway:
			case FighterState.avoidGrenade:
			case FighterState.search:
			case FighterState.flee:
			case FighterState.call:
				break;
			case FighterState.standAndFight:
			case FighterState.keepCloseTo:
			case FighterState.maintainPosition:
			case FighterState.takeCover:
			case FighterState.takeDefenseCover:
			case FighterState.fightInCover:
			case FighterState.circle:
			case FighterState.assault:
			case FighterState.investigate:
			case FighterState.process:
				Message("ToCloseFire");
				break;
			}
		}

		private bool checkInvestigationManageFireAndSetTheState(bool checkVisibility, bool checkTime, bool startInvestigation = true)
		{
			if (base.Threat == null)
			{
				if (_hasOpenFire)
				{
					Message("ToCloseFire");
				}
				return false;
			}
			bool result = false;
			float num = Vector3.Distance(base.transform.position, base.LastKnownThreatPosition);
			bool flag = checkTime && InvestigationWait < base.ThreatAge;
			bool flag2 = checkVisibility && _invisibleTime > 1f && base.ThreatCover == null;
			if (!flag && flag2 && !_hasCheckedIfTheLastKnownPositionIsNearCover)
			{
				_hasCheckedIfTheLastKnownPositionIsNearCover = true;
				Cover resultCover = null;
				Vector3 resultPosition = base.LastKnownThreatPosition;
				if (Util.GetClosestCover(resultPosition, 3f, ref resultCover, ref resultPosition) && AIUtil.IsObstructed(base.transform.position + Vector3.up * 2f, resultPosition + Vector3.up * 0.5f))
				{
					flag2 = false;
					setThreat( false,false,  false,  false, base.Threat, resultPosition, resultCover, 0f);
				}
			}
			bool flag3 = _sight != null && _sight.IsInDarkness(base.Threat);
			if (flag || (flag2 && !flag3))
			{
				Vector3 position = base.LastKnownThreatPosition;
				bool flag4 = AIUtil.GetClosestStandablePosition(ref position);
				if (_hasCheckedReachabilityAndFailed && Time.timeSinceLevelLoad - _reachabilityCheckTime > 5f)
				{
					flag4 = false;
				}
				if (flag4)
				{
					AIUtil.Path(ref _reachablePath, base.transform.position, position);
					flag4 = (_reachablePath.status == NavMeshPathStatus.PathComplete);
				}
				if (flag4 && tryInvestigate())
				{
					_hasCheckedReachabilityAndFailed = false;
					Message("ToClearSearchHistory");
					setState(FighterState.investigate);
					result = true;
				}
				else if (_hasOpenFire)
				{
					_hasCheckedReachabilityAndFailed = true;
					_reachabilityCheckTime = Time.timeSinceLevelLoad;
					Message("ToCloseFire");
				}
			}
			else
			{
				_hasCheckedReachabilityAndFailed = false;
				float num2 = (!(_sight != null) || !_sight.enabled) ? 0f : _sight.Distance;
				if (num >= num2)
				{
					if (_hasOpenFire)
					{
						Message("ToCloseFire");
					}
				}
				else if (!_hasOpenFire && base.Threat.IsAlive)
				{
					Message("ToOpenFire");
				}
			}
			return result;
		}

		private void checkAndThrowGrenade()
		{
			if (base.Threat == null || InvestigationWait < base.ThreatAge || _thrownGrenadeCount >= Grenades.GrenadeCount || (!base.CanSeeTheThreat && base.ThreatCover == null && !_isInDarkness))
			{
				return;
			}
			bool flag = false;
			if (_hasThrowFirstGrenade)
			{
				if (_grenadeTimer < Grenades.Interval)
				{
					_grenadeTimer += Time.deltaTime;
				}
				else
				{
					flag = true;
				}
			}
			else if (_grenadeTimer < Grenades.FirstCheckDelay)
			{
				_grenadeTimer += Time.deltaTime;
			}
			else
			{
				flag = true;
			}
			if (flag && _motor.PotentialGrenade != null)
			{
				if (_grenadeCheckTimer <= float.Epsilon)
				{
					GrenadeDescription desc = default(GrenadeDescription);
					desc.Gravity = _motor.Grenade.Gravity;
					desc.Duration = _motor.PotentialGrenade.Timer;
					desc.Bounciness = _motor.PotentialGrenade.Bounciness;
					bool flag2 = true;
					for (int i = 0; i < GrenadeList.Count; i++)
					{
						Grenade grenade = GrenadeList.Get(i);
						if (Vector3.Distance(grenade.transform.position, base.LastKnownThreatPosition) < grenade.ExplosionRadius * 0.5f)
						{
							flag2 = false;
							break;
						}
					}
					int num = 0;
					if (flag2)
					{
						num = GrenadePath.Calculate(GrenadePath.Origin(_motor, Util.HorizontalAngle(base.LastKnownThreatPosition - base.transform.position)), base.LastKnownThreatPosition, _motor.Grenade.MaxVelocity, desc, _grenadePath, _motor.Grenade.Step);
						flag2 = (Vector3.Distance(_grenadePath[num - 1], base.LastKnownThreatPosition) < Grenades.MaxRadius);
					}
					if (flag2)
					{
						int num2 = AIUtil.FindActors(_grenadePath[num - 1], Grenades.AvoidDistance);
						for (int j = 0; j < num2; j++)
						{
							if (AIUtil.Actors[j] == base.Actor || AIUtil.Actors[j].Side == base.Actor.Side)
							{
								flag2 = false;
								break;
							}
						}
					}
					if (flag2)
					{
						_motor.InputThrowGrenade(_grenadePath, num, _motor.Grenade.Step);
						_thrownGrenadeCount++;
						_grenadeTimer = 0f;
						_hasThrowFirstGrenade = true;
					}
					else
					{
						_grenadeCheckTimer = Grenades.CheckInterval;
					}
				}
				else
				{
					_grenadeCheckTimer -= Time.deltaTime;
				}
			}
			else
			{
				_grenadeCheckTimer = 0f;
			}
		}

		private void findGrenades()
		{
			for (int i = 0; i < GrenadeList.Count; i++)
			{
				Grenade grenade = GrenadeList.Get(i);
				if (Vector3.Distance(grenade.transform.position, base.transform.position) < grenade.ExplosionRadius)
				{
					_grenadeAvoidReaction += Time.deltaTime;
					if (_grenadeAvoidReaction >= GrenadeAvoidance.ReactionTime + float.Epsilon)
					{
						_avoidedGrenadePosition = grenade.transform.position;
						_avoidedGrenadeRange = grenade.ExplosionRadius;
						setState(FighterState.avoidGrenade);
					}
					return;
				}
			}
			_grenadeAvoidReaction = 0f;
		}

		private bool checkAllySpacingAndMoveIfNeeded()
		{
			bool flag = false;
			float num = 0f;
			Vector3 a = Vector3.zero;
			int num2 = AIUtil.FindActors(base.transform.position, AllySpacing, base.Actor);
			for (int i = 0; i < num2; i++)
			{
				if (AIUtil.Actors[i].Side == base.Actor.Side)
				{
					Vector3 vector = AIUtil.Actors[i].transform.position - base.transform.position;
					float magnitude = vector.magnitude;
					if (!flag || magnitude < num)
					{
						flag = true;
						num = magnitude;
						a = vector;
					}
				}
			}
			if (flag)
			{
				_hadMoveTargetBeforeAllySpacing = _hasMoveTarget;
				_moveTargetBeforeAllySpacing = _moveTarget;
				Message("ToWalkInDirection", -a);
				return true;
			}
			if (_hadMoveTargetBeforeAllySpacing)
			{
				Message("ToRunTo", _moveTargetBeforeAllySpacing);
			}
			return false;
		}

		private bool checkAvoidanceAndSetTheState()
		{
			if (base.Threat == null || !base.Threat.IsAlive || !base.CanSeeTheThreat || Vector3.Distance(base.LastKnownThreatPosition, base.transform.position) > AvoidDistance)
			{
				return false;
			}
			setState(FighterState.avoidAndFight);
			return true;
		}

		private void takeCoverOrAssault()
		{
			if (tryAssault())
			{
				setState(FighterState.assault);
			}
			else
			{
				setState(FighterState.takeCover);
			}
		}

		private void fightOrRunAway()
		{
			if (tryFire())
			{
				if (base.Actor.Cover != null)
				{
					setState(FighterState.fightInCover);
				}
				else
				{
					setState(FighterState.standAndFight);
				}
			}
			else if (tryAssault())
			{
				setState(FighterState.assault);
			}
			else
			{
				setState(FighterState.runAway);
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

		private bool tryFire()
		{
			if (_motor.Weapon.Gun != null)
			{
				return true;
			}
			if (_inventory != null)
			{
				for (int i = 0; i < _inventory.Weapons.Length; i++)
				{
					if (_inventory.Weapons[i].Gun != null)
					{
						return true;
					}
				}
			}
			return false;
		}

		private void turnAndAimAtTheThreat()
		{
			if (base.Threat == null || !base.Threat.IsAlive)
			{
				Message("ToTurnAt", base.LastKnownThreatPosition);
				Message("ToAimAt", base.LastKnownThreatPosition + Vector3.up * 1f);
			}
			else
			{
				Message("ToTarget", new ActorTarget(base.LastKnownThreatPosition, base.Threat.RelativeTopPosition, base.Threat.RelativeStandingTopPosition));
			}
		}

		private void guessThreat(Actor threat, Vector3 position, bool isHeard)
		{
			float num = Approximation.Get(Vector3.Distance(base.transform.position, position));
			if (num < 0.25f)
			{
				setUnseenThreat(isHeard,  true,  false, threat, position, null);
				return;
			}
			for (int i = 0; i < 6; i++)
			{
				Vector3 a = Util.HorizontalVector(Random.Range(0f, 360f));
				float d = Random.Range(num * 0.25f, num);
				Vector3 position2 = position + a * d;
				if (AIUtil.GetClosestStandablePosition(ref position2) && Mathf.Abs(position2.y - position.y) < 0.2f)
				{
					setUnseenThreat(isHeard,  false,  false, threat, position2, null);
					return;
				}
			}
			setUnseenThreat(isHeard,  false,  false, threat, position, null);
		}

		private void setUnseenThreat(bool isHeard, bool isDirect, bool isSeenByFriend, Actor threat, Vector3 position, Cover threatCover)
		{
			setThreat( false, isHeard, isSeenByFriend, isDirect, threat, position, threatCover, Time.timeSinceLevelLoad);
		}

		private void setSeenThreat(Actor threat, Vector3 position, Cover threatCover)
		{
			setThreat( true,false,  false,  true, threat, position, threatCover, Time.timeSinceLevelLoad);
		}

		private void setThreat(bool isVisible, bool isHeard, bool isVisibleByFriends, bool isActual, Actor threat, Vector3 position, Cover threatCover, float time)
		{
			Actor threat2 = base.Threat;
			bool canSeeTheThreat = base.CanSeeTheThreat;
			if (threat != _lockedTarget)
			{
				_lockedTarget = null;
			}
			if (threat != null)
			{
				_isInAggressiveMode = true;
			}
			_hasCheckedIfTheLastKnownPositionIsNearCover = false;
			SetThreat(isVisible, isHeard, isActual, threat, position, threatCover, time);
			if (base.CanSeeTheThreat && base.Threat != null && (!canSeeTheThreat || threat2 != base.Threat))
			{
				foreach (Actor item in _friendsThatCanSeeMe)
				{
					item.SendMessage("OnFriendFoundEnemy", base.Actor);
				}
				foreach (BaseBrain friend in _friends)
				{
					if (!_friendsThatCanSeeMe.Contains(friend.Actor))
					{
						friend.Message("OnFriendFoundEnemy", base.Actor);
					}
				}
			}
			if (!base.isActiveAndEnabled)
			{
				return;
			}
			if (canLeavePosition)
			{
				if (!IsAlerted && Random.Range(0f, 1f) <= TakeCoverImmediatelyChance)
				{
					setState(FighterState.takeCover);
				}
				else if (State == FighterState.investigate)
				{
					if (isActual)
					{
						if (isVisible)
						{
							fightOrRunAway();
						}
						else if (isVisibleByFriends)
						{
							takeCoverOrAssault();
						}
						else if (tryInvestigate())
						{
							setState(FighterState.investigate, forceRestart: true);
						}
						else
						{
							takeCoverOrAssault();
						}
					}
					else
					{
						Message("ToInvestigatePosition", position);
					}
				}
				else if (State == FighterState.search || !IsAlerted)
				{
					if (isVisible)
					{
						fightOrRunAway();
					}
					else if (isVisibleByFriends)
					{
						takeCoverOrAssault();
					}
					else if (tryInvestigate())
					{
						setState(FighterState.investigate);
					}
					else
					{
						takeCoverOrAssault();
					}
				}
			}
			if (State == FighterState.maintainPosition && base.Threat != null && base.Threat != threat2)
			{
				Message("ToOpenFire");
			}
		}
	}
}
