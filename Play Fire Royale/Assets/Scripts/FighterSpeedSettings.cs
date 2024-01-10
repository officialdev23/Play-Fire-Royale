// DecompilerFi decompiler from Assembly-CSharp.dll class: FighterSpeedSettings
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public struct FighterSpeedSettings
	{
		public bool Enabled;

		public float Patrol;

		public float TakeCover;

		public float SwitchCover;

		public float RetreatToCover;

		public float Avoid;

		public float Circle;

		public float Assault;

		public float Search;

		public float Investigate;

		public float Flee;

		public static FighterSpeedSettings Default()
		{
			FighterSpeedSettings result = default(FighterSpeedSettings);
			result.Enabled = false;
			result.Patrol = 1f;
			result.TakeCover = 1f;
			result.SwitchCover = 1f;
			result.RetreatToCover = 1f;
			result.Avoid = 1f;
			result.Circle = 1f;
			result.Assault = 1f;
			result.Search = 1f;
			result.Investigate = 1f;
			result.Flee = 1f;
			return result;
		}
	}
}
