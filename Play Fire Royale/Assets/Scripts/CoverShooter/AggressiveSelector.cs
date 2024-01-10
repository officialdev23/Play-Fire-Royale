// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AggressiveSelector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AggressiveSelector : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Aggressivness value set in the AIFormation component.")]
		public bool Aggressive;

		[Tooltip("Selector object that is activated if the character is selected.")]
		public GameObject Next;

		private void OnEnable()
		{
			if (!(Switcher != null))
			{
				return;
			}
			Actor active = Switcher.GetActive();
			if (active != null)
			{
				AIFormation component = active.GetComponent<AIFormation>();
				if (component != null)
				{
					component.Aggressive = Aggressive;
				}
			}
		}

		protected override void OnPress()
		{
			if (Next != null)
			{
				Next.SetActive(value: true);
				base.gameObject.SetActive(value: false);
			}
		}
	}
}
