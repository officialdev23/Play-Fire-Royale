// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseTab
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class BaseTab : PressButton
	{
		[Tooltip("Object to activate when the tab is on.")]
		public GameObject Object;

		[Tooltip("Objects that are activated when the tab is active.")]
		public GameObject[] Active;

		[Tooltip("Objects that are activated when the tab is active.")]
		public GameObject[] Inactive;

		[Tooltip("Should the neighbouring objects be disabled when the target object is active.")]
		public bool DeactivateSiblings = true;

		private void Update()
		{
			bool flag = Object != null && Object.activeSelf;
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
			if (!(Object != null))
			{
				return;
			}
			Object.SetActive(value: true);
			if (!DeactivateSiblings || !(Object.transform.parent != null))
			{
				return;
			}
			for (int i = 0; i < Object.transform.parent.childCount; i++)
			{
				Transform child = Object.transform.parent.GetChild(i);
				if (child != Object.transform)
				{
					child.gameObject.SetActive(value: false);
				}
			}
		}
	}
}
