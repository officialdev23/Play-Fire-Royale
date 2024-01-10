// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AutoActionToggle
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AutoActionToggle : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Action index for the main character.")]
		public int Action;

		[Tooltip("Objects that are activated when the action is automatic.")]
		public GameObject[] Automatic;

		[Tooltip("Objects that are activated when the action is not automatic.")]
		public GameObject[] Manual;

		private void Update()
		{
			AIAction aIAction = get();
			if (aIAction == null)
			{
				return;
			}
			for (int i = 0; i < Automatic.Length; i++)
			{
				if (Automatic[i] != null && Automatic[i].activeSelf != aIAction.Auto)
				{
					Automatic[i].SetActive(aIAction.Auto);
				}
			}
			for (int j = 0; j < Manual.Length; j++)
			{
				if (Manual[j] != null && Manual[j].activeSelf == aIAction.Auto)
				{
					Manual[j].SetActive(!aIAction.Auto);
				}
			}
		}

		private AIAction get()
		{
			if (Switcher == null || Action < 0)
			{
				return null;
			}
			Actor active = Switcher.GetActive();
			if (active == null)
			{
				return null;
			}
			AIActions component = active.GetComponent<AIActions>();
			if (component == null || Action >= component.Actions.Length)
			{
				return null;
			}
			return component.Actions[Action];
		}

		protected override void OnPress()
		{
			AIAction aIAction = get();
			if (aIAction != null)
			{
				aIAction.Auto = !aIAction.Auto;
			}
		}
	}
}
