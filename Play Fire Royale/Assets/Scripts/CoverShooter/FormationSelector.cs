// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.FormationSelector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class FormationSelector : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Formation to be formed when this button is active.")]
		public FormationType Formation;

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
					component.Formation = Formation;
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
