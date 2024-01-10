// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterOutline
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class CharacterOutline : MonoBehaviour
	{
		private class OutlineColor
		{
			public Color Value;

			public OutlineColor Previous;

			public OutlineColor Next;
		}

		[Tooltip("Default color of the outline, if no outside component has affected it.")]
		public Color DefaultColor = Color.yellow;

		[Tooltip("Will the outline be displayed if no other outside component has affected it.")]
		public bool DisplayDefault = true;

		[Tooltip("Outline size is dependant on the screen size as a fraction of it.")]
		public float Width = 0.1f;

		private Shader _shader;

		private SkinnedMeshRenderer[] _renderers;

		private List<Renderer> _outlines = new List<Renderer>();

		private Dictionary<Object, OutlineColor> _colorMap = new Dictionary<Object, OutlineColor>();

		private OutlineColor _head;

		public void PushColor(UnityEngine.Object pusher, Color value)
		{
			PopColor(pusher);
			OutlineColor outlineColor = new OutlineColor();
			outlineColor.Value = value;
			if (_head != null)
			{
				outlineColor.Next = _head;
				_head.Previous = outlineColor;
			}
			_head = outlineColor;
			_colorMap[pusher] = outlineColor;
			updateState();
		}

		public void PopColor(UnityEngine.Object pusher)
		{
			if (_colorMap.ContainsKey(pusher))
			{
				OutlineColor outlineColor = _colorMap[pusher];
				_colorMap.Remove(pusher);
				if (outlineColor.Previous != null)
				{
					outlineColor.Previous.Next = outlineColor.Next;
				}
				if (outlineColor.Next != null)
				{
					outlineColor.Next.Previous = outlineColor.Previous;
				}
				if (outlineColor == _head)
				{
					_head = outlineColor.Next;
				}
				updateState();
			}
		}

		private void updateState()
		{
			if (_head != null)
			{
				if (!base.enabled)
				{
					base.enabled = true;
				}
			}
			else if (!DisplayDefault && base.enabled)
			{
				base.enabled = false;
			}
		}

		private void Awake()
		{
			_shader = Shader.Find("CoverShooter/Outline");
			_renderers = GetComponentsInChildren<SkinnedMeshRenderer>();
		}

		private void LateUpdate()
		{
			Color value = (_head == null) ? DefaultColor : _head.Value;
			for (int i = 0; i < _outlines.Count; i++)
			{
				for (int j = 0; j < _outlines[i].sharedMaterials.Length; j++)
				{
					Material material = _outlines[i].sharedMaterials[j];
					material.SetColor("_Color", value);
					material.SetFloat("_Width", Width);
				}
			}
		}

		private void OnEnable()
		{
			SkinnedMeshRenderer[] renderers = _renderers;
			foreach (SkinnedMeshRenderer skinnedMeshRenderer in renderers)
			{
				SkinnedMeshRenderer skinnedMeshRenderer2 = UnityEngine.Object.Instantiate(skinnedMeshRenderer);
				skinnedMeshRenderer2.transform.SetParent(skinnedMeshRenderer.transform.parent);
				SkinnedMeshRenderer component = skinnedMeshRenderer2.GetComponent<SkinnedMeshRenderer>();
				Material[] array = new Material[skinnedMeshRenderer.materials.Length];
				for (int j = 0; j < array.Length; j++)
				{
					array[j] = new Material(_shader);
				}
				component.sharedMaterials = array;
				_outlines.Add(component);
			}
		}

		private void OnDisable()
		{
			foreach (Renderer outline in _outlines)
			{
				UnityEngine.Object.Destroy(outline.gameObject);
			}
			_outlines.Clear();
		}
	}
}
