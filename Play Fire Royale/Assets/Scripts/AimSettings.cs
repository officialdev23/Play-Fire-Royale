// DecompilerFi decompiler from Assembly-CSharp.dll class: AimSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AimSettings
	{
		[Tooltip("Maximum allowed angle between aim direction and body direction.")]
		public float MaxAimAngle;

		[Tooltip("Accuracy error when walking.")]
		public float WalkError;

		[Tooltip("Accuracy error when running.")]
		public float RunError;

		[Tooltip("Accuracy error when sprinting.")]
		public float SprintError;

		public static AimSettings Default()
		{
			AimSettings result = default(AimSettings);
			result.MaxAimAngle = 60f;
			result.WalkError = 2.5f;
			result.RunError = 4f;
			result.SprintError = 6f;
			return result;
		}
	}
}
