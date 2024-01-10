// DecompilerFi decompiler from Assembly-CSharp.dll class: LineFormationSettings
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public struct LineFormationSettings
	{
		public float Distance;

		public static LineFormationSettings Default()
		{
			LineFormationSettings result = default(LineFormationSettings);
			result.Distance = 1f;
			return result;
		}
	}
}
