// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TouchMovement
// SourcesPostProcessor 
namespace CoverShooter
{
	public class TouchMovement : TouchBase
	{
		protected override void Update()
		{
			base.Update();
			if (!(Controller == null))
			{
				if (base.Delta.sqrMagnitude > float.Epsilon)
				{
					Controller.HasMovement = true;
					Controller.Movement = base.Delta;
				}
				else
				{
					Controller.HasMovement = false;
				}
			}
		}
	}
}
