// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.RollAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class RollAnimation : StateMachineBehaviour
	{
		[Tooltip("Normalized time in the animation when to stop the process.")]
		[Range(0f, 1f)]
		public float End = 0.8f;

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputEndRoll();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= End)
			{
				CharacterMotor.animatorToMotorMap[animator].InputEndRoll();
			}
		}
	}
}
