// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GrenadeList
// SourcesPostProcessor 
using System.Collections.Generic;

namespace CoverShooter
{
	public static class GrenadeList
	{
		private static List<Grenade> _list = new List<Grenade>();

		public static IEnumerable<Grenade> All => _list;

		public static int Count => _list.Count;

		public static Grenade Get(int index)
		{
			return _list[index];
		}

		public static void Register(Grenade grenade)
		{
			if (!_list.Contains(grenade))
			{
				_list.Add(grenade);
			}
		}

		public static void Unregister(Grenade grenade)
		{
			if (_list.Contains(grenade))
			{
				_list.Remove(grenade);
			}
		}
	}
}
