// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Alerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public static class Alerts
	{
		public static void Broadcast(Vector3 position, float range, bool isHostile, Actor actor, bool isDirect)
		{
			if (range <= float.Epsilon)
			{
				return;
			}
			GeneratedAlert alert = new GeneratedAlert(position, range, isHostile, actor, isDirect);
			int num = Physics.OverlapSphereNonAlloc(position, range, Util.Colliders, Layers.Character, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num; i++)
			{
				AIListener aIListener = AIListeners.Get(Util.Colliders[i].gameObject);
				if (aIListener != null && aIListener.isActiveAndEnabled && Vector3.Distance(aIListener.transform.position, position) < range * aIListener.Hearing)
				{
					aIListener.Hear(ref alert);
				}
			}
		}
	}
}
