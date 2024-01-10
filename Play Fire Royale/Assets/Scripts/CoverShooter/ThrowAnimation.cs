// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ThrowAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ThrowAnimation : StateMachineBehaviour
	{
		[Tooltip("Moment inside the animation when the weapon is used.")]
		[Range(0f, 1f)]
		public float Moment = 0.5f;

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputThrow();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= Moment)
			{
				CharacterMotor.animatorToMotorMap[animator].InputThrow();
			}
		}
	}
}
