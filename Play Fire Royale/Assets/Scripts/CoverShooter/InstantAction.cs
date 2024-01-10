// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.InstantAction
// SourcesPostProcessor 
using System;

namespace CoverShooter
{
	[Serializable]
	public abstract class InstantAction : AIAction
	{
		protected override bool Start()
		{
			MarkCooldown();
			Perform();
			return false;
		}

		public override bool Update()
		{
			return false;
		}

		public override void Stop()
		{
		}

		protected abstract void Perform();
	}
}
