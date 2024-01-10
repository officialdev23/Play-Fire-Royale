// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DamageBuffAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class DamageBuffAction : AnimatedActorAction
	{
		public float Multiplier = 2f;

		public float Duration = 6f;

		public bool Outlines = true;

		[Tooltip("Will the AI only consider helping allies under cover.")]
		public bool AutoHelpOnlyCovered = true;

		public override bool CanTargetAlly => Multiplier > 1f;

		public override bool CanTargetSelf => Multiplier > 1f;

		public override bool CanTargetEnemy => Multiplier < 1f;

		protected override string Process => "Support";

		public override bool IsNeededFor(Actor target)
		{
			DamageBuff component = target.GetComponent<DamageBuff>();
			if (component != null && component.enabled)
			{
				return false;
			}
			return target.Threat != null && target.Threat.IsAlive && (!AutoHelpOnlyCovered || target.Cover != null);
		}

		protected override void Perform()
		{
			DamageBuff damageBuff = _targetActor.GetComponent<DamageBuff>();
			if (damageBuff == null || damageBuff.enabled)
			{
				damageBuff = _targetActor.gameObject.AddComponent<DamageBuff>();
			}
			damageBuff.Duration = Duration;
			damageBuff.Multiplier = Multiplier;
			damageBuff.Outline = Outlines;
			damageBuff.OutlineColor = Color;
			damageBuff.Launch();
		}
	}
}
