// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ClimbAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ClimbAnimation : StateMachineBehaviour
	{
		public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputClimbStart();
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputEndClimb();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputMidClimb(animatorStateInfo.normalizedTime);
		}
	}
}
