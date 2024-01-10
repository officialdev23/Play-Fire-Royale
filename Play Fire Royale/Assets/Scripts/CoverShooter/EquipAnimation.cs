// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.EquipAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class EquipAnimation : StateMachineBehaviour
	{
		[Tooltip("Normalized time in the animation when to grab the weapon.")]
		[Range(0f, 1f)]
		public float Grab = 0.5f;

		[Tooltip("Normalized time in the animation when to stop the process.")]
		[Range(0f, 1f)]
		public float End = 0.9f;

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			characterMotor.InputGrabWeapon();
			characterMotor.InputFinishEquip();
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			if (animatorStateInfo.normalizedTime >= Grab)
			{
				characterMotor.InputGrabWeapon();
			}
			if (animatorStateInfo.normalizedTime >= End)
			{
				characterMotor.InputFinishEquip();
			}
		}
	}
}
