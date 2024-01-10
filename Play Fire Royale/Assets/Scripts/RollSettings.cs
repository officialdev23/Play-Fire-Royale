// DecompilerFi decompiler from Assembly-CSharp.dll class: RollSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct RollSettings
	{
		[Tooltip("Character's capsule height during a roll.")]
		[Range(0f, 10f)]
		public float CapsuleHeight;

		[Tooltip("How fast the character turns towards the roll direction.")]
		public float RotationSpeed;

		public static RollSettings Default()
		{
			RollSettings result = default(RollSettings);
			result.CapsuleHeight = 1f;
			result.RotationSpeed = 10f;
			return result;
		}
	}
}
