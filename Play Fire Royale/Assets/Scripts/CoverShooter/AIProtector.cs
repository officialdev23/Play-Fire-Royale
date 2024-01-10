// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIProtector
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIProtector : AIBase
	{
		[Tooltip("Supported actor.")]
		public Actor Target;

		private Actor _previousTarget;

		private void OnEnable()
		{
			Message("ToSetThreatReference", Target);
			_previousTarget = Target;
		}

		private void Update()
		{
			if (Target != _previousTarget)
			{
				Message("ToSetThreatReference", Target);
				_previousTarget = Target;
			}
		}
	}
}
