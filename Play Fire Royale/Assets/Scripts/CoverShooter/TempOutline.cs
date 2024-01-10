// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TempOutline
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class TempOutline : BaseBuff
	{
		public TempOutline()
		{
			Outline = true;
		}

		protected override void Begin()
		{
		}

		protected override void End()
		{
			UnityEngine.Object.Destroy(this);
		}
	}
}
