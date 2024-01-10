// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SmokeGrenade
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class SmokeGrenade : Grenade
	{
		[Tooltip("Distance multiplier for characters affected by the grenade.")]
		public float VisionMultiplier = 0.1f;

		[Tooltip("Duration of the buff applied to affected characters.")]
		public float Duration = 6f;

		public SmokeGrenade()
		{
			CenterDamage = 0f;
		}

		protected override void Apply(GameObject target, Vector3 position, Vector3 normal, float fraction)
		{
			base.Apply(target, position, normal, fraction);
			CharacterMotor component = target.GetComponent<CharacterMotor>();
			if (!(component == null))
			{
				VisionBuff visionBuff = target.GetComponent<VisionBuff>();
				if (visionBuff == null || visionBuff.enabled)
				{
					visionBuff = target.gameObject.AddComponent<VisionBuff>();
				}
				visionBuff.Duration = Duration;
				visionBuff.Multiplier = VisionMultiplier;
				visionBuff.Launch();
			}
		}
	}
}
