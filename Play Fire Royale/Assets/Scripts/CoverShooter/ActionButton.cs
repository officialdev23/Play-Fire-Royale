// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ActionButton
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ActionButton : PressButton
	{
		[Tooltip("Character switcher to get the character object from.")]
		public CharacterSwitcher Switcher;

		[Tooltip("Strategy input object that is given a command.")]
		public StrategyInput Strategy;

		[Tooltip("Character index inside the switcher.")]
		public int CharacterIndex;

		[Tooltip("Action to be performed.")]
		public int ActionIndex;

		[Tooltip("UI object whose height is managed during the cooldown. If none a button target graphic is used.")]
		public RectTransform FillOverride;

		protected override void OnPress()
		{
			if (Strategy == null || Switcher == null || CharacterIndex < 0 || CharacterIndex >= Switcher.Characters.Length || Switcher.Characters[CharacterIndex] == null)
			{
				return;
			}
			Actor actor = Switcher.Characters[CharacterIndex];
			if (!(actor != null))
			{
				return;
			}
			AIActions component = actor.GetComponent<AIActions>();
			if (!(component != null) || ActionIndex < 0 || ActionIndex >= component.Actions.Length)
			{
				return;
			}
			AIAction aIAction = component.Actions[ActionIndex];
			if (aIAction != null && aIAction.Wait <= float.Epsilon)
			{
				if (aIAction.NeedsSingleTargetActor || aIAction.NeedsTargetLocation)
				{
					Strategy.Target = actor;
					Strategy.GiveCommand(aIAction);
				}
				else
				{
					component.Execute(aIAction);
				}
			}
		}

		private void Update()
		{
			RectTransform rectTransform = (FillOverride != null) ? FillOverride : ((!(Button.Target != null)) ? null : Button.Target.rectTransform);
			if (!(rectTransform == null) && !(Switcher == null) && CharacterIndex >= 0 && CharacterIndex < Switcher.Characters.Length && !(Switcher.Characters[CharacterIndex] == null))
			{
				AIActions component = Switcher.Characters[CharacterIndex].GetComponent<AIActions>();
				if (ActionIndex >= 0 && ActionIndex < component.Actions.Length)
				{
					AIAction aIAction = component.Actions[ActionIndex];
					float y = (!(aIAction.Cooldown > float.Epsilon)) ? 1f : (1f - aIAction.Wait / aIAction.Cooldown);
					rectTransform.anchorMax = new Vector2(1f, y);
				}
			}
		}
	}
}
