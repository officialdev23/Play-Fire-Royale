// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Actors
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public static class Actors
	{
		private static List<Actor> _list = new List<Actor>();

		private static Dictionary<GameObject, Actor> _map = new Dictionary<GameObject, Actor>();

		public static IEnumerable<Actor> All => _list;

		public static int Count => _list.Count;

		public static Actor Get(int index)
		{
			return _list[index];
		}

		public static Actor Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return null;
		}

		public static void Register(Actor actor)
		{
			if (!_list.Contains(actor))
			{
				_list.Add(actor);
			}
			_map[actor.gameObject] = actor;
		}

		public static void Unregister(Actor actor)
		{
			if (_list.Contains(actor))
			{
				_list.Remove(actor);
			}
			if (_map.ContainsKey(actor.gameObject))
			{
				_map.Remove(actor.gameObject);
			}
		}
	}
}
