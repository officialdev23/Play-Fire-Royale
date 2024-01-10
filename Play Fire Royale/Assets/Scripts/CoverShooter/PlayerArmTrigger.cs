// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.PlayerArmTrigger
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class PlayerArmTrigger : MonoBehaviour
	{
		[Tooltip("Weapon to arm. Index starts at one. Value of 0 means none. ")]
		public int WeaponToUse = 1;

		[Tooltip("Trigger is ignored if the player already has a weapon. When UseForce is enabled the player always switches to the new weapon.")]
		public bool UseForce;

		private void OnTriggerEnter(Collider other)
		{
			CharacterMotor component = other.GetComponent<CharacterMotor>();
			if (component == null)
			{
				return;
			}
			CharacterInventory component2 = other.GetComponent<CharacterInventory>();
			if (!(component2 == null))
			{
				if (WeaponToUse > 0 && WeaponToUse <= component2.Weapons.Length)
				{
					component.Weapon = component2.Weapons[WeaponToUse - 1];
					component.IsEquipped = true;
				}
				else
				{
					component.IsEquipped = false;
				}
			}
		}
	}
}
