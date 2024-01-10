// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SupportDialog
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class SupportDialog : MonoBehaviour
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Objects that are activated when the current character has the AIProtector component.")]
		public GameObject[] Protector;

		[Tooltip("Objects that are activated when the current character has the AIHealer component.")]
		public GameObject[] Healer;

		[Tooltip("Panel that is activated when the current character has any support component.")]
		public GameObject Panel;

		private void manage()
		{
			if (Switcher == null)
			{
				return;
			}
			Actor active = Switcher.GetActive();
			if (active == null)
			{
				return;
			}
			AIProtector component = active.GetComponent<AIProtector>();
			AIActions aIActions = active.GetComponent<AIActions>();
			if (aIActions != null && !aIActions.HasAllyActions)
			{
				aIActions = null;
			}
			if (component != null)
			{
				if (Panel != null && !Panel.activeSelf)
				{
					Panel.SetActive(value: true);
				}
				activate(Protector, value: true);
				activate(Healer, value: false);
			}
			else if (aIActions != null)
			{
				if (Panel != null && !Panel.activeSelf)
				{
					Panel.SetActive(value: true);
				}
				activate(Protector, value: false);
				activate(Healer, value: true);
			}
			else if (Panel != null && Panel.activeSelf)
			{
				Panel.SetActive(value: false);
			}
		}

		private void OnEnable()
		{
			manage();
		}

		private void Update()
		{
			manage();
		}

		private void activate(GameObject[] objects, bool value)
		{
			for (int i = 0; i < objects.Length; i++)
			{
				if (objects[i] != null && objects[i].activeSelf != value)
				{
					objects[i].SetActive(value);
				}
			}
		}
	}
}
