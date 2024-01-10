// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BuffBar
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	public class BuffBar : MonoBehaviour
	{
		[Tooltip("Object whose buffs are displayed.")]
		public GameObject Target;

		[Tooltip("Prototype object that is instantiated for every buff.")]
		public GameObject Prototype;

		[Tooltip("Horizontal space between buffs.")]
		public float Spacing;

		[Tooltip("Icon displayed for active positive DamageBuffs.")]
		public Sprite Damage;

		[Tooltip("Icon displayed for active beneficial ArmorBuff.")]
		public Sprite Armor;

		[Tooltip("Icon displayed for active negative DamageBuffs.")]
		public Sprite Toxic;

		[Tooltip("Icon displayed for active negative VisionBuffs.")]
		public Sprite Smoke;

		private List<Image> _images = new List<Image>();

		private int _imageIndex;

		private List<ArmorBuff> _armors = new List<ArmorBuff>();

		private List<DamageBuff> _damages = new List<DamageBuff>();

		private List<VisionBuff> _visions = new List<VisionBuff>();

		private void Update()
		{
			_imageIndex = 0;
			if (Target != null)
			{
				_armors.Clear();
				_damages.Clear();
				_visions.Clear();
				Target.GetComponents(_armors);
				Target.GetComponents(_damages);
				Target.GetComponents(_visions);
				foreach (ArmorBuff armor in _armors)
				{
					if (armor != null && armor.enabled && !(armor.Multiplier > 1f))
					{
						addImage(Armor);
					}
				}
				foreach (DamageBuff damage in _damages)
				{
					if (damage != null && damage.enabled)
					{
						if (damage.Multiplier > 1f)
						{
							addImage(Damage);
						}
						else
						{
							addImage(Toxic);
						}
					}
				}
				foreach (VisionBuff vision in _visions)
				{
					if (vision != null && vision.enabled && !(vision.Multiplier > 1f))
					{
						addImage(Smoke);
					}
				}
			}
			if (_imageIndex < _images.Count)
			{
				for (int num = _images.Count - 1; num >= _imageIndex; num--)
				{
					UnityEngine.Object.Destroy(_images[num].gameObject);
					_images.RemoveAt(num);
				}
			}
		}

		private void addImage(Sprite sprite)
		{
			Image image;
			if (_images.Count > _imageIndex)
			{
				image = _images[_imageIndex++];
			}
			else
			{
				if (!(Prototype != null))
				{
					return;
				}
				GameObject gameObject = UnityEngine.Object.Instantiate(Prototype);
				RectTransform component = gameObject.GetComponent<RectTransform>();
				RectTransform component2 = Prototype.GetComponent<RectTransform>();
				component.SetParent(Prototype.transform.parent);
				component.anchoredPosition = component2.anchoredPosition;
				component.anchoredPosition += new Vector2(Spacing * (float)_imageIndex, 0f);
				gameObject.SetActive(value: true);
				image = gameObject.GetComponent<Image>();
				_images.Add(image);
				_imageIndex = _images.Count;
			}
			if (image != null)
			{
				image.sprite = sprite;
			}
		}
	}
}
