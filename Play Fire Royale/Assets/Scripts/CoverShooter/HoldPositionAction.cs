// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HoldPositionAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class HoldPositionAction : InstantAction
	{
		[Tooltip("Associated UI color.")]
		public Color Color = Color.white;

		public override Color UIColor => Color;

		public override bool CanTargetGround => true;

		public override bool HasNoTimeout => true;

		public HoldPositionAction()
		{
			Cooldown = 0f;
		}

		protected override void Perform()
		{
			_actor.SendMessage("ToHoldPosition", _targetPosition);
		}
	}
}
