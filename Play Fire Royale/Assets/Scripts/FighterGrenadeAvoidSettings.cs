// DecompilerFi decompiler from Assembly-CSharp.dll class: FighterGrenadeAvoidSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct FighterGrenadeAvoidSettings
	{
		[Tooltip("Time in seconds for AI to react to grenades.")]
		public float ReactionTime;

		[Tooltip("Time in seconds to keep running from a threatening grenade.")]
		public float Duration;

		public static FighterGrenadeAvoidSettings Default()
		{
			FighterGrenadeAvoidSettings result = default(FighterGrenadeAvoidSettings);
			result.ReactionTime = 1f;
			result.Duration = 2f;
			return result;
		}
	}
}
