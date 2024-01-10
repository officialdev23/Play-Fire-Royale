// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MouseLock
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

namespace CoverShooter
{
	public class MouseLock : MonoBehaviour
	{
		private bool _isLocked = true;

		private void LateUpdate()
		{
			if (CF2Input.GetKeyDown(KeyCode.Escape))
			{
				_isLocked = false;
			}
			if (CF2Input.GetMouseButtonDown(0))
			{
				_isLocked = true;
			}
			if (_isLocked)
			{
				CFCursor.lockState = CursorLockMode.Locked;
				CFCursor.visible = false;
			}
			else
			{
				CFCursor.lockState = CursorLockMode.None;
				CFCursor.visible = true;
			}
		}
	}
}
