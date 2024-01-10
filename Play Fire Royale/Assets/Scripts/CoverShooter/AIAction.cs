// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public abstract class AIAction : ScriptableObject
	{
		[Tooltip("Is the action performed automatically by the AI. Actions without any possible targets (like simple movement) won't be performed.")]
		public bool Auto;

		[Tooltip("Time in seconds to wait after activation before the action can be performed again.")]
		public float Cooldown = 1f;

		protected Actor _actor;

		protected Actor _targetActor;

		protected Vector3 _targetPosition;

		private float _executionTime = -10000f;

		public bool CanTargetAny => CanTargetEnemy || CanTargetAlly;

		public bool NeedsTargetLocation => CanTargetGround;

		public bool NeedsOnlySelf => CanTargetSelf && !NeedsSingleTargetActor;

		public bool NeedsSingleTargetActor => CanTargetAny && !CanTargetMultiple && !NeedsTargetLocation;

		public float Wait => Cooldown - Mathf.Clamp(Time.timeSinceLevelLoad - _executionTime, 0f, Cooldown);

		public virtual bool CanTargetSelf => false;

		public virtual bool CanTargetEnemy => false;

		public virtual bool CanTargetAlly => false;

		public virtual bool ShouldIgnoreDead => true;

		public virtual bool CanTargetGround => false;

		public virtual bool CanTargetMultiple => false;

		public virtual bool HasNoTimeout => false;

		public virtual float UIRadius => 0f;

		public abstract Color UIColor
		{
			get;
		}

		public void SetupActor(Actor actor)
		{
			_actor = actor;
		}

		public bool Execute(Actor actor)
		{
			_actor = actor;
			_targetActor = null;
			return Start();
		}

		public bool Execute(Actor actor, Vector3 position)
		{
			_actor = actor;
			_targetActor = null;
			_targetPosition = position;
			return Start();
		}

		public bool Execute(Actor actor, Actor target)
		{
			_actor = actor;
			_targetActor = target;
			return Start();
		}

		public virtual bool IsNeededFor(Actor target)
		{
			return false;
		}

		public virtual bool OnFinishAction()
		{
			return false;
		}

		public virtual bool OnThrow()
		{
			return false;
		}

		protected void MarkCooldown()
		{
			_executionTime = Time.timeSinceLevelLoad;
		}

		protected abstract bool Start();

		public abstract bool Update();

		public abstract void Stop();

		public virtual bool WillMoveForActor(Actor target)
		{
			return false;
		}

		public virtual bool WillMoveForPosition(Vector3 target)
		{
			return false;
		}
	}
}
