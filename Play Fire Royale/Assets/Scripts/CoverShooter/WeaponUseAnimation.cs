// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.WeaponUseAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class WeaponUseAnimation : StateMachineBehaviour
	{
		[Tooltip("Moment inside the animation when the weapon is used.")]
		[Range(0f, 1f)]
		public float Moment = 0.5f;

		public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].internalIsToolAnimation = true;
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor.animatorToMotorMap[animator].internalIsToolAnimation = false;
			CharacterMotor.animatorToMotorMap[animator].InputUseWeapon();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= Moment)
			{
				CharacterMotor.animatorToMotorMap[animator].InputUseWeapon();
			}
		}
	}
}
