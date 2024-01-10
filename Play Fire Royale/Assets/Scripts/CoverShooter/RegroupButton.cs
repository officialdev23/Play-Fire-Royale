// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.RegroupButton
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class RegroupButton : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		protected override void OnPress()
		{
			if (Switcher == null)
			{
				return;
			}
			for (int i = 0; i < Switcher.Characters.Length; i++)
			{
				Actor actor = Switcher.Characters[i];
				if (!(actor == null) && i != Switcher.Active)
				{
					actor.SendMessage("ToStopActions", SendMessageOptions.DontRequireReceiver);
					actor.SendMessage("ToRegroupFormation");
				}
			}
		}
	}
}
