// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ShieldAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class ShieldAction : InstantAction
	{
		[Tooltip("Shield object to be activated.")]
		public GameObject Shield;

		[Tooltip("Associated UI color.")]
		public Color Color = Color.blue;

		public override Color UIColor => Color;

		public override bool CanTargetSelf => true;

		public ShieldAction()
		{
			Cooldown = 12f;
		}

		public override bool IsNeededFor(Actor target)
		{
			return target == _actor && _actor.Threat != null && _actor.Threat.IsAlive;
		}

		protected override void Perform()
		{
			if (Shield != null)
			{
				if (Shield.activeSelf)
				{
					Shield.SetActive(value: false);
				}
				Shield.SetActive(value: true);
			}
		}
	}
}
