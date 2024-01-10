// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIActions
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(FighterBrain))]
	public class AIActions : AIBase
	{
		[Tooltip("Array of possible actions.")]
		public AIAction[] Actions;

		[Tooltip("An actor that is prioritized over others when performing relevant actions.")]
		public Actor Priority;

		[Tooltip("Time in seconds to wait after making another automatic action.")]
		public float AutoCooldown = 8f;

		[Tooltip("Distance at which the AI will consider other actors as target of an auto action.")]
		public float AutoDistance = 20f;

		[Tooltip("Should the automatic actions against enemies be performed when in cover.")]
		public bool AutoAttackOnlyFromCover = true;

		[Tooltip("If other AI components are taking cover, should the actions be delayed until they are finished.")]
		public bool WaitForCoverActions = true;

		[Tooltip("Once the AI has taken cover, how many seconds to wait before considering an action.")]
		public float CoverDelay = 2f;

		[Tooltip("If an action is being performed and it takes too long it will be cancelled. Some actions have no timeout.")]
		public float Timeout = 4f;

		private Actor _actor;

		private FighterBrain _brain;

		private AIAction _active;

		private float _autoWait;

		private float _checkWait;

		private List<Actor> _possibleActionTargets = new List<Actor>();

		private List<Actor> _nearbyActors = new List<Actor>();

		private bool _isTakingCover;

		private float _coverTimer;

		private bool _isInCover;

		private float _actionStart;

		public bool IsPerforming => _active != null;

		public AIAction Active => _active;

		public bool HasAllyActions
		{
			get
			{
				for (int i = 0; i < Actions.Length; i++)
				{
					if (Actions[i].CanTargetAlly)
					{
						return true;
					}
				}
				return false;
			}
		}

		private void Awake()
		{
			_brain = GetComponent<FighterBrain>();
			_actor = GetComponent<Actor>();
			for (int i = 0; i < Actions.Length; i++)
			{
				Actions[i].SetupActor(_actor);
			}
		}

		public void Execute(AIAction action)
		{
			if (!(_active != null) && !(action.Wait > float.Epsilon) && action.Execute(_actor))
			{
				begin(action);
			}
		}

		public void Execute(AIAction action, Vector3 position)
		{
			if (!(_active != null) && !(action.Wait > float.Epsilon) && action.Execute(_actor, position))
			{
				begin(action);
			}
		}

		public void Execute(AIAction action, Actor target)
		{
			if (!(_active != null) && !(action.Wait > float.Epsilon) && action.Execute(_actor, target))
			{
				begin(action);
			}
		}

		private void begin(AIAction command)
		{
			_actionStart = Time.timeSinceLevelLoad;
			_active = command;
			Message("ToEnterProcess", false);
		}

		private void end()
		{
			Message("ToExitProcessAndMaintainPosition");
			_active.Stop();
			_active = null;
		}

		public void ToStopActions()
		{
			if (_active != null)
			{
				end();
			}
		}

		public void OnFinishAction()
		{
			if (_active != null && _active.OnFinishAction())
			{
				end();
			}
		}

		public void OnThrow()
		{
			if (_active != null && _active.OnThrow())
			{
				end();
			}
		}

		public void ToStopMoving()
		{
			_isTakingCover = false;
		}

		public void OnFinishTakeCover()
		{
			_isTakingCover = false;
		}

		public void OnFoundCover()
		{
			_isTakingCover = true;
		}

		private void Update()
		{
			if (_autoWait > float.Epsilon)
			{
				_autoWait -= Time.deltaTime;
			}
			if (_checkWait > float.Epsilon)
			{
				_checkWait -= Time.deltaTime;
			}
			if (_coverTimer > float.Epsilon)
			{
				_coverTimer -= Time.deltaTime;
			}
			if (_active != null && (!_active.Update() || (!_active.HasNoTimeout && Time.timeSinceLevelLoad - _actionStart > Timeout)))
			{
				end();
			}
			if (_actor.Cover == null)
			{
				_isInCover = false;
				_coverTimer = 0f;
			}
			else if (!_isInCover)
			{
				_coverTimer = CoverDelay;
				_isInCover = true;
			}
			if (!(_active == null) || !(_autoWait <= float.Epsilon) || !(_checkWait <= float.Epsilon) || !_brain.enabled || _brain.State == FighterState.process || !_actor.IsAlive || !(_coverTimer <= float.Epsilon) || (WaitForCoverActions && _isTakingCover))
			{
				return;
			}
			_checkWait = 0.5f;
			_nearbyActors.Clear();
			int num = AIUtil.FindActorsIncludingDead(base.transform.position, AutoDistance);
			for (int i = 0; i < num; i++)
			{
				_nearbyActors.Add(AIUtil.Actors[i]);
			}
			bool flag = !AutoAttackOnlyFromCover || _actor.Cover != null;
			AIAction aIAction = null;
			Actor target = null;
			AIAction aIAction2 = null;
			int num2 = 0;
			for (int j = 0; j < Actions.Length; j++)
			{
				AIAction aIAction3 = Actions[j];
				if (aIAction3.Wait > float.Epsilon || !aIAction3.Auto || aIAction3.NeedsSingleTargetActor || aIAction3.NeedsTargetLocation || aIAction3.NeedsOnlySelf)
				{
					continue;
				}
				int num3 = 0;
				for (int k = 0; k < Actors.Count; k++)
				{
					Actor actor = Actors.Get(k);
					if (!actor.IsAlive && aIAction3.ShouldIgnoreDead)
					{
						continue;
					}
					if (actor.Side == _actor.Side)
					{
						if (((actor == _actor && aIAction3.CanTargetSelf) || aIAction3.CanTargetAlly) && aIAction3.IsNeededFor(actor))
						{
							num3++;
						}
					}
					else if (flag && aIAction3.CanTargetEnemy && aIAction3.IsNeededFor(actor) && (!AutoAttackOnlyFromCover || !aIAction3.WillMoveForActor(actor)))
					{
						num3++;
					}
				}
				if (num3 > num2)
				{
					aIAction2 = aIAction3;
					num2 = num3;
				}
			}
			if (aIAction2 != null)
			{
				_autoWait = AutoCooldown;
				Execute(aIAction2);
				return;
			}
			for (int l = 0; l < Actions.Length; l++)
			{
				AIAction aIAction4 = Actions[l];
				if (!(aIAction4.Wait > float.Epsilon) && aIAction4.Auto && aIAction4.NeedsOnlySelf && aIAction4.CanTargetSelf && aIAction4.IsNeededFor(_actor))
				{
					if (_actor == Priority)
					{
						_autoWait = AutoCooldown;
						Execute(aIAction4, _actor);
						return;
					}
					aIAction = aIAction4;
					target = _actor;
					break;
				}
			}
			for (int m = 0; m < Actions.Length; m++)
			{
				AIAction aIAction5 = Actions[m];
				if (aIAction5.Wait > float.Epsilon || !aIAction5.Auto || !aIAction5.NeedsSingleTargetActor)
				{
					continue;
				}
				Actor actor2 = null;
				float num4 = 0f;
				bool flag2 = false;
				for (int n = 0; n < _nearbyActors.Count; n++)
				{
					Actor actor3 = _nearbyActors[n];
					if (!actor3.IsAlive && aIAction5.ShouldIgnoreDead)
					{
						continue;
					}
					if (actor3 == _actor)
					{
						if (aIAction5.CanTargetSelf && aIAction5.IsNeededFor(actor3))
						{
							if (actor3 == Priority)
							{
								_autoWait = AutoCooldown;
								Execute(aIAction5, actor3);
								return;
							}
							if (actor2 == null)
							{
								actor2 = actor3;
								num4 = 0f;
								flag2 = true;
							}
						}
					}
					else if (actor3.Side == _actor.Side)
					{
						if (aIAction5.CanTargetAlly && aIAction5.IsNeededFor(actor3))
						{
							if (actor3 == Priority)
							{
								_autoWait = AutoCooldown;
								Execute(aIAction5, actor3);
								return;
							}
							float num5 = Vector3.Distance(base.transform.position, actor3.transform.position);
							if (actor2 == null || flag2 || num5 < num4)
							{
								actor2 = actor3;
								num4 = num5;
								flag2 = false;
							}
						}
					}
					else if (flag && aIAction5.CanTargetEnemy && aIAction5.IsNeededFor(actor3) && (!AutoAttackOnlyFromCover || !aIAction5.WillMoveForActor(actor3)))
					{
						if (actor3 == Priority)
						{
							_autoWait = AutoCooldown;
							Execute(aIAction5, actor3);
							return;
						}
						float num6 = Vector3.Distance(base.transform.position, actor3.transform.position);
						if (actor2 == null || flag2 || num6 < num4)
						{
							actor2 = actor3;
							num4 = num6;
							flag2 = false;
						}
					}
				}
				if (actor2 != null)
				{
					aIAction = aIAction5;
					target = actor2;
					break;
				}
			}
			for (int num7 = 0; num7 < Actions.Length; num7++)
			{
				AIAction aIAction6 = Actions[num7];
				if (aIAction6.Wait > float.Epsilon || !aIAction6.Auto || !aIAction6.NeedsTargetLocation)
				{
					continue;
				}
				_possibleActionTargets.Clear();
				for (int num8 = 0; num8 < _nearbyActors.Count; num8++)
				{
					Actor actor4 = _nearbyActors[num8];
					if (!actor4.IsAlive && aIAction6.ShouldIgnoreDead)
					{
						continue;
					}
					if (actor4 == _actor)
					{
						if (aIAction6.CanTargetSelf && aIAction6.IsNeededFor(actor4))
						{
							_possibleActionTargets.Add(actor4);
						}
					}
					else if (actor4.Side == _actor.Side)
					{
						if (aIAction6.CanTargetAlly && aIAction6.IsNeededFor(actor4))
						{
							_possibleActionTargets.Add(actor4);
						}
					}
					else if (flag && aIAction6.CanTargetEnemy && aIAction6.IsNeededFor(actor4))
					{
						_possibleActionTargets.Add(actor4);
					}
				}
				if (_possibleActionTargets.Count == 0 || (_possibleActionTargets.Count == 1 && aIAction != null) || !(aIAction6.UIRadius > float.Epsilon))
				{
					continue;
				}
				float uIRadius = aIAction6.UIRadius;
				int num9 = (int)(2f * AutoDistance / uIRadius);
				bool flag3 = false;
				Vector3 position = Vector3.zero;
				float num10 = 0f;
				int num11 = 0;
				bool flag4 = false;
				for (int num12 = -num9 / 2; num12 < num9 / 2; num12++)
				{
					for (int num13 = -num9 / 2; num13 < num9 / 2; num13++)
					{
						Vector3 vector = base.transform.position + new Vector3((float)num12 * aIAction6.UIRadius, 0f, (float)num13 * uIRadius);
						float num14 = Vector3.Distance(vector, base.transform.position);
						if (num14 > AutoDistance || (AutoAttackOnlyFromCover && aIAction6.CanTargetEnemy && aIAction6.WillMoveForPosition(vector)))
						{
							continue;
						}
						int num15 = 0;
						bool flag5 = false;
						for (int num16 = 0; num16 < _possibleActionTargets.Count; num16++)
						{
							Actor actor5 = _possibleActionTargets[num16];
							if (Vector3.Distance(vector, actor5.transform.position) < uIRadius)
							{
								num15++;
								if (actor5 == Priority)
								{
									flag5 = true;
								}
							}
						}
						if (num15 <= 0)
						{
							continue;
						}
						bool flag6 = false;
						if (!flag3)
						{
							flag6 = true;
						}
						else if (flag5 && !flag4)
						{
							flag6 = false;
						}
						else if (!flag4)
						{
							if (num15 > num11)
							{
								flag6 = true;
							}
							else if (num15 == num11)
							{
								flag6 = (num14 < num10);
							}
						}
						if (flag6)
						{
							flag3 = true;
							position = vector;
							num10 = num14;
							flag4 = flag5;
							num11 = num15;
						}
					}
				}
				if (flag3 && (aIAction == null || num11 > 1))
				{
					_autoWait = AutoCooldown;
					Execute(aIAction6, position);
					return;
				}
			}
			if (aIAction != null)
			{
				_autoWait = AutoCooldown;
				Execute(aIAction, target);
			}
			int num17 = 0;
			AIAction aIAction7;
			while (true)
			{
				if (num17 < Actions.Length)
				{
					aIAction7 = Actions[num17];
					if (!(aIAction7.Wait > float.Epsilon) && aIAction7.Auto && !aIAction7.CanTargetAny && !aIAction7.CanTargetGround && !(aIAction7.UIRadius > float.Epsilon) && !aIAction7.CanTargetMultiple && !aIAction7.NeedsOnlySelf)
					{
						break;
					}
					num17++;
					continue;
				}
				return;
			}
			_autoWait = AutoCooldown;
			Execute(aIAction7);
		}
	}
}
