// DecompilerFi decompiler from Assembly-CSharp.dll class: SquareFormationSettings
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public struct SquareFormationSettings
	{
		public float Distance;

		public static SquareFormationSettings Default()
		{
			SquareFormationSettings result = default(SquareFormationSettings);
			result.Distance = 1.5f;
			return result;
		}
	}
}
