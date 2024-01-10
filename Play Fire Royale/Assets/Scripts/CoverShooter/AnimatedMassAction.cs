// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AnimatedMassAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public abstract class AnimatedMassAction : EffectAction
	{
		[Tooltip("Associated UI color.")]
		public Color Color = Color.white;

		protected CharacterMotor _motor;

		private bool _isAnimating;

		public override Color UIColor => Color;

		public override bool CanTargetMultiple => true;

		protected abstract string Process
		{
			get;
		}

		protected override bool Start()
		{
			_motor = _actor.GetComponent<CharacterMotor>();
			return true;
		}

		public override bool Update()
		{
			if (_isAnimating)
			{
				return true;
			}
			_actor.SendMessage("ToStopMoving");
			MarkCooldown();
			_motor.InputProcess(new CharacterProcess(Process, canAim: false, canMove: false, leaveCover: false));
			_isAnimating = true;
			return true;
		}

		public override void Stop()
		{
			if (_isAnimating)
			{
				_motor.InputProcessEnd();
				_isAnimating = false;
			}
		}

		public override bool OnFinishAction()
		{
			for (int i = 0; i < Actors.Count; i++)
			{
				Actor actor = Actors.Get(i);
				bool flag = actor.Side == _actor.Side;
				bool flag2 = actor == _actor;
				if ((!flag2 || CanTargetSelf) && actor.isActiveAndEnabled && ((CanTargetAlly && flag) || (CanTargetEnemy && !flag) || (CanTargetSelf && flag2)))
				{
					PlayEffect(actor, actor.transform.position);
					Perform(actor);
				}
			}
			return true;
		}

		protected abstract void Perform(Actor target);
	}
}
