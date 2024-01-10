// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CoverAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CoverAnimation : StateMachineBehaviour
	{
		public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].internalIsCoverAnimation = true;
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].internalIsCoverAnimation = false;
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			if (characterMotor.internalIsCoverAnimation || characterMotor.GroundTimer < 0.4f)
			{
				return;
			}
			float num = Mathf.Repeat(animatorStateInfo.normalizedTime, 1f);
			float @float = animator.GetFloat("MovementX");
			float float2 = animator.GetFloat("MovementZ");
			bool flag = float2 > 0.1f || (float2 > -0.1f && ((@float > 0f) ? true : false));
			if (animator.GetFloat("MovementSpeed") > 0.4f)
			{
				int num2 = (!(num < 0.1f)) ? ((num < 0.6f) ? 1 : 2) : 0;
				if ((num2 == 1 && flag) || (num2 != 1 && !flag))
				{
					animator.SetFloat("JumpLeg", 1f);
				}
				else
				{
					animator.SetFloat("JumpLeg", -1f);
				}
			}
		}
	}
}
