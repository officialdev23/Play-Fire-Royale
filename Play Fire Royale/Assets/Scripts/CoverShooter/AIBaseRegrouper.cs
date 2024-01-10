// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIBaseRegrouper
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public abstract class AIBaseRegrouper : AIBase
	{
		[Tooltip("Maximum distance at which the regrouped actors will stand next to the regrouper.")]
		public float Radius = 8f;

		[Tooltip("Time in seconds the units will maintain their new uncovered positions before searching for better spots.")]
		public float UncoveredDuration = 8f;

		[Tooltip("Distance at which to search for friendly AI that will be regrouped.")]
		public float CallDistance = 20f;

		[Tooltip("Maximum number of regrouped units.")]
		public int Limit = 6;

		private Actor _actor;

		private BaseBrain _brain;

		private List<Actor> _friends = new List<Actor>();

		private List<Vector3> _takenPositions = new List<Vector3>();

		public List<Actor> Friends => _friends;

		protected BaseBrain Brain => _brain;

		protected virtual void Awake()
		{
			_actor = GetComponent<Actor>();
			_brain = GetComponent<BaseBrain>();
		}

		public void TakePosition(Vector3 value)
		{
			_takenPositions.Add(value);
		}

		public bool IsPositionTaken(Vector3 position, float threshold = 1f)
		{
			for (int i = 0; i < _takenPositions.Count; i++)
			{
				if (Vector3.Distance(_takenPositions[i], position) < threshold)
				{
					return true;
				}
			}
			return false;
		}

		public void Regroup()
		{
			_friends.Clear();
			_takenPositions.Clear();
			int num = Physics.OverlapSphereNonAlloc(_actor.transform.position, CallDistance, Util.Colliders, Layers.Character, QueryTriggerInteraction.Ignore);
			int num2 = Limit;
			for (int i = 0; i < num; i++)
			{
				Actor actor = Actors.Get(Util.Colliders[i].gameObject);
				if (!(actor != null) || !(actor != _actor) || !actor.IsAlive || actor.Side != _actor.Side)
				{
					continue;
				}
				float num3 = Vector3.Distance(_actor.transform.position, actor.transform.position);
				if (num3 < CallDistance)
				{
					if (num2 <= 0)
					{
						break;
					}
					num2--;
					actor.SendMessage("ToLeaveCover", SendMessageOptions.DontRequireReceiver);
					_friends.Add(actor);
				}
			}
			for (int j = 0; j < _friends.Count; j++)
			{
				_friends[j].SendMessage("ToRegroupAround", this, SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
