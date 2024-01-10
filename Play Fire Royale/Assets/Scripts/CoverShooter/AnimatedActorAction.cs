// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AnimatedActorAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public abstract class AnimatedActorAction : EffectAction
	{
		[Tooltip("Associated UI color.")]
		public Color Color = Color.white;

		[Tooltip("Distance to the target at which the action is performed.")]
		public float Distance = 1f;

		protected CharacterMotor _motor;

		protected CharacterMotor _targetMotor;

		private bool _isAnimating;

		private bool _hasMoveTarget;

		private Vector3 _moveTarget;

		private bool _enteredTargetIntoAProcess;

		public override Color UIColor => Color;

		protected bool StopsTargetActor => false;

		protected abstract string Process
		{
			get;
		}

		public override bool WillMoveForActor(Actor target)
		{
			return Vector3.Distance(_actor.transform.position, target.transform.position) > Distance;
		}

		protected override bool Start()
		{
			_motor = _actor.GetComponent<CharacterMotor>();
			_targetMotor = _targetActor.GetComponent<CharacterMotor>();
			_actor.SendMessage("ToDisarm");
			if (_targetActor.Side == _actor.Side && StopsTargetActor)
			{
				_enteredTargetIntoAProcess = true;
				_targetActor.SendMessage("ToEnterProcess", true);
				_targetActor.SendMessage("ToStopMoving");
			}
			_hasMoveTarget = false;
			return true;
		}

		public override bool Update()
		{
			if (_isAnimating)
			{
				return true;
			}
			if (Vector3.Distance(_actor.transform.position, _targetActor.transform.position) < Distance)
			{
				_actor.SendMessage("ToStopMoving");
				if (StopsTargetActor)
				{
					_targetMotor.InputProcess(new CharacterProcess(null, canAim: true, canMove: false, leaveCover: false));
				}
				MarkCooldown();
				_motor.InputProcess(new CharacterProcess(Process, canAim: false, canMove: false, leaveCover: false));
				_isAnimating = true;
			}
			else
			{
				if (_hasMoveTarget && Vector3.Distance(_moveTarget, _targetActor.transform.position) > Distance)
				{
					_hasMoveTarget = false;
				}
				if (!_hasMoveTarget)
				{
					_hasMoveTarget = true;
					_moveTarget = _targetActor.transform.position;
					_actor.SendMessage("ToRunTo", _moveTarget);
				}
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
			if (StopsTargetActor)
			{
				_targetMotor.InputProcessEnd();
			}
			if (_enteredTargetIntoAProcess)
			{
				_enteredTargetIntoAProcess = false;
				_targetActor.SendMessage("ToExitProcess");
			}
		}

		public override bool OnFinishAction()
		{
			PlayEffect(_targetActor, _targetActor.transform.position);
			Perform();
			return true;
		}

		protected abstract void Perform();
	}
}
