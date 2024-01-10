// DecompilerFi decompiler from Assembly-CSharp.dll class: FighterInvestigationWaitSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct FighterInvestigationWaitSettings
	{
		[Tooltip("Time in seconds to wait before going to inspect last seen covered enemy position.")]
		public float WaitForCovered;

		[Tooltip("Time in seconds to wait before going to inspect last seen uncovered enemy position.")]
		public float WaitForUncovered;

		public static FighterInvestigationWaitSettings Default()
		{
			FighterInvestigationWaitSettings result = default(FighterInvestigationWaitSettings);
			result.WaitForCovered = 10f;
			result.WaitForUncovered = 10f;
			return result;
		}
	}
}
