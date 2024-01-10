// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AmmoBar
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[ExecuteInEditMode]
	public class AmmoBar : PressButton
	{
		[Tooltip("Gun object whose ammo is displayed on the ammo bar.")]
		public BaseGun Target;

		[Tooltip("Motor which will be assigned the weapon when pressed.")]
		public CharacterMotor Motor;

		[Range(0f, 1f)]
		[Tooltip("Current value of the ammo bar.")]
		public float Value = 1f;

		[Tooltip("Determines if the ammo bar is hidden when there is no target.")]
		public bool HideWhenNone;

		[Tooltip("Link to the object that draws the background of the ammo bar.")]
		public RectTransform BackgroundRect;

		[Tooltip("Link to the object that draws the ammo bar.")]
		public RectTransform FillRect;

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
			if (!(Motor != null))
			{
				return;
			}
			CharacterInventory component = Motor.GetComponent<CharacterInventory>();
			int num = 0;
			while (true)
			{
				if (num < component.Weapons.Length)
				{
					if (component.Weapons[num].Gun == Target)
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			Motor.InputCancelGrenade();
			Motor.Weapon = component.Weapons[num];
			Motor.IsEquipped = true;
		}

		private void LateUpdate()
		{
			if (Target != null)
			{
				if (Target != null)
				{
					Value = Target.LoadPercentage;
				}
				if (Name != null)
				{
					Name.text = Target.name;
				}
			}
			if (FillRect != null)
			{
				FillRect.anchorMax = new Vector2(Value, 1f);
			}
			if (Application.isPlaying)
			{
				bool isVisible = !HideWhenNone || Target != null;
				updateElement(FillRect, isVisible);
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
					component.color = ((!(Motor.EquippedWeapon.Gun == Target) || Motor.HasGrenadeInHand) ? InactiveColor : ActiveColor);
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
