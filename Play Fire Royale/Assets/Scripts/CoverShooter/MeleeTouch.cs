// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MeleeTouch
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.EventSystems;

namespace CoverShooter
{
	public class MeleeTouch : PressButton, IPointerDownHandler, IEventSystemHandler
	{
		[Tooltip("Character motor that is instructed to attack.")]
		public CharacterMotor Motor;

		protected override void OnPress()
		{
			if (Motor != null)
			{
				Motor.InputMelee();
			}
		}
	}
}
