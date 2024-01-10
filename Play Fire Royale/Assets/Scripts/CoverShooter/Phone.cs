// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Phone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Phone : Tool
	{
		public Phone()
		{
			HasAiming = false;
			IsContinuous = false;
			HasAlternateAiming = true;
			IsAlternateContinuous = true;
		}

		public override void Use(CharacterMotor character, bool isAlternate)
		{
			if (isAlternate)
			{
				character.SendMessage("OnCallMade", SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
