// DecompilerFi decompiler from Assembly-CSharp.dll class: FighterRetreatSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct FighterRetreatSettings
	{
		[Tooltip("Health value at which the AI will retreat.")]
		public float Health;

		[Tooltip("Duration in seconds the frightened AI will wait and hide in cover before peeking again.")]
		public float HideDuration;

		public static FighterRetreatSettings Default()
		{
			FighterRetreatSettings result = default(FighterRetreatSettings);
			result.Health = 25f;
			result.HideDuration = 3f;
			return result;
		}
	}
}
