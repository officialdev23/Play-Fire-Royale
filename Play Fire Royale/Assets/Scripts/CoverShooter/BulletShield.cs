// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BulletShield
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class BulletShield : MonoBehaviour
	{
		private static Dictionary<GameObject, BulletShield> _map = new Dictionary<GameObject, BulletShield>();

		public static BulletShield Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return null;
		}

		public static bool Contains(GameObject gameObject)
		{
			return _map.ContainsKey(gameObject);
		}

		private void OnEnable()
		{
			_map[base.gameObject] = this;
		}

		private void OnDisable()
		{
			_map.Remove(base.gameObject);
		}
	}
}
