// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AICommunication
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AICommunication : AIBase
	{
		[Tooltip("Distance in any direction for AI to communicate between each other.")]
		public float Distance = 12f;

		[Tooltip("Time in seconds between each contact update.")]
		public float UpdateDelay = 0.2f;

		[Tooltip("Should lines between friends be drawn in the editor.")]
		public bool DebugFriends;

		private Actor _actor;

		private HashSet<Actor> _stayFriends = new HashSet<Actor>();

		private HashSet<Actor> _friends = new HashSet<Actor>();

		private HashSet<Actor> _oldFriends = new HashSet<Actor>();

		private float _wait;

		private static Dictionary<Actor, AICommunication> _components = new Dictionary<Actor, AICommunication>();

		public IEnumerable<Actor> Friends => _friends;

		public int FriendCount => _friends.Count;

		private void Awake()
		{
			_actor = GetComponent<Actor>();
		}

		private void Update()
		{
			if (!_actor.IsAlive)
			{
				return;
			}
			_wait -= Time.deltaTime;
			if (DebugFriends)
			{
				foreach (Actor friend in _friends)
				{
					if (friend != null)
					{
						UnityEngine.Debug.DrawLine(friend.transform.position, base.transform.position, Color.yellow);
					}
				}
			}
			if (_wait > float.Epsilon)
			{
				return;
			}
			_wait = Random.Range(UpdateDelay * 0.8f, UpdateDelay * 1.2f);
			_oldFriends.Clear();
			foreach (Actor friend2 in _friends)
			{
				if (friend2 != null)
				{
					_oldFriends.Add(friend2);
				}
			}
			_friends.Clear();
			foreach (Actor oldFriend in _oldFriends)
			{
				float num = Vector3.Distance(_actor.transform.position, oldFriend.transform.position);
				if (num < Distance && oldFriend.IsAlive)
				{
					_friends.Add(oldFriend);
				}
				else
				{
					Message("OnLostFriend", oldFriend);
					AICommunication aICommunication = get(oldFriend);
					if (aICommunication != null && aICommunication._friends.Contains(_actor))
					{
						aICommunication._friends.Remove(_actor);
						aICommunication.Message("OnLostFriend", _actor);
					}
				}
			}
			int num2 = Physics.OverlapSphereNonAlloc(_actor.transform.position, Distance, Util.Colliders, Layers.Character, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num2; i++)
			{
				Actor actor = Actors.Get(Util.Colliders[i].gameObject);
				if (!(actor != null) || !(actor != _actor) || !actor.IsAlive || actor.Side != _actor.Side || _oldFriends.Contains(actor))
				{
					continue;
				}
				float num3 = Vector3.Distance(_actor.transform.position, actor.transform.position);
				if (!(num3 < Distance))
				{
					continue;
				}
				AICommunication aICommunication2 = get(actor);
				if (aICommunication2 != null)
				{
					Message("OnFoundFriend", actor);
					_friends.Add(actor);
					aICommunication2._stayFriends.Add(_actor);
					if (!aICommunication2._friends.Contains(_actor))
					{
						aICommunication2._friends.Add(_actor);
						aICommunication2.Message("OnFoundFriend", _actor);
					}
				}
			}
			_stayFriends.Clear();
		}

		private AICommunication get(Actor actor)
		{
			if (!_components.ContainsKey(actor))
			{
				_components[actor] = actor.GetComponent<AICommunication>();
			}
			return _components[actor];
		}
	}
}
