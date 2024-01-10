// DecompilerFi decompiler from Assembly-CSharp.dll class: FreeRoamOutOfDangerSettings
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public struct FreeRoamOutOfDangerSettings
	{
		public float MaxDistance;

		public float FollowDistance;

		public static FreeRoamOutOfDangerSettings Default()
		{
			FreeRoamOutOfDangerSettings result = default(FreeRoamOutOfDangerSettings);
			result.MaxDistance = 8f;
			result.FollowDistance = 2f;
			return result;
		}
	}
}
