// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIPhone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class AIPhone : AIItemBase
	{
		private Actor _actor;

		private CharacterMotor _motor;

		private bool _isFilming;

		private bool _wantsToCall;

		public void ToStartFilming()
		{
			if (base.isActiveAndEnabled)
			{
				ToTakePhone();
			}
			_isFilming = true;
		}

		public void ToStopFilming()
		{
			_isFilming = false;
		}

		public void ToTakePhone()
		{
		}

		public void ToHidePhone()
		{
			Unequip(_motor, ToolType.phone);
			_isFilming = false;
		}

		public void ToCall()
		{
			ToStopFilming();
			_wantsToCall = Equip(_motor, ToolType.phone);
			if (_wantsToCall)
			{
				Message("CallResponse");
			}
		}

		public void ToPhoneCall()
		{
			ToStopFilming();
			_wantsToCall = Equip(_motor, ToolType.phone);
			if (_wantsToCall)
			{
				Message("CallResponse");
			}
		}

		public void OnCallMade()
		{
			_wantsToCall = false;
		}

		protected override void Awake()
		{
			base.Awake();
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		private void Update()
		{
			if (_actor.IsAlive && _motor.EquippedWeapon.ToolType == ToolType.phone)
			{
				if (_wantsToCall)
				{
					_motor.InputUseToolAlternate();
				}
				else if (_isFilming)
				{
					_motor.InputUseTool();
				}
			}
		}
	}
}
