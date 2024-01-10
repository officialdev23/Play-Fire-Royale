// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AnimatedAreaAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public abstract class AnimatedAreaAction : EffectAction
	{
		[Tooltip("Associated UI color.")]
		public Color Color = Color.white;

		[Tooltip("Distance to the target at which the action is performed.")]
		public float Distance = 1f;

		[Tooltip("Effect radius.")]
		public float Radius = 6f;

		protected CharacterMotor _motor;

		private bool _isAnimating;

		private bool _isMoving;

		public override Color UIColor => Color;

		public override bool CanTargetMultiple => true;

		public override bool CanTargetGround => true;

		public override float UIRadius => Radius;

		protected abstract string Process
		{
			get;
		}

		protected override bool Start()
		{
			_motor = _actor.GetComponent<CharacterMotor>();
			_isMoving = false;
			return true;
		}

		public override bool WillMoveForPosition(Vector3 target)
		{
			return Vector3.Distance(_actor.transform.position, target) > Distance + Radius * 0.75f;
		}

		public override bool Update()
		{
			if (_isAnimating)
			{
				return true;
			}
			if (Vector3.Distance(_actor.transform.position, _targetPosition) < Distance)
			{
				_actor.SendMessage("ToStopMoving");
				MarkCooldown();
				_motor.InputProcess(new CharacterProcess(Process, canAim: false, canMove: false, leaveCover: false));
				_isAnimating = true;
			}
			else if (!_isMoving)
			{
				_isMoving = true;
				_actor.SendMessage("ToRunTo", _targetPosition);
			}
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
			int num = AIUtil.FindActorsIncludingDead(_targetPosition, Radius);
			for (int i = 0; i < num; i++)
			{
				PlayEffect(AIUtil.Actors[i], AIUtil.Actors[i].transform.position);
				Perform(AIUtil.Actors[i]);
			}
			return true;
		}

		protected abstract void Perform(Actor target);
	}
}
