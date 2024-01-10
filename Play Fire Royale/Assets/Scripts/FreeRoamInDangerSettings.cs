// DecompilerFi decompiler from Assembly-CSharp.dll class: FreeRoamInDangerSettings
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public struct FreeRoamInDangerSettings
	{
		public float MaxDistance;

		public float FollowDistance;

		public static FreeRoamInDangerSettings Default()
		{
			FreeRoamInDangerSettings result = default(FreeRoamInDangerSettings);
			result.MaxDistance = 4f;
			result.FollowDistance = 2f;
			return result;
		}
	}
}
