// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.PressButton
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.EventSystems;

namespace CoverShooter
{
	public class PressButton : MonoBehaviour, IPointerDownHandler, IPointerEnterHandler, IPointerExitHandler, IPointerUpHandler, IEventSystemHandler
	{
		public PressButtonSettings Button = PressButtonSettings.Default();

		private Sprite _savedNormalSprite;

		private bool _isNormalSpriteRightNow = true;

		private bool _isPressed;

		private bool _isHighlighted;

		public void OnPointerDown(PointerEventData eventData)
		{
			_isPressed = true;
			_changeGraphic(Button.PressColor, Button.PressSprite);
			OnPress();
		}

		public void OnPointerUp(PointerEventData eventData)
		{
			_isPressed = false;
			if (_isHighlighted)
			{
				_changeGraphic(Button.HighlightColor, Button.HighlightSprite);
			}
			else
			{
				_changeGraphicBack();
			}
			OnRelease();
		}

		public void OnPointerEnter(PointerEventData eventData)
		{
			_isHighlighted = true;
			if (!_isPressed)
			{
				_changeGraphic(Button.HighlightColor, Button.HighlightSprite);
			}
			OnEnter();
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			_isHighlighted = false;
			if (!_isPressed)
			{
				_changeGraphicBack();
			}
			OnExit();
		}

		private void OnDisable()
		{
			_isPressed = false;
			_isHighlighted = false;
			_changeGraphicBack();
		}

		protected virtual void OnPress()
		{
		}

		protected virtual void OnRelease()
		{
		}

		protected virtual void OnEnter()
		{
		}

		protected virtual void OnExit()
		{
		}

		private void _changeGraphic(Color color, Sprite sprite)
		{
			if (Button.Target == null)
			{
				return;
			}
			if (sprite != null)
			{
				if (_isNormalSpriteRightNow)
				{
					_isNormalSpriteRightNow = false;
					_savedNormalSprite = Button.Target.sprite;
				}
				Button.Target.sprite = sprite;
			}
			Button.Target.color = color;
		}

		private void _changeGraphicBack()
		{
			if (!(Button.Target == null))
			{
				if (!_isNormalSpriteRightNow)
				{
					_isNormalSpriteRightNow = true;
					Button.Target.sprite = _savedNormalSprite;
				}
				Button.Target.color = Button.NormalColor;
			}
		}
	}
}
