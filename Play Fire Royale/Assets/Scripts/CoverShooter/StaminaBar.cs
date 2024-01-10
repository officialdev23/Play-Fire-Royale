// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.StaminaBar
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[ExecuteInEditMode]
	public class StaminaBar : MonoBehaviour
	{
		[Tooltip("Object whose stamina is displayed on the stamina bar.")]
		public GameObject Target;

		[Range(0f, 1f)]
		[Tooltip("Current value of the stamina bar.")]
		public float Value = 1f;

		[Tooltip("Determines if the stamina bar is hidden when the target has no stamina.")]
		public bool HideWhenDead = true;

		[Tooltip("Determines if the stamina bar is hidden when there is no target.")]
		public bool HideWhenNone;

		[Tooltip("Link to the object that draws the background of the stamina bar.")]
		public RectTransform BackgroundRect;

		[Tooltip("Link to the object that draws the stamina bar.")]
		public RectTransform FillRect;

		[Tooltip("Link to the object that will be used to display a character's name.")]
		public Text Name;

		private GameObject _cachedTarget;

		private CharacterStamina _cachedCharacterStamina;

		private CharacterName _cachedCharacterName;

		private void LateUpdate()
		{
			if (Target != _cachedTarget)
			{
				_cachedTarget = Target;
				if (Target != null)
				{
					_cachedCharacterStamina = Target.GetComponent<CharacterStamina>();
					_cachedCharacterName = Target.GetComponent<CharacterName>();
				}
				else
				{
					_cachedCharacterStamina = null;
					_cachedCharacterName = null;
				}
			}
			if (_cachedCharacterStamina != null)
			{
				Value = _cachedCharacterStamina.Stamina / _cachedCharacterStamina.MaxStamina;
			}
			bool flag = true;
			if (Application.isPlaying)
			{
				flag = ((!HideWhenDead || Value > float.Epsilon) && (!HideWhenNone || Target != null));
				if (FillRect != null)
				{
					FillRect.gameObject.SetActive(flag);
				}
				if (BackgroundRect != null)
				{
					BackgroundRect.gameObject.SetActive(flag);
				}
				if (Name != null)
				{
					Name.gameObject.SetActive(flag);
				}
			}
			if (!flag)
			{
				return;
			}
			if (Name != null)
			{
				if (_cachedCharacterName == null)
				{
					if (Target != null)
					{
						Name.text = Target.name;
					}
				}
				else
				{
					Name.text = _cachedCharacterName.Name;
				}
			}
			if (FillRect != null)
			{
				FillRect.anchorMax = new Vector2(Value, 1f);
			}
		}
	}
}
