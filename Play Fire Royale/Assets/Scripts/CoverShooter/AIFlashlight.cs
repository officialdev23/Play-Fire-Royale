// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFlashlight
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIFlashlight : AIItemBase
	{
		private Actor _actor;

		private CharacterMotor _motor;

		private int _darkzoneCount;

		private bool _isUsing;

		public void ToTakeFlashlight()
		{
			if (_motor.Weapon.Flashlight == null || !_motor.IsEquipped)
			{
				Equip(_motor, ToolType.flashlight);
			}
		}

		public void ToHideFlashlight()
		{
			Unequip(_motor, ToolType.flashlight);
			_isUsing = false;
		}

		public void ToTurnOnLight()
		{
			_isUsing = true;
		}

		public void ToLight()
		{
			ToTakeFlashlight();
			_isUsing = true;
		}

		public void ToUnlight()
		{
			_isUsing = false;
		}

		public void OnEnterDarkness(DarkZone zone)
		{
			_darkzoneCount++;
			if (_darkzoneCount == 1)
			{
				Message("OnNeedLight");
			}
		}

		public void OnLeaveDarkness(DarkZone zone)
		{
			_darkzoneCount--;
			if (_darkzoneCount == 0)
			{
				Message("OnDontNeedLight");
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		private void Update()
		{
			if (_actor.IsAlive && !attemptManageMotorFlashlight() && _isUsing && !_motor.IsChangingWeapon && _motor.EquippedWeapon.Flashlight != null)
			{
				_motor.InputUseTool();
			}
		}

		private bool attemptManageMotorFlashlight()
		{
			WeaponDescription equippedWeapon = _motor.EquippedWeapon;
			if (!equippedWeapon.IsNull && equippedWeapon.Gun != null && equippedWeapon.Flashlight != null)
			{
				Flashlight flashlight = equippedWeapon.Flashlight;
				if (_isUsing)
				{
					flashlight.ContinuousUse(_motor, isAlternate: false);
				}
				return true;
			}
			return false;
		}
	}
}
