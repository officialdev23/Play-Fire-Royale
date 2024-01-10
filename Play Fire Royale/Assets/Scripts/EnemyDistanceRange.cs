// DecompilerFi decompiler from Assembly-CSharp.dll class: EnemyDistanceRange
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct EnemyDistanceRange
	{
		[Tooltip("Minimum distance for the enemy to be in zoom range.")]
		public float Min;

		[Tooltip("Maximum distance for the enemy to be in zoom range.")]
		public float Max;

		public EnemyDistanceRange(float min, float max)
		{
			Min = min;
			Max = max;
		}
	}
}
