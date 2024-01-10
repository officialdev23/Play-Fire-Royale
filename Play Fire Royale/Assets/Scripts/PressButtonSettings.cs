// DecompilerFi decompiler from Assembly-CSharp.dll class: PressButtonSettings
// SourcesPostProcessor 
using System;
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[Serializable]
	public struct PressButtonSettings
	{
		[Tooltip("Image component that is manipulated.")]
		public Image Target;

		[Tooltip("Image color when the button is neither pressed nor highlighted.")]
		public Color NormalColor;

		[Tooltip("Image color when the cursor is held above the button.")]
		public Color HighlightColor;

		[Tooltip("Image color when the button is being pressed.")]
		public Color PressColor;

		[Tooltip("Image sprite when the cursor is held above the button.")]
		public Sprite HighlightSprite;

		[Tooltip("Image sprite when the button is pressed.")]
		public Sprite PressSprite;

		public static PressButtonSettings Default()
		{
			PressButtonSettings result = default(PressButtonSettings);
			result.Target = null;
			result.NormalColor = Color.white;
			result.HighlightColor = new Color(127f, 127f, 127f, 255f);
			result.PressColor = new Color(63f, 63f, 63f, 255f);
			result.HighlightSprite = null;
			result.PressSprite = null;
			return result;
		}
	}
}
