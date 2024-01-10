// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Visibility
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Visibility : MonoBehaviour
	{
		private bool _isVisible;

		public bool IsVisible => _isVisible;

		private void OnBecameVisible()
		{
			_isVisible = true;
		}

		private void OnBecameInvisible()
		{
			_isVisible = false;
		}
	}
}
