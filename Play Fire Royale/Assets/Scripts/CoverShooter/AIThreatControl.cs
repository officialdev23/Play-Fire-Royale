// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIThreatControl
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIThreatControl : AIBase
	{
		[Tooltip("For how long the AI remembers a threat as a possible target after losing sight of it.")]
		public float MemoryDuration = 3f;

		[Tooltip("Mode for choosing which threat to attack. Leader is taken from AIFormation.")]
		public ThreatPriority Priority;

		public float HealthDistance = 15f;

		private Actor _actor;

		private Actor _previous;

		private Vector3 _previousThreatPosition;

		private Actor _reference;

		private float _previousThreatHealth;

		private List<Actor> _visible = new List<Actor>();

		private List<ActorMemory> _memory = new List<ActorMemory>();

		private AIFormation _formation;

		private FighterBrain _brain;

		private Actor _threatOverride;

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_formation = GetComponent<AIFormation>();
			_brain = GetComponent<FighterBrain>();
		}

		public void ToSetThreatReference(Actor reference)
		{
			_reference = reference;
		}

		public void ToOverrideThreat(Actor threat)
		{
			_threatOverride = threat;
		}

		private void Update()
		{
			for (int num = _memory.Count - 1; num >= 0; num--)
			{
				float timeSinceLevelLoad = Time.timeSinceLevelLoad;
				ActorMemory actorMemory = _memory[num];
				if (timeSinceLevelLoad - actorMemory.Time >= MemoryDuration)
				{
					_memory.RemoveAt(num);
				}
			}
			if (_threatOverride != null && !_threatOverride.IsAlive)
			{
				_threatOverride = null;
			}
			if (_previous != null && !_previous.IsAlive)
			{
				_previous = null;
			}
			if (_threatOverride != null)
			{
				_previous = _threatOverride;
				if (_visible.Contains(_threatOverride))
				{
					_previousThreatPosition = _threatOverride.transform.position;
				}
				else
				{
					foreach (ActorMemory item in _memory)
					{
						ActorMemory current = item;
						if (current.Actor == _threatOverride)
						{
							_previousThreatPosition = current.Position;
						}
					}
				}
			}
			else
			{
				Actor actor = (!(_reference != null) || !_reference.IsAlive) ? _actor : _reference;
				bool flag = true;
				if (_brain != null && _brain.Threat == null && !_brain.ImmediateThreatReaction)
				{
					flag = false;
				}
				switch (Priority)
				{
				case ThreatPriority.Closest:
				{
					Actor actor4 = null;
					float num2 = 0f;
					Vector3 previousThreatPosition = Vector3.zero;
					if (flag)
					{
						for (int i = 0; i < _visible.Count; i++)
						{
							if (_visible[i].IsAlive)
							{
								float num3 = Vector3.Distance(_visible[i].transform.position, actor.transform.position);
								if (num3 < num2 || actor4 == null)
								{
									previousThreatPosition = _visible[i].transform.position;
									actor4 = _visible[i];
									num2 = num3;
								}
							}
						}
						for (int j = 0; j < _memory.Count; j++)
						{
							ActorMemory actorMemory2 = _memory[j];
							if (actorMemory2.Actor.IsAlive)
							{
								ActorMemory actorMemory3 = _memory[j];
								float num4 = Vector3.Distance(actorMemory3.Position, actor.transform.position);
								if (num4 < num2 || actor4 == null)
								{
									ActorMemory actorMemory4 = _memory[j];
									previousThreatPosition = actorMemory4.Position;
									ActorMemory actorMemory5 = _memory[j];
									actor4 = actorMemory5.Actor;
									num2 = num4;
								}
							}
						}
					}
					if (_previous != null && actor4 != null && _previous != actor4 && Vector3.Distance(_previousThreatPosition, actor.transform.position) < num2 + 0.2f)
					{
						actor4 = _previous;
						previousThreatPosition = ((!_visible.Contains(actor4)) ? _previousThreatPosition : actor4.transform.position);
					}
					_previous = actor4;
					_previousThreatPosition = previousThreatPosition;
					if (_previous != null)
					{
						_previousThreatHealth = _previous.Health;
					}
					break;
				}
				case ThreatPriority.LeastHealth:
				{
					Actor actor5 = null;
					float num5 = 0f;
					Vector3 previousThreatPosition2 = Vector3.zero;
					if (flag)
					{
						for (int k = 0; k < _visible.Count; k++)
						{
							if (_visible[k].IsAlive && Vector3.Distance(_visible[k].transform.position, actor.transform.position) <= HealthDistance && (_visible[k].Health < num5 || actor5 == null))
							{
								previousThreatPosition2 = _visible[k].transform.position;
								actor5 = _visible[k];
								num5 = actor5.Health;
							}
						}
						for (int l = 0; l < _memory.Count; l++)
						{
							ActorMemory actorMemory6 = _memory[l];
							if (!actorMemory6.Actor.IsAlive)
							{
								continue;
							}
							ActorMemory actorMemory7 = _memory[l];
							if (Vector3.Distance(actorMemory7.Position, actor.transform.position) <= HealthDistance)
							{
								ActorMemory actorMemory8 = _memory[l];
								if (actorMemory8.Actor.Health < num5 || actor5 == null)
								{
									ActorMemory actorMemory9 = _memory[l];
									previousThreatPosition2 = actorMemory9.Position;
									ActorMemory actorMemory10 = _memory[l];
									actor5 = actorMemory10.Actor;
									num5 = actor5.Health;
								}
							}
						}
						if (_previous != null && actor5 != null && _previous != actor5 && _previousThreatHealth < num5 + 1f)
						{
							actor5 = _previous;
							previousThreatPosition2 = ((!_visible.Contains(actor5)) ? _previousThreatPosition : actor5.transform.position);
						}
					}
					_previous = actor5;
					_previousThreatPosition = previousThreatPosition2;
					if (_previous != null)
					{
						_previousThreatHealth = _previous.Health;
					}
					break;
				}
				case ThreatPriority.LeadersTarget:
				{
					Actor actor2 = (!(_formation != null) || !(_formation.Leader != null) || !(_formation.Leader.Actor != null)) ? null : _formation.Leader.Actor;
					Actor actor3 = (!(_reference != null) || !_reference.IsAlive) ? actor2 : _reference;
					if (actor3 != null && actor3.Threat != null && actor3.Threat.IsAlive)
					{
						_previous = actor3.Threat;
						if (_previous != null)
						{
							BaseBrain component = actor3.GetComponent<BaseBrain>();
							if (component != null)
							{
								_previousThreatPosition = component.LastKnownThreatPosition;
							}
							_previousThreatHealth = _previous.Health;
						}
					}
					else
					{
						_previous = null;
					}
					break;
				}
				}
			}
			if (_previous != null)
			{
				Threat threat = default(Threat);
				threat.Actor = _previous;
				threat.Position = _previousThreatPosition;
				Message("ToSetThreat", threat);
			}
		}

		private void removeFromMemory(Actor actor)
		{
			int num = 0;
			while (true)
			{
				if (num < _memory.Count)
				{
					ActorMemory actorMemory = _memory[num];
					if (actorMemory.Actor == actor)
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			_memory.RemoveAt(num);
		}

		private void addToMemory(Actor actor, Vector3 position)
		{
			if (_visible.Contains(actor))
			{
				_visible.Remove(actor);
			}
			ActorMemory actorMemory = default(ActorMemory);
			actorMemory.Actor = actor;
			actorMemory.Position = position;
			actorMemory.Time = Time.timeSinceLevelLoad;
			for (int i = 0; i < _memory.Count; i++)
			{
				ActorMemory actorMemory2 = _memory[i];
				if (actorMemory2.Actor == actor)
				{
					_memory[i] = actorMemory;
					return;
				}
			}
			_memory.Add(actorMemory);
		}

		public void OnSeeDeath(Actor actor)
		{
			if (_visible.Contains(actor))
			{
				_visible.Remove(actor);
			}
			removeFromMemory(actor);
		}

		public void OnSeeActor(Actor actor)
		{
			if (actor.Side != _actor.Side)
			{
				removeFromMemory(actor);
				if (!_visible.Contains(actor))
				{
					_visible.Add(actor);
				}
			}
		}

		public void OnUnseeActor(Actor actor)
		{
			if (actor.Side != _actor.Side)
			{
				addToMemory(actor, actor.transform.position);
			}
		}

		public void OnFriendFoundEnemy(Actor friend)
		{
			BaseBrain component = friend.GetComponent<BaseBrain>();
			if (!(component == null) && component.Threat != null && !_visible.Contains(component.Threat))
			{
				addToMemory(component.Threat, component.LastKnownThreatPosition);
			}
		}
	}
}
