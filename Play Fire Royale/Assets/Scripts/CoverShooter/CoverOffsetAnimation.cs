// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CoverOffsetAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CoverOffsetAnimation : StateMachineBehaviour
	{
		public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputMidCoverOffset(animatorStateInfo.normalizedTime);
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputMidCoverOffset(1f);
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputMidCoverOffset(animatorStateInfo.normalizedTime);
		}
	}
}
