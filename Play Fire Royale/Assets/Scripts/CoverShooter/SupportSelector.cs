// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SupportSelector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class SupportSelector : PressButton
	{
		[Tooltip("Character switcher whose active character is managed.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Character index inside the switcher.")]
		public int Index;

		[Tooltip("Objects that are activated when the selector is active.")]
		public GameObject[] Active;

		[Tooltip("Objects that are activated when the selector is active.")]
		public GameObject[] Inactive;

		[Tooltip("Default portrait to be displayed.")]
		public GameObject Default;

		[Tooltip("Portrair that's displayed when the index is the active character.")]
		public GameObject Replacement;

		private int index
		{
			get
			{
				if (Switcher != null && Switcher.Active >= Index)
				{
					return Index - 1;
				}
				return Index;
			}
		}

		private void manage()
		{
			if (Switcher == null)
			{
				return;
			}
			bool flag = index == Index;
			if (Default != null && Default.activeSelf != flag)
			{
				Default.SetActive(flag);
			}
			if (Replacement != null && Replacement.activeSelf == flag)
			{
				Replacement.SetActive(!flag);
			}
			bool flag2 = getTarget() == Switcher.Characters[index];
			for (int i = 0; i < Active.Length; i++)
			{
				if (Active[i] != null && Active[i].activeSelf != flag2)
				{
					Active[i].SetActive(flag2);
				}
			}
			for (int j = 0; j < Inactive.Length; j++)
			{
				if (Inactive[j] != null && Inactive[j].activeSelf == flag2)
				{
					Inactive[j].SetActive(!flag2);
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
			if (!(Switcher == null))
			{
				setTarget(Switcher.Characters[index]);
			}
		}

		private Actor getTarget()
		{
			AIProtector actorComponent = getActorComponent<AIProtector>();
			if (actorComponent != null)
			{
				return actorComponent.Target;
			}
			AIActions support = getSupport();
			if (support != null)
			{
				return support.Priority;
			}
			return null;
		}

		private AIActions getSupport()
		{
			AIActions actorComponent = getActorComponent<AIActions>();
			if (actorComponent != null && !actorComponent.HasAllyActions)
			{
				return null;
			}
			return actorComponent;
		}

		private void setTarget(Actor value)
		{
			AIProtector actorComponent = getActorComponent<AIProtector>();
			if (actorComponent != null)
			{
				actorComponent.Target = value;
				return;
			}
			AIActions support = getSupport();
			if (support != null)
			{
				support.Priority = value;
			}
		}

		private T getActorComponent<T>() where T : AIBase
		{
			if (Switcher == null)
			{
				return (T)null;
			}
			Actor active = Switcher.GetActive();
			if (active == null)
			{
				return (T)null;
			}
			return active.GetComponent<T>();
		}
	}
}
