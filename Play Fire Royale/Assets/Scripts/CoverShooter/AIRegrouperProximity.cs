// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIRegrouperProximity
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(AIMovement))]
	public class AIRegrouperProximity : AIBaseRegrouper
	{
		[Tooltip("Distance to the enemy that triggers a regroup.")]
		[Range(0f, 1f)]
		public float Distance = 20f;

		private bool _wasTriggered;

		private void OnThreatPosition(Vector3 value)
		{
			if (Vector3.Distance(base.transform.position, value) <= Distance)
			{
				if (!_wasTriggered)
				{
					_wasTriggered = true;
					Regroup();
				}
			}
			else
			{
				_wasTriggered = false;
			}
		}
	}
}
