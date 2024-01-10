// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.JumpAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class JumpAnimation : StateMachineBehaviour
	{
		[Tooltip("Moment during the animation when to end the process.")]
		[Range(0f, 1f)]
		public float End = 0.75f;

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= End)
			{
				CharacterMotor.animatorToMotorMap[animator].InputEndJump();
			}
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputEndJump();
		}
	}
}
