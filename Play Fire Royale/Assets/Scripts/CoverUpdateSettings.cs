// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverUpdateSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CoverUpdateSettings
	{
		[Tooltip("Cover check delay when idle and not in cover.")]
		public float IdleNonCover;

		[Tooltip("Cover check delay when idle and in cover.")]
		public float IdleCover;

		[Tooltip("Cover check delay when moving outside of cover.")]
		public float MovingNonCover;

		[Tooltip("Cover check delay when moving in cover.")]
		public float MovingCover;

		public static CoverUpdateSettings Default()
		{
			CoverUpdateSettings result = default(CoverUpdateSettings);
			result.IdleNonCover = 10f;
			result.IdleCover = 2f;
			result.MovingNonCover = 0.5f;
			result.MovingCover = 0.1f;
			return result;
		}
	}
}
