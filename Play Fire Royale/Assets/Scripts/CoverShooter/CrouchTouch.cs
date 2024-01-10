// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CrouchTouch
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace CoverShooter
{
	public class CrouchTouch : Text, IPointerDownHandler, IEventSystemHandler
	{
		[Tooltip("Link to the mobile controller that will be set to crouch.")]
		public MobileController Controller;

		private RectTransform _rect;

		protected override void Awake()
		{
			_rect = GetComponent<RectTransform>();
		}

		private void LateUpdate()
		{
			if (!(Controller == null) && !(CameraManager.Main == null))
			{
				Vector3 v = CameraManager.Main.WorldToViewportPoint(Controller.transform.position);
				RectTransform rect = _rect;
				Vector3 localPosition = _rect.localPosition;
				rect.localPosition = new Vector3(0f, 0f, localPosition.z);
				_rect.anchorMin = v;
				_rect.anchorMax = v;
			}
		}

		public void OnPointerDown(PointerEventData data)
		{
			if (Controller != null)
			{
				Controller.IsCrouching = !Controller.IsCrouching;
			}
		}
	}
}
