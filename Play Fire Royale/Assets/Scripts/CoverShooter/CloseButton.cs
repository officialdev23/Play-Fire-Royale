// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CloseButton
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CloseButton : PressButton
	{
		[Tooltip("Dialog object to deactivate when pressed.")]
		public GameObject Dialog;

		protected override void OnPress()
		{
			if (Dialog != null)
			{
				Dialog.SetActive(value: false);
			}
		}
	}
}
