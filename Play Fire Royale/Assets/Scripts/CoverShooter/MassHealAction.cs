// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MassHealAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class MassHealAction : AnimatedMassAction
	{
		public float Amount = 100f;

		public bool Outlines = true;

		public float OutlineDuration = 1f;

		[Range(0f, 1f)]
		public float AutoTriggerHealth = 0.6f;

		public override bool CanTargetAlly => true;

		public override bool CanTargetSelf => true;

		public override bool CanTargetEnemy => false;

		protected override string Process => "MassSupport";

		public override bool IsNeededFor(Actor target)
		{
			CharacterHealth component = target.GetComponent<CharacterHealth>();
			return component != null && (!target.IsAlive || component.Health < component.MaxHealth * AutoTriggerHealth);
		}

		protected override void Perform(Actor target)
		{
			if (target.Side == _actor.Side)
			{
				CharacterMotor component = target.GetComponent<CharacterMotor>();
				if (!component.IsAlive)
				{
					component.InputResurrect();
				}
				component.SendMessage("Heal", Amount);
				if (Outlines)
				{
					TempOutline tempOutline = target.gameObject.AddComponent<TempOutline>();
					tempOutline.OutlineColor = Color;
					tempOutline.Duration = OutlineDuration;
					tempOutline.Launch();
				}
			}
		}
	}
}
