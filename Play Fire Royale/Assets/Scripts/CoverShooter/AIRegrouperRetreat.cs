// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIRegrouperRetreat
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(AIMovement))]
	public class AIRegrouperRetreat : AIBaseRegrouper
	{
		private void OnRetreat()
		{
			Regroup();
		}
	}
}
