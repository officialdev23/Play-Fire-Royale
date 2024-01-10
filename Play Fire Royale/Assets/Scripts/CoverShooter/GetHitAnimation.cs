// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GetHitAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class GetHitAnimation : StateMachineBehaviour
	{
		public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputGetHit();
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].CancelGetHit(0.3f, triggerAnimation: false);
		}
	}
}
