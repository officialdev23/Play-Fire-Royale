// DecompilerFi decompiler from Assembly-CSharp.dll class: AITargetSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AITargetSettings
	{
		[Tooltip("Minimum possible position going from the feet up that the AI is aiming at. Value of 0 means feet, value of 1 means top of the head.")]
		[Range(0f, 1f)]
		public float Min;

		[Tooltip("Maximum possible position going from the feet up that the AI is aiming at. Value of 0 means feet, value of 1 means top of the head.")]
		[Range(0f, 1f)]
		public float Max;

		public AITargetSettings(float min, float max)
		{
			Min = min;
			Max = max;
		}
	}
}
