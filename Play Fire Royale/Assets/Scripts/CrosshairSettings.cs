// DecompilerFi decompiler from Assembly-CSharp.dll class: CrosshairSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CrosshairSettings
	{
		[Tooltip("Sprites to be used when drawing the crosshair. Used according to min and max aim angle.")]
		public Sprite[] Sprites;

		[Tooltip("Scale of the drawn sprite.")]
		public float Scale;

		[Tooltip("Aim angle at which the first sprite is drawn.")]
		public float LowAngle;

		[Tooltip("Aim angle at which the last sprite is drawn.")]
		public float HighAngle;

		[Tooltip("Speed at which the crosshair adapts to new sizes.")]
		public float Adaptation;

		[Tooltip("How much to multiply the angle offset produced by camera shaking.")]
		public float ShakeMultiplier;

		[Tooltip("How much to multiply the angle offset produced by recoil.")]
		public float RecoilMultiplier;

		public static CrosshairSettings Default()
		{
			CrosshairSettings result = default(CrosshairSettings);
			result.Sprites = null;
			result.Scale = 1f;
			result.LowAngle = 1.5f;
			result.HighAngle = 10f;
			result.Adaptation = 2f;
			result.ShakeMultiplier = 2f;
			result.RecoilMultiplier = 1f;
			return result;
		}
	}
}
