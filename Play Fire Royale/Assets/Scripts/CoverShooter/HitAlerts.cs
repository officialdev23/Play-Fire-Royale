// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HitAlerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class HitAlerts : MonoBehaviour
	{
		[Tooltip("Range of the alert generated.")]
		public float Range;

		public void OnHit(Hit hit)
		{
			Alerts.Broadcast(hit.Position, Range,  true, Actors.Get(hit.Attacker),  false);
		}
	}
}
