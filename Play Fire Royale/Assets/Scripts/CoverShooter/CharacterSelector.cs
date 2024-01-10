// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterSelector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CharacterSelector : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Character index inside the switcher.")]
		public int Index;

		[Tooltip("Objects that are activated when the character is active.")]
		public GameObject[] Active;

		[Tooltip("Objects that are activated when the character is not active.")]
		public GameObject[] Inactive;

		[Tooltip("A dialog object to activate if the character was already selected when pressed.")]
		public GameObject Dialog;

		private void Update()
		{
			if (Switcher == null)
			{
				return;
			}
			bool flag = Switcher.Active == Index;
			for (int i = 0; i < Active.Length; i++)
			{
				if (Active[i] != null && Active[i].activeSelf != flag)
				{
					Active[i].SetActive(flag);
				}
			}
			for (int j = 0; j < Inactive.Length; j++)
			{
				if (Inactive[j] != null && Inactive[j].activeSelf == flag)
				{
					Inactive[j].SetActive(!flag);
				}
			}
		}

		protected override void OnPress()
		{
			if (Switcher != null)
			{
				if (Index == Switcher.Active && Dialog != null)
				{
					Dialog.SetActive(value: true);
				}
				Switcher.Active = Index;
			}
		}
	}
}
