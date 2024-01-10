// DecompilerFi decompiler from Assembly-CSharp.dll class: Bursts
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct Bursts
	{
		[Tooltip("Time in seconds to wait for another burst of fire.")]
		public float Wait;

		[Tooltip("Duration in seconds of a burst of fire.")]
		public float Duration;

		public float CycleDuration => Wait + Duration;

		public static Bursts Default()
		{
			Bursts result = default(Bursts);
			result.Wait = 0.25f;
			result.Duration = 1f;
			return result;
		}
	}
}
