// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TouchAiming
// SourcesPostProcessor 
namespace CoverShooter
{
	public class TouchAiming : TouchBase
	{
		protected override void Update()
		{
			base.Update();
			if (!(Controller == null))
			{
				if (base.Delta.sqrMagnitude > float.Epsilon)
				{
					Controller.IsAllowedToFire = !base.IsCancelled;
					Controller.HasAiming = true;
					Controller.Aiming = base.Delta;
					Controller.Magnitude = base.Magnitude;
				}
				else
				{
					Controller.HasAiming = false;
				}
			}
		}
	}
}
