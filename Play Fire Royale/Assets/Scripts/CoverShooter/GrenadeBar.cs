// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GrenadeBar
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[ExecuteInEditMode]
	public class GrenadeBar : PressButton
	{
		[Tooltip("Motor which will be assigned to use grenades when pressed.")]
		public CharacterMotor Motor;

		[Tooltip("Determines if the ammo bar is hidden when there is no target.")]
		public bool HideWhenNone;

		[Tooltip("Link to the object that draws the background of the ammo bar.")]
		public RectTransform BackgroundRect;

		[Tooltip("Link to the icon object.")]
		public RectTransform Icon;

		[Tooltip("Link to the object that will be used to display a gun's name.")]
		public Text Name;

		[Tooltip("Color to use on elements when the gun is selected.")]
		public Color ActiveColor = Color.white;

		[Tooltip("Color to use on elements when the gun is not selected.")]
		public Color InactiveColor = new Color(1f, 1f, 1f, 0.6f);

		protected override void OnPress()
		{
			if (Motor != null && !Motor.HasGrenadeInHand)
			{
				Motor.InputTakeGrenade();
			}
		}

		private void LateUpdate()
		{
			if (Application.isPlaying)
			{
				bool isVisible = !HideWhenNone || Motor != null;
				updateElement(BackgroundRect, isVisible);
				updateElement(Icon, isVisible);
				updateElement(Name, isVisible);
			}
		}

		private void updateElement(RectTransform obj, bool isVisible)
		{
			if (obj == null)
			{
				return;
			}
			if (obj.gameObject.activeSelf != isVisible)
			{
				obj.gameObject.SetActive(isVisible);
			}
			if (isVisible)
			{
				Image component = obj.GetComponent<Image>();
				if (Motor != null)
				{
					component.color = ((!Motor.HasGrenadeInHand) ? InactiveColor : ActiveColor);
				}
			}
		}

		private void updateElement(Text obj, bool isVisible)
		{
			if (!(obj == null) && obj.gameObject.activeSelf != isVisible)
			{
				obj.gameObject.SetActive(isVisible);
			}
		}
	}
}
