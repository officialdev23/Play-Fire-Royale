// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AILeave
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AILeave : AIBase
	{
		[Tooltip("Distance to the enemy that triggers AI going back to it's initial state.")]
		public float Distance = 60f;

		private Actor _threat;

		private void OnThreat(Actor actor)
		{
			_threat = actor;
		}

		public void OnNoThreat()
		{
			_threat = null;
		}

		private void Update()
		{
			if (_threat != null && Vector3.Distance(base.transform.position, _threat.transform.position) >= Distance - float.Epsilon)
			{
				Message("ToForget");
			}
		}
	}
}
