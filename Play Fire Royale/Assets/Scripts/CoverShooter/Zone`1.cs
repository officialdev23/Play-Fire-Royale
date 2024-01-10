// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Zone`1
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class Zone<T> : MonoBehaviour where T : MonoBehaviour
	{
		private BoxCollider _collider;

		private static List<T> _list = new List<T>();

		private static Dictionary<GameObject, T> _map = new Dictionary<GameObject, T>();

		public float Width
		{
			get
			{
				Vector3 size = _collider.size;
				float x = size.x;
				Vector3 localScale = base.transform.localScale;
				return x * localScale.x;
			}
		}

		public float Height
		{
			get
			{
				Vector3 size = _collider.size;
				float y = size.y;
				Vector3 localScale = base.transform.localScale;
				return y * localScale.y;
			}
		}

		public float Depth
		{
			get
			{
				Vector3 size = _collider.size;
				float z = size.z;
				Vector3 localScale = base.transform.localScale;
				return z * localScale.z;
			}
		}

		public float Bottom
		{
			get
			{
				Vector3 min = _collider.bounds.min;
				return min.y;
			}
		}

		public static IEnumerable<T> All => _list;

		public static int Count => _list.Count;

		private void Awake()
		{
			_collider = GetComponent<BoxCollider>();
		}

		private void OnEnable()
		{
			T component = GetComponent<T>();
			if (!_list.Contains(component))
			{
				_list.Add(component);
			}
			_map[base.gameObject] = component;
		}

		private void OnDisable()
		{
			T component = GetComponent<T>();
			if (_list.Contains(component))
			{
				_list.Remove(component);
			}
			if (_map.ContainsKey(base.gameObject))
			{
				_map.Remove(base.gameObject);
			}
		}

		private void OnDestroy()
		{
			T component = GetComponent<T>();
			if (_list.Contains(component))
			{
				_list.Remove(component);
			}
			if (_map.ContainsKey(base.gameObject))
			{
				_map.Remove(base.gameObject);
			}
		}

		public static T Get(int index)
		{
			return _list[index];
		}

		public static T Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return (T)null;
		}
	}
}
