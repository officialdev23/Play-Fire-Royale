// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseDialog
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class BaseDialog : MonoBehaviour
	{
		[Tooltip("Background to activate when the dialog is open.")]
		public GameObject Background;

		private void OnEnable()
		{
			if (Background != null)
			{
				Background.SetActive(value: true);
			}
		}

		private void OnDisable()
		{
			if (Background != null)
			{
				Background.SetActive(value: false);
			}
		}
	}
}
