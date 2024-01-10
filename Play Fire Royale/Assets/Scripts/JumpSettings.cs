// DecompilerFi decompiler from Assembly-CSharp.dll class: JumpSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct JumpSettings
	{
		[Tooltip("Jump up velocity.")]
		[Range(0f, 20f)]
		public float Strength;

		[Tooltip("Jump forward velocity.")]
		[Range(0f, 20f)]
		public float Speed;

		[Tooltip("Character's capsule height during a jump.")]
		[Range(0f, 10f)]
		public float CapsuleHeight;

		[Tooltip("Duration of character's capsule height adjustment.")]
		[Range(0f, 10f)]
		public float HeightDuration;

		[Tooltip("How fast the character turns towards the jump direction.")]
		[Range(0f, 100f)]
		public float RotationSpeed;

		public static JumpSettings Default()
		{
			JumpSettings result = default(JumpSettings);
			result.Strength = 6f;
			result.Speed = 5f;
			result.CapsuleHeight = 1f;
			result.HeightDuration = 0.75f;
			result.RotationSpeed = 50f;
			return result;
		}
	}
}
