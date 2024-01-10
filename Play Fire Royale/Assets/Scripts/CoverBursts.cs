// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverBursts
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CoverBursts
	{
		[Tooltip("Time in seconds to wait in cover for another burst of fire.")]
		public float Wait;

		[Tooltip("Duration in seconds of a burst.")]
		public float Duration;

		[Tooltip("Time in seconds for AI to stand without firing before a burst.")]
		public float IntroDuration;

		[Tooltip("Time in seconds for AI to stand without firing after a burst.")]
		public float OutroDuration;

		public float CycleDuration => Wait + Duration + IntroDuration + OutroDuration;

		public float PeekDuration => Duration + IntroDuration + OutroDuration;

		public static CoverBursts Default()
		{
			CoverBursts result = default(CoverBursts);
			result.Wait = 1f;
			result.Duration = 0.9f;
			result.IntroDuration = 0.35f;
			result.OutroDuration = 0.35f;
			return result;
		}
	}
}
