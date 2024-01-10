// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Radio
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Radio : Tool
	{
		public Radio()
		{
			HasAiming = false;
			IsContinuous = false;
			HasAlternateAiming = false;
			IsAlternateContinuous = false;
		}

		public override void Use(CharacterMotor character, bool isAlternate)
		{
			if (!isAlternate)
			{
				character.SendMessage("OnCallMade", SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
