// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ThreatSelector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ThreatSelector : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Value to set when the button is pressed.")]
		public ThreatPriority Value;

		[Tooltip("Objects that are activated when the setting is active.")]
		public GameObject[] Active;

		[Tooltip("Objects that are activated when the setting is active.")]
		public GameObject[] Inactive;

		private AIThreatControl get()
		{
			if (Switcher == null)
			{
				return null;
			}
			Actor active = Switcher.GetActive();
			if (active == null)
			{
				return null;
			}
			return active.GetComponent<AIThreatControl>();
		}

		private void manage()
		{
			AIThreatControl aIThreatControl = get();
			if (aIThreatControl == null)
			{
				return;
			}
			bool flag = aIThreatControl.Priority == Value;
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

		private void OnEnable()
		{
			manage();
		}

		private void Update()
		{
			manage();
		}

		protected override void OnPress()
		{
			AIThreatControl aIThreatControl = get();
			if (aIThreatControl != null)
			{
				aIThreatControl.Priority = Value;
			}
		}
	}
}
