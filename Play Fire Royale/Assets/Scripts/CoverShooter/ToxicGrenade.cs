// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ToxicGrenade
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ToxicGrenade : Grenade
	{
		[Tooltip("How much the targets damage is multiplied while the buff is active.")]
		public float DamageMultiplier = 0.5f;

		[Tooltip("Duration of the damage buff applied to the target.")]
		public float Duration = 6f;

		public ToxicGrenade()
		{
			CenterDamage = 0f;
		}

		protected override void Apply(GameObject target, Vector3 position, Vector3 normal, float fraction)
		{
			base.Apply(target, position, normal, fraction);
			CharacterMotor component = target.GetComponent<CharacterMotor>();
			if (!(component == null))
			{
				DamageBuff damageBuff = target.GetComponent<DamageBuff>();
				if (damageBuff == null || damageBuff.enabled)
				{
					damageBuff = target.gameObject.AddComponent<DamageBuff>();
				}
				damageBuff.Duration = Duration;
				damageBuff.Multiplier = DamageMultiplier;
				damageBuff.Launch();
			}
		}
	}
}
