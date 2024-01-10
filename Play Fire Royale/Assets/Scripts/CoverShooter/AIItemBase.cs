// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIItemBase
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIItemBase : AIBase
	{
		[Tooltip("How should the character inventory (if there is one) be used.")]
		public InventoryUsage InventoryUsage;

		[Tooltip("Weapon index inside the inventory to use when usage is set to 'index'.")]
		public int InventoryIndex;

		private CharacterInventory _inventory;

		protected virtual void Awake()
		{
			_inventory = GetComponent<CharacterInventory>();
		}

		protected bool EquipWeapon(CharacterMotor motor)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				motor.Weapon = _inventory.Weapons[InventoryIndex];
				motor.IsEquipped = true;
				return true;
			}
			if (InventoryUsage == InventoryUsage.autoFind && _inventory != null)
			{
				for (int i = 0; i < _inventory.Weapons.Length; i++)
				{
					if (_inventory.Weapons[i].Gun != null)
					{
						InventoryIndex = i;
						motor.Weapon = _inventory.Weapons[InventoryIndex];
						motor.IsEquipped = true;
						return true;
					}
				}
			}
			if (motor.Weapon.IsNull)
			{
				return false;
			}
			if (motor.Weapon.Gun == null)
			{
				return false;
			}
			motor.IsEquipped = true;
			return true;
		}

		protected bool Equip(CharacterMotor motor, WeaponType type)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				motor.Weapon = _inventory.Weapons[InventoryIndex];
				motor.IsEquipped = true;
				return true;
			}
			if (InventoryUsage == InventoryUsage.autoFind && _inventory != null)
			{
				for (int i = 0; i < _inventory.Weapons.Length; i++)
				{
					if (_inventory.Weapons[i].Gun != null && _inventory.Weapons[i].Gun.Type == type)
					{
						InventoryIndex = i;
						motor.Weapon = _inventory.Weapons[InventoryIndex];
						motor.IsEquipped = true;
						return true;
					}
				}
				for (int j = 0; j < _inventory.Weapons.Length; j++)
				{
					if (_inventory.Weapons[j].Gun != null)
					{
						InventoryIndex = j;
						motor.Weapon = _inventory.Weapons[InventoryIndex];
						motor.IsEquipped = true;
						return true;
					}
				}
			}
			if (motor.Weapon.IsNull)
			{
				return false;
			}
			if (motor.Weapon.Gun == null)
			{
				return false;
			}
			motor.IsEquipped = true;
			return true;
		}

		protected bool Equip(CharacterMotor motor, ToolType tool)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				motor.Weapon = _inventory.Weapons[InventoryIndex];
				motor.IsEquipped = true;
				return true;
			}
			if (InventoryUsage == InventoryUsage.autoFind && _inventory != null)
			{
				for (int i = 0; i < _inventory.Weapons.Length; i++)
				{
					if (!_inventory.Weapons[i].IsNull && _inventory.Weapons[i].Gun == null && _inventory.Weapons[i].ToolType == tool)
					{
						InventoryIndex = i;
						motor.Weapon = _inventory.Weapons[InventoryIndex];
						motor.IsEquipped = true;
						return true;
					}
				}
				for (int j = 0; j < _inventory.Weapons.Length; j++)
				{
					if (!_inventory.Weapons[j].IsNull && _inventory.Weapons[j].ToolType == tool)
					{
						InventoryIndex = j;
						motor.Weapon = _inventory.Weapons[InventoryIndex];
						motor.IsEquipped = true;
						return true;
					}
				}
			}
			if (motor.Weapon.IsNull)
			{
				return false;
			}
			if (motor.Weapon.ToolType != tool)
			{
				return false;
			}
			motor.IsEquipped = true;
			return true;
		}

		protected bool UnequipWeapon(CharacterMotor motor)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				if (_inventory.Weapons[InventoryIndex].IsTheSame(ref motor.Weapon))
				{
					motor.IsEquipped = false;
					return true;
				}
				return false;
			}
			if (motor.Weapon.Gun == null)
			{
				return false;
			}
			motor.IsEquipped = false;
			return true;
		}

		protected bool Unequip(CharacterMotor motor, WeaponType type)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				if (_inventory.Weapons[InventoryIndex].IsTheSame(ref motor.Weapon))
				{
					motor.IsEquipped = false;
					return true;
				}
				return false;
			}
			if (motor.Weapon.Gun == null)
			{
				return false;
			}
			if (motor.Weapon.Gun.Type != type)
			{
				return false;
			}
			motor.IsEquipped = false;
			return true;
		}

		protected bool Unequip(CharacterMotor motor, ToolType tool)
		{
			if (!base.isActiveAndEnabled)
			{
				return false;
			}
			if (InventoryUsage == InventoryUsage.index && _inventory != null && InventoryIndex >= 0 && InventoryIndex < _inventory.Weapons.Length)
			{
				if (_inventory.Weapons[InventoryIndex].IsTheSame(ref motor.Weapon))
				{
					motor.IsEquipped = false;
					return true;
				}
				return false;
			}
			if (motor.Weapon.IsNull)
			{
				return false;
			}
			if (motor.Weapon.ToolType != tool)
			{
				return false;
			}
			motor.IsEquipped = false;
			return true;
		}

		private bool autoFind(CharacterMotor motor, WeaponType type)
		{
			if (_inventory == null)
			{
				return false;
			}
			for (int i = 0; i < _inventory.Weapons.Length; i++)
			{
				if (_inventory.Weapons[i].Gun != null && _inventory.Weapons[i].Gun.Type == type)
				{
					InventoryIndex = i;
					return true;
				}
			}
			for (int j = 0; j < _inventory.Weapons.Length; j++)
			{
				if (_inventory.Weapons[j].Gun != null)
				{
					InventoryIndex = j;
					return true;
				}
			}
			return false;
		}

		private bool autoFind(CharacterMotor motor, ToolType tool)
		{
			if (_inventory == null)
			{
				return false;
			}
			for (int i = 0; i < _inventory.Weapons.Length; i++)
			{
				if (_inventory.Weapons[i].Gun == null && _inventory.Weapons[i].ToolType == tool)
				{
					InventoryIndex = i;
					return true;
				}
			}
			for (int j = 0; j < _inventory.Weapons.Length; j++)
			{
				if (_inventory.Weapons[j].ToolType == tool)
				{
					InventoryIndex = j;
					return true;
				}
			}
			return false;
		}
	}
}
