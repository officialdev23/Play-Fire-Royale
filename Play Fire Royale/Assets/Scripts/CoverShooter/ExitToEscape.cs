// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ExitToEscape
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

namespace CoverShooter
{
	public class ExitToEscape : MonoBehaviour
	{
		private void LateUpdate()
		{
			if (CF2Input.GetKeyDown(KeyCode.Escape))
			{
				Application.Quit();
			}
		}
	}
}
