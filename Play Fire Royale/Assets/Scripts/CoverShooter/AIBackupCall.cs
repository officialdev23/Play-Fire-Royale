// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIBackupCall
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	public class AIBackupCall : AIBase
	{
		[Tooltip("Target object and a message sent during a call.")]
		public AICall Call = AICall.Default();

		[Tooltip("Should the AI only call when in cover.")]
		public bool OnlyCallInCover = true;

		[Tooltip("A call is triggered if the number of nearby friends is equal or lower than this value.")]
		public int FriendCount;

		[Tooltip("Time in seconds after alerts before the number of friends is first being checked.")]
		public float FirstCheckDelay = 3f;

		[Tooltip("Time in seconds to keep checking the number of friends before making the call.")]
		public float CheckDuration = 2f;

		[Tooltip("Time in seconds to wait after a call before returning to checking again.")]
		public float CheckSpacing = 10f;

		[Tooltip("Do not call if the whole level contains enough friends already. Distance is ignored.")]
		public int MaxLevelCount = 6;

		private Actor _actor;

		private CharacterMotor _motor;

		private bool _canCall;

		private float _firstTriggerWait;

		private float _triggerWait;

		private float _triggerSpacing;

		private HashSet<Actor> _visibleFriends = new HashSet<Actor>();

		private HashSet<Actor> _nearbyFriends = new HashSet<Actor>();

		private bool _isWaitingForCall;

		public void OnAlarmed()
		{
			if (!_canCall)
			{
				_triggerWait = 0f;
				_triggerSpacing = 0f;
			}
			_canCall = true;
		}

		public void OnCallMade()
		{
			if (_isWaitingForCall && base.isActiveAndEnabled)
			{
				_isWaitingForCall = false;
				Call.Make(_actor);
				Message("OnBackupCall");
			}
		}

		public void OnFoundFriend(Actor friend)
		{
			_nearbyFriends.Add(friend);
		}

		public void OnLostFriend(Actor friend)
		{
			_nearbyFriends.Remove(friend);
		}

		public void OnSeeActor(Actor actor)
		{
			if (actor.Side == _actor.Side && actor.IsAggressive)
			{
				_visibleFriends.Add(actor);
			}
		}

		public void OnUnseeActor(Actor actor)
		{
			if (actor.Side == _actor.Side && actor.IsAggressive)
			{
				_visibleFriends.Remove(actor);
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		private void Update()
		{
			if (!_actor.IsAlive || !_canCall)
			{
				return;
			}
			if (_firstTriggerWait < FirstCheckDelay)
			{
				_firstTriggerWait += Time.deltaTime;
				return;
			}
			if (_triggerSpacing >= float.Epsilon)
			{
				_triggerSpacing -= Time.deltaTime;
				return;
			}
			int num = _nearbyFriends.Count;
			foreach (Actor visibleFriend in _visibleFriends)
			{
				if (!_nearbyFriends.Contains(visibleFriend))
				{
					num++;
				}
			}
			if (num <= FriendCount)
			{
				int num2 = 0;
				for (int i = 0; i < Actors.Count; i++)
				{
					Actor actor = Actors.Get(i);
					if (actor.IsAlive && actor.Side == _actor.Side && actor.IsAggressive)
					{
						num2++;
					}
				}
				if (num2 < MaxLevelCount)
				{
					if (_triggerWait >= CheckDuration)
					{
						if (!OnlyCallInCover || _motor.IsInCover)
						{
							_triggerWait = 0f;
							_triggerSpacing = CheckSpacing;
							_isWaitingForCall = true;
							Message("ToMakeCall");
						}
					}
					else
					{
						_triggerWait += Time.deltaTime;
					}
				}
				else
				{
					_triggerWait = 0f;
				}
			}
			else
			{
				_triggerWait = 0f;
			}
		}
	}
}
