// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.EquipBar
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[ExecuteInEditMode]
	public class EquipBar : PressButton
	{
		[Tooltip("Gun oject that is selected.")]
		public GameObject Target;

		[Tooltip("Motor which will be assigned the weapon when pressed.")]
		public CharacterMotor Motor;

		[Tooltip("Determines if the bar is hidden when there is no target.")]
		public bool HideWhenNone;

		[Tooltip("Link to the object that draws the background of the ammo bar.")]
		public RectTransform BackgroundRect;

		[Tooltip("Link to the icon objects.")]
		public RectTransform[] Icons;

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
					if (component.Weapons[num].RightItem == Target || component.Weapons[num].LeftItem == Target)
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
			if (Target != null && Name != null)
			{
				Name.text = Target.name;
			}
			if (!Application.isPlaying)
			{
				return;
			}
			bool isVisible = !HideWhenNone || Target != null;
			updateElement(BackgroundRect, isVisible);
			updateElement(Name, isVisible);
			if (Icons != null)
			{
				for (int i = 0; i < Icons.Length; i++)
				{
					updateElement(Icons[i], isVisible);
				}
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
			if (!isVisible)
			{
				return;
			}
			Image component = obj.GetComponent<Image>();
			if (!(Motor != null))
			{
				return;
			}
			Image image = component;
			WeaponDescription equippedWeapon = Motor.EquippedWeapon;
			if (!(equippedWeapon.RightItem == Target))
			{
				WeaponDescription equippedWeapon2 = Motor.EquippedWeapon;
				if (!(equippedWeapon2.LeftItem == Target))
				{
					goto IL_00aa;
				}
			}
			if (Motor.HasGrenadeInHand)
			{
				goto IL_00aa;
			}
			Color color = ActiveColor;
			goto IL_00b0;
			IL_00aa:
			color = InactiveColor;
			goto IL_00b0;
			IL_00b0:
			image.color = color;
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
