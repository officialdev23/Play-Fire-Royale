// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HealAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class HealAction : AnimatedActorAction
	{
		public float Amount = 100f;

		[Range(0f, 1f)]
		public float AutoTriggerHealth = 0.6f;

		public bool Outlines = true;

		public float OutlineDuration = 1f;

		[Tooltip("Will the AI only consider helping allies under cover.")]
		public bool AutoHelpOnlyCovered;

		public override bool CanTargetAlly => true;

		public override bool CanTargetSelf => true;

		public override bool CanTargetEnemy => false;

		protected override string Process => "GiveHeal";

		public override bool ShouldIgnoreDead => false;

		public override bool IsNeededFor(Actor target)
		{
			CharacterHealth component = target.GetComponent<CharacterHealth>();
			return component != null && (!target.IsAlive || component.Health < component.MaxHealth * AutoTriggerHealth) && (!AutoHelpOnlyCovered || target.Cover != null);
		}

		protected override void Perform()
		{
			if (!_targetMotor.IsAlive)
			{
				_targetMotor.InputResurrect();
			}
			_targetMotor.SendMessage("Heal", Amount);
			if (Outlines)
			{
				TempOutline tempOutline = _targetActor.gameObject.AddComponent<TempOutline>();
				tempOutline.OutlineColor = Color;
				tempOutline.Duration = OutlineDuration;
				tempOutline.Launch();
			}
		}
	}
}
