// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ReloadAnimation
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class ReloadAnimation : StateMachineBehaviour
	{
		[Tooltip("Type of the reload process.")]
		public ReloadType Type;

		[Tooltip("Normalized time in the animation when to stop the process.")]
		[Range(0f, 1f)]
		public float End = 0.9f;

		public override void OnStateExit(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
			switch (Type)
			{
			case ReloadType.Bullet:
				characterMotor.InputEndBulletLoad();
				break;
			case ReloadType.Magazine:
				characterMotor.InputEndMagazineLoad();
				break;
			case ReloadType.Pump:
				characterMotor.InputEndPump();
				break;
			}
		}

		public override void OnStateIK(Animator animator, AnimatorStateInfo animatorStateInfo, int layerIndex)
		{
			if (animatorStateInfo.normalizedTime >= End)
			{
				CharacterMotor characterMotor = CharacterMotor.animatorToMotorMap[animator];
				switch (Type)
				{
				case ReloadType.Bullet:
					characterMotor.InputEndBulletLoad();
					break;
				case ReloadType.Magazine:
					characterMotor.InputEndMagazineLoad();
					break;
				case ReloadType.Pump:
					characterMotor.InputEndPump();
					break;
				}
			}
		}
	}
}
