// DecompilerFi decompiler from Assembly-CSharp.dll class: GunRecoilSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct GunRecoilSettings
	{
		[Tooltip("Degrees the aim is shifted up after firing the gun.")]
		public float Vertical;

		[Tooltip("Degrees to the right the aim is shifted after firing the gun.")]
		public float Horizontal;

		[Tooltip("How easy it is for the motor to recover after recoil. Multiplies their recovery rate.")]
		public float RecoveryRate;

		[Tooltip("Intensity of the camera shake following a gun fire.")]
		public float ShakeIntensity;

		[Tooltip("Duration of the camera shake following a gun fire.")]
		public float ShakeTime;

		public static GunRecoilSettings Default()
		{
			GunRecoilSettings result = default(GunRecoilSettings);
			result.Vertical = 1.5f;
			result.Horizontal = 0.25f;
			result.RecoveryRate = 1f;
			result.ShakeIntensity = 1f;
			result.ShakeTime = 0.25f;
			return result;
		}
	}
}
