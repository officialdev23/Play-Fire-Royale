// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AICopCall
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AICopCall : AIBase
	{
		[Tooltip("A chance that a call will be made.")]
		[Range(0f, 1f)]
		public float CallChance = 0.7f;

		[Tooltip("Can the civilian make a call while fleeing the scene.")]
		public bool CanCallWhenFleeing = true;

		[Tooltip("Will the civilian flee after making a call.")]
		public bool FleeAfterCall = true;

		[Tooltip("Time in seconds after being alerted to make a call.")]
		public float MinCallDelay = 4f;

		[Tooltip("Time in seconds after being alerted to make a call.")]
		public float MaxCallDelay = 5f;

		[Tooltip("Target object and a message sent during a call.")]
		public AICall Call = AICall.Default();

		private Actor _actor;

		private bool _isScared;

		private bool _isWaitingForCall;

		private bool _willMakeCall;

		private float _delay;

		public void ToBecomeScared()
		{
			if (!CanCallWhenFleeing)
			{
				_willMakeCall = false;
			}
			_isScared = true;
		}

		public void OnCallMade()
		{
			if (_isWaitingForCall && base.isActiveAndEnabled)
			{
				_isWaitingForCall = false;
				Call.Make(_actor);
				Message("OnCopCall");
				if (FleeAfterCall)
				{
					Message("ToBecomeScared");
				}
			}
		}

		public void OnAlarmed()
		{
			if (!_isScared || CanCallWhenFleeing)
			{
				_willMakeCall = (Random.Range(0f, 1f) <= CallChance);
				if (_willMakeCall)
				{
					_delay = Random.Range(MinCallDelay, MaxCallDelay);
				}
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
		}

		private void Update()
		{
			if (_actor.IsAlive && _willMakeCall)
			{
				if (_delay <= float.Epsilon)
				{
					_willMakeCall = false;
					_isWaitingForCall = true;
					Message("ToMakeCall");
				}
				else
				{
					_delay -= Time.deltaTime;
				}
			}
		}
	}
}
