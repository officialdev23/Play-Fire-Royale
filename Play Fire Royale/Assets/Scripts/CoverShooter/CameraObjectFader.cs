// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CameraObjectFader
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class CameraObjectFader : MonoBehaviour
	{
		[Tooltip("Speed of material transparency changes.")]
		public float Speed = 3f;

		[Tooltip("Target object transparency when faded.")]
		public float Transparency = 0.1f;

		private bool _hasTarget;

		private Vector3 _targetPosition;

		private GameObject _target;

		private List<FadedObject> _currentObjects = new List<FadedObject>();

		private List<FadedObject> _oldObjects = new List<FadedObject>();

		private RaycastHit[] _hits = new RaycastHit[64];

		public void SetFadeTarget(FadeTarget target)
		{
			_hasTarget = true;
			_target = target.Object;
			_targetPosition = target.Position;
		}

		private void Update()
		{
			for (int i = 0; i < _currentObjects.Count; i++)
			{
				keep(i, value: false);
			}
			if (_hasTarget)
			{
				Vector3 direction = _targetPosition - base.transform.position;
				int num = Physics.RaycastNonAlloc(base.transform.position, direction, _hits, direction.magnitude);
				FadedObject item = default(FadedObject);
				FadedRenderer fadedRenderer = default(FadedRenderer);
				for (int j = 0; j < num; j++)
				{
					RaycastHit raycastHit = _hits[j];
					GameObject gameObject = raycastHit.collider.gameObject;
					if (raycastHit.collider.isTrigger || (!(_target == null) && Util.InHiearchyOf(gameObject, _target)))
					{
						continue;
					}
					int num2 = indexOf(_currentObjects, gameObject);
					if (num2 >= 0)
					{
						keep(num2, value: true);
						continue;
					}
					num2 = indexOf(_oldObjects, gameObject);
					if (num2 >= 0)
					{
						_currentObjects.Add(_oldObjects[num2]);
						keep(_currentObjects.Count - 1, value: true);
						_oldObjects.RemoveAt(num2);
						continue;
					}
					item.Fade = 0f;
					item.Object = gameObject;
					item.KeepThisFrame = true;
					MeshRenderer[] componentsInChildren = gameObject.GetComponentsInChildren<MeshRenderer>();
					item.Renderers = new FadedRenderer[componentsInChildren.Length];
					for (int k = 0; k < componentsInChildren.Length; k++)
					{
						fadedRenderer.Renderer = componentsInChildren[k];
						fadedRenderer.OriginalMaterial = UnityEngine.Object.Instantiate(fadedRenderer.Renderer.material);
						fadedRenderer.NewMaterial = UnityEngine.Object.Instantiate(fadedRenderer.Renderer.material);
						fadedRenderer.OriginalColor = fadedRenderer.OriginalMaterial.color;
						fadedRenderer.Renderer.material = fadedRenderer.NewMaterial;
						fadedRenderer.Renderer.gameObject.SendMessage("OnFade", SendMessageOptions.DontRequireReceiver);
						item.Renderers[k] = fadedRenderer;
					}
					_currentObjects.Add(item);
				}
			}
			for (int num3 = _currentObjects.Count - 1; num3 >= 0; num3--)
			{
				FadedObject fadedObject = _currentObjects[num3];
				if (!fadedObject.KeepThisFrame)
				{
					_oldObjects.Add(_currentObjects[num3]);
					_currentObjects.RemoveAt(num3);
				}
			}
			for (int l = 0; l < _currentObjects.Count; l++)
			{
				FadedObject value = _currentObjects[l];
				Util.Lerp(ref value.Fade, 1f, Speed);
				fade(value.Renderers, value.Fade);
				_currentObjects[l] = value;
			}
			for (int num4 = _oldObjects.Count - 1; num4 >= 0; num4--)
			{
				FadedObject value2 = _oldObjects[num4];
				Util.Lerp(ref value2.Fade, 0f, Speed);
				fade(value2.Renderers, value2.Fade);
				if (value2.Fade > float.Epsilon)
				{
					_oldObjects[num4] = value2;
				}
				else
				{
					FadedObject fadedObject2 = _oldObjects[num4];
					FadedRenderer[] renderers = fadedObject2.Renderers;
					for (int m = 0; m < renderers.Length; m++)
					{
						FadedRenderer fadedRenderer2 = renderers[m];
						fadedRenderer2.Renderer.material = fadedRenderer2.OriginalMaterial;
						fadedRenderer2.Renderer.gameObject.SendMessage("OnUnfade", SendMessageOptions.DontRequireReceiver);
					}
					_oldObjects.RemoveAt(num4);
				}
			}
		}

		private void keep(int index, bool value)
		{
			FadedObject value2 = _currentObjects[index];
			value2.KeepThisFrame = value;
			_currentObjects[index] = value2;
		}

		private int indexOf(List<FadedObject> list, GameObject obj)
		{
			for (int i = 0; i < list.Count; i++)
			{
				FadedObject fadedObject = list[i];
				if (fadedObject.Object == obj)
				{
					return i;
				}
			}
			return -1;
		}

		private void fade(FadedRenderer[] array, float value)
		{
			for (int i = 0; i < array.Length; i++)
			{
				FadedRenderer fadedRenderer = array[i];
				Color originalColor = fadedRenderer.OriginalColor;
				Color b = originalColor;
				b.a *= Transparency;
				fadedRenderer.Renderer.material.color = Color.Lerp(originalColor, b, value);
			}
		}
	}
}
