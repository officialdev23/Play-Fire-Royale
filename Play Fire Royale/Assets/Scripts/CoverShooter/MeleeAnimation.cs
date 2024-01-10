// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MeleeAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class MeleeAnimation : StateMachineBehaviour
	{
		[Tooltip("Limb that is used in the attack.")]
		public Limb Limb;

		[Tooltip("Normalized time in the animation when to start scanning for collisions.")]
		[Range(0f, 1f)]
		public float ScanStart;

		[Tooltip("Normalized time in the animation when to stop scanning for collisions.")]
		[Range(0f, 1f)]
		public float ScanEnd = 1f;

		[Tooltip("Are there any following combo attacks.")]
		public bool EnableCombo;

		[Tooltip("Normalized time to start checking for following combo attacks.")]
		[Range(0f, 1f)]
		public float ComboCheck = 0.5f;

		[Tooltip("Normalized time in the animation when to stop the attack chain.")]
		[Range(0f, 1f)]
		public float End = 0.9f;

		[Tooltip("Normalized time in the animation when to stop the attack chain.")]
		[Range(0f, 1f)]
		public float Moment;

		public override void OnStateEnter(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			animator.ResetTrigger("ComboHit");
			animator.ResetTrigger("Hit");
			animator.ResetTrigger("EndMelee");
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			if (!characterMotor.IsPerformingMelee)
			{
				characterMotor.InputMeleeAttackStart(animatorStateInfo.fullPathHash);
			}
			else
			{
				characterMotor.InputMeleeComboStart(animatorStateInfo.fullPathHash);
			}
		}

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			if (!characterMotor.IsPerformingMelee)
			{
				characterMotor.StopMeleeRootMotion();
			}
			characterMotor.InputEndMeleeScan(animatorStateInfo.fullPathHash, Limb);
			if (characterMotor.IsPerformingMeleeId(animatorStateInfo.fullPathHash))
			{
				characterMotor.InputMeleeAttackEnd();
			}
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			if (animatorStateInfo.normalizedTime >= End)
			{
				characterMotor.InputMeleeMoment(animatorStateInfo.fullPathHash, Limb);
				if (characterMotor.IsPerformingMeleeId(animatorStateInfo.fullPathHash))
				{
					animator.SetTrigger("EndMelee");
					characterMotor.InputMeleeAttackEnd();
				}
				return;
			}
			if (animatorStateInfo.normalizedTime >= Moment)
			{
				characterMotor.InputMeleeMoment(animatorStateInfo.fullPathHash, Limb);
			}
			if (EnableCombo && animatorStateInfo.normalizedTime >= ComboCheck)
			{
				characterMotor.InputMeleeComboCheck();
			}
			if (animatorStateInfo.normalizedTime >= ScanEnd)
			{
				characterMotor.InputEndMeleeScan(animatorStateInfo.fullPathHash, Limb);
			}
			else if (animatorStateInfo.normalizedTime >= ScanStart)
			{
				characterMotor.InputBeginMeleeScan(animatorStateInfo.fullPathHash, Limb);
			}
		}
	}
}
