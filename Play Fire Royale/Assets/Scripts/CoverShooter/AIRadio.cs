// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIRadio
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterMotor))]
	public class AIRadio : AIItemBase
	{
		private Actor _actor;

		private CharacterMotor _motor;

		private bool _wantsToCall;

		public void ToTakeRadio()
		{
			Equip(_motor, ToolType.radio);
		}

		public void ToHideRadio()
		{
			Unequip(_motor, ToolType.radio);
		}

		public void ToCall()
		{
			if (base.isActiveAndEnabled)
			{
				_wantsToCall = Equip(_motor, ToolType.radio);
				if (_wantsToCall)
				{
					Message("CallResponse");
				}
			}
		}

		public void ToRadioCall()
		{
			if (base.isActiveAndEnabled)
			{
				_wantsToCall = Equip(_motor, ToolType.radio);
				if (_wantsToCall)
				{
					Message("CallResponse");
				}
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
			if (_actor.IsAlive && _wantsToCall && _motor.EquippedWeapon.ToolType == ToolType.radio)
			{
				_motor.InputUseTool();
			}
		}
	}
}
