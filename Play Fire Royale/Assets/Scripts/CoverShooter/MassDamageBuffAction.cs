// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MassDamageBuffAction
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public class MassDamageBuffAction : AnimatedMassAction
	{
		public float Multiplier = 2f;

		public float Duration = 6f;

		public bool Outlines = true;

		public override bool CanTargetAlly => Multiplier > 1f;

		public override bool CanTargetSelf => Multiplier > 1f;

		public override bool CanTargetEnemy => Multiplier < 1f;

		protected override string Process => "MassSupport";

		public override bool IsNeededFor(Actor target)
		{
			DamageBuff component = target.GetComponent<DamageBuff>();
			if (component != null && component.enabled)
			{
				return false;
			}
			return target.Threat != null && target.Threat.IsAlive;
		}

		protected override void Perform(Actor target)
		{
			DamageBuff damageBuff = target.GetComponent<DamageBuff>();
			if (damageBuff == null || damageBuff.enabled)
			{
				damageBuff = target.gameObject.AddComponent<DamageBuff>();
			}
			damageBuff.Duration = Duration;
			damageBuff.Multiplier = Multiplier;
			damageBuff.Outline = Outlines;
			damageBuff.OutlineColor = Color;
			damageBuff.Launch();
		}
	}
}
