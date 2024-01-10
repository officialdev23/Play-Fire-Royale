// DecompilerFi decompiler from Assembly-CSharp.dll class: AIGrenadeSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AIGrenadeSettings
	{
		[Tooltip("Number of grenades the AI will throw.")]
		public int GrenadeCount;

		[Tooltip("Time in seconds since becoming alerted to wait before throwing a grenade.")]
		public float FirstCheckDelay;

		[Tooltip("AI will only throw a grenade if it can hit the enemy. CheckInterval defines the time between checks.")]
		public float CheckInterval;

		[Tooltip("Time in seconds to wait before throwing a grenade after already having thrown one.")]
		public float Interval;

		[Tooltip("Maximum allowed distance between a landed grenade and the enemy. Throws with greater result distance are cancelled.")]
		public float MaxRadius;

		[Tooltip("Distance to maintain against grenades.")]
		public float AvoidDistance;

		public static AIGrenadeSettings Default()
		{
			AIGrenadeSettings result = default(AIGrenadeSettings);
			result.GrenadeCount = 1;
			result.FirstCheckDelay = 5f;
			result.Interval = 10f;
			result.CheckInterval = 2f;
			result.MaxRadius = 5f;
			result.AvoidDistance = 8f;
			return result;
		}
	}
}
