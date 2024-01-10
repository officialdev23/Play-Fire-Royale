// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SearchZoneCache
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class SearchZoneCache
	{
		public List<SearchZone> Items = new List<SearchZone>();

		public void Reset(Vector3 observer, float maxDistance)
		{
			Items.Clear();
			int num = Physics.OverlapSphereNonAlloc(observer, maxDistance, Util.Colliders, Layers.Zones, QueryTriggerInteraction.Collide);
			for (int i = 0; i < num; i++)
			{
				Collider collider = Util.Colliders[i];
				if (collider.isTrigger)
				{
					SearchZone searchZone = Zone<SearchZone>.Get(collider.gameObject);
					if (searchZone != null)
					{
						Items.Add(searchZone);
					}
				}
			}
		}
	}
}
