// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterInventory
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class CharacterInventory : MonoBehaviour
	{
		[Tooltip("All the weapons belonging in the inventory.")]
		public WeaponDescription[] Weapons;

		private void Awake()
		{
			CharacterMotor component = GetComponent<CharacterMotor>();
			for (int i = 0; i < Weapons.Length; i++)
			{
				WeaponDescription weaponDescription = Weapons[i];
				if (weaponDescription.RightItem != null && (!component.IsEquipped || component.Weapon.RightItem != weaponDescription.RightItem))
				{
					weaponDescription.RightItem.SetActive(value: false);
				}
				if (weaponDescription.RightHolster != null && (!component.IsEquipped || component.Weapon.RightHolster != weaponDescription.RightHolster))
				{
					weaponDescription.RightHolster.SetActive(value: true);
				}
				if (weaponDescription.LeftItem != null && (!component.IsEquipped || component.Weapon.LeftItem != weaponDescription.LeftItem))
				{
					weaponDescription.LeftItem.SetActive(value: false);
				}
				if (weaponDescription.LeftHolster != null && (!component.IsEquipped || component.Weapon.LeftHolster != weaponDescription.LeftHolster))
				{
					weaponDescription.LeftHolster.SetActive(value: true);
				}
				if (weaponDescription.Shield != null && (!component.IsEquipped || component.Weapon.Shield != weaponDescription.Shield))
				{
					weaponDescription.Shield.SetActive(value: false);
				}
			}
		}
	}
}
