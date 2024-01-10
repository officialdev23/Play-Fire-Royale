// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MassArmorBuffAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class MassArmorBuffAction : AnimatedMassAction
	{
		public float Multiplier = 0.5f;

		public float Duration = 6f;

		public bool Outline = true;

		[Range(0f, 1f)]
		public float AutoTriggerHealth = 0.6f;

		public override bool CanTargetAlly => Multiplier < 1f;

		public override bool CanTargetSelf => Multiplier < 1f;

		public override bool CanTargetEnemy => Multiplier > 1f;

		protected override string Process => "MassSupport";

		public override bool IsNeededFor(Actor target)
		{
			ArmorBuff component = target.GetComponent<ArmorBuff>();
			if (component != null && component.enabled)
			{
				return false;
			}
			CharacterHealth component2 = target.GetComponent<CharacterHealth>();
			return component2 != null && component2.Health < component2.MaxHealth * AutoTriggerHealth;
		}

		protected override void Perform(Actor target)
		{
			ArmorBuff armorBuff = target.GetComponent<ArmorBuff>();
			if (armorBuff == null || armorBuff.enabled)
			{
				armorBuff = target.gameObject.AddComponent<ArmorBuff>();
			}
			armorBuff.Duration = Duration;
			armorBuff.Multiplier = Multiplier;
			armorBuff.Outline = Outline;
			armorBuff.OutlineColor = Color;
			armorBuff.Launch();
		}
	}
}
