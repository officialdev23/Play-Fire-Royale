// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.UnequipAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class UnequipAnimation : StateMachineBehaviour
	{
		[Tooltip("Normalized time in the animation when to put the weapon away.")]
		[Range(0f, 1f)]
		public float Put = 0.6f;

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].InputUnequip();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= Put)
			{
				CharacterMotor.animatorToMotorMap[animator].InputUnequip();
			}
		}
	}
}
