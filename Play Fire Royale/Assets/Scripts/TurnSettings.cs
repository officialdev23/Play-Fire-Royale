// DecompilerFi decompiler from Assembly-CSharp.dll class: TurnSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct TurnSettings
	{
		[Tooltip("How quickly the character model is orientated towards the standing direction.")]
		[Range(0f, 50f)]
		public float StandingRotationSpeed;

		[Tooltip("How quickly the character model is orientated towards the running direction.")]
		[Range(0f, 50f)]
		public float RunningRotationSpeed;

		[Tooltip("How quickly the character model is orientated towards a direction when in melee but not attacking.")]
		[Range(0f, 50f)]
		public float MeleeIdleRotationSpeed;

		[Tooltip("How quickly the character model is orientated towards a direction when in melee.")]
		[Range(0f, 50f)]
		public float MeleeAttackRotationSpeed;

		[Tooltip("How quickly the character model is orientated towards the running direction.")]
		[Range(0f, 50f)]
		public float SprintingRotationSpeed;

		[Tooltip("How quickly the character model is orientated towards the throw direction.")]
		[Range(0f, 50f)]
		public float GrenadeRotationSpeed;

		public static TurnSettings Default()
		{
			TurnSettings result = default(TurnSettings);
			result.StandingRotationSpeed = 5f;
			result.RunningRotationSpeed = 5f;
			result.MeleeIdleRotationSpeed = 7f;
			result.MeleeAttackRotationSpeed = 10f;
			result.SprintingRotationSpeed = 20f;
			result.GrenadeRotationSpeed = 20f;
			return result;
		}
	}
}
