// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HealthBar
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[ExecuteInEditMode]
	public class HealthBar : MonoBehaviour
	{
		[Tooltip("Object whose health is displayed on the health bar.")]
		public GameObject Target;

		[Range(0f, 1f)]
		[Tooltip("Current value of the health bar.")]
		public float Value = 1f;

		[Tooltip("Determines if the health bar is hidden when the target has no health.")]
		public bool HideWhenDead = true;

		[Tooltip("Determines if the health bar is hidden when there is no target.")]
		public bool HideWhenNone;

		[Tooltip("Link to the object that draws the background of the health bar.")]
		public RectTransform BackgroundRect;

		[Tooltip("Link to the object that draws the health bar.")]
		public RectTransform FillRect;

		[Tooltip("Link to the object that will be used to display a character's name.")]
		public Text Name;

		private GameObject _cachedTarget;

		private CharacterHealth _cachedCharacterHealth;

		private CharacterName _cachedCharacterName;

		public GameObject arteviva;

		public GameObject artemorta;

		private void LateUpdate()
		{
			if (Value <= 0f)
			{
				artemorta.SetActive(value: true);
				arteviva.SetActive(value: false);
			}
			else
			{
				artemorta.SetActive(value: false);
				arteviva.SetActive(value: true);
			}
			if (Target != _cachedTarget)
			{
				_cachedTarget = Target;
				if (Target != null)
				{
					_cachedCharacterHealth = Target.GetComponent<CharacterHealth>();
					_cachedCharacterName = Target.GetComponent<CharacterName>();
				}
				else
				{
					_cachedCharacterHealth = null;
					_cachedCharacterName = null;
				}
			}
			if (_cachedCharacterHealth != null)
			{
				Value = _cachedCharacterHealth.Health / _cachedCharacterHealth.MaxHealth;
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
