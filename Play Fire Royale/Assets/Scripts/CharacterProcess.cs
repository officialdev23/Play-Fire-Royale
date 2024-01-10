// DecompilerFi decompiler from Assembly-CSharp.dll class: CharacterProcess
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct CharacterProcess
	{
		[Tooltip("Animator trigger to set on the start of the process.")]
		public string AnimationTrigger;

		[Tooltip("Can the motor aim and fire during the process.")]
		public bool CanAim;

		[Tooltip("Can the motor move during the process.")]
		public bool CanMove;

		[Tooltip("Should the motor leave cover during the process.")]
		public bool LeaveCover;

		public CharacterProcess(string animationTrigger, bool canAim, bool canMove, bool leaveCover)
		{
			AnimationTrigger = animationTrigger;
			CanAim = canAim;
			CanMove = canMove;
			LeaveCover = leaveCover;
		}
	}
}
