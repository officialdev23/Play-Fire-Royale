// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AttackAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class AttackAction : InstantAction
	{
		[Tooltip("Associated UI color.")]
		public Color Color = Color.red;

		public override Color UIColor => Color;

		public override bool CanTargetEnemy => true;

		public override bool HasNoTimeout => true;

		public AttackAction()
		{
			Cooldown = 0f;
		}

		protected override void Perform()
		{
			_actor.SendMessage("ToAttack", _targetActor);
			_actor.SendMessage("ToOverrideThreat", _targetActor);
		}
	}
}
