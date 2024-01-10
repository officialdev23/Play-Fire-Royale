// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIListeners
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public static class AIListeners
	{
		private static List<AIListener> _list = new List<AIListener>();

		private static Dictionary<GameObject, AIListener> _map = new Dictionary<GameObject, AIListener>();

		public static IEnumerable<AIListener> All => _list;

		public static AIListener Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return null;
		}

		public static void Register(AIListener listener)
		{
			if (!_list.Contains(listener))
			{
				_list.Add(listener);
			}
			_map[listener.gameObject] = listener;
		}

		public static void Unregister(AIListener listener)
		{
			if (_list.Contains(listener))
			{
				_list.Remove(listener);
			}
			if (_map.ContainsKey(listener.gameObject))
			{
				_map.Remove(listener.gameObject);
			}
		}
	}
}
