// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverAimState
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct CoverAimState
	{
		public const float TimeEnterToAim = 0.2f;

		public const float TimeAimToLeave = 0.15f;

		public AimStep Step;

		public float Angle;

		public bool IsZoomed;

		public float TimeLeftForNextStep;

		public bool LeaveAfterAiming;

		public bool IsAiming => Step == AimStep.Enter || Step == AimStep.Aiming;

		public void Update()
		{
			if (TimeLeftForNextStep >= -1.401298E-45f)
			{
				TimeLeftForNextStep -= Time.deltaTime;
				return;
			}
			switch (Step)
			{
			case AimStep.Enter:
				Step = AimStep.Aiming;
				TimeLeftForNextStep = 0.15f;
				break;
			case AimStep.Aiming:
				if (LeaveAfterAiming)
				{
					Step = AimStep.None;
					LeaveAfterAiming = false;
				}
				break;
			}
		}

		public void ImmediateEnter()
		{
			LeaveAfterAiming = false;
			TimeLeftForNextStep = 0f;
			Step = AimStep.Aiming;
		}

		public void ImmediateLeave()
		{
			LeaveAfterAiming = false;
			TimeLeftForNextStep = 0f;
			Step = AimStep.None;
		}

		public void Leave()
		{
			switch (Step)
			{
			case AimStep.Enter:
				LeaveAfterAiming = true;
				break;
			case AimStep.Aiming:
				if (!LeaveAfterAiming)
				{
					LeaveAfterAiming = true;
					TimeLeftForNextStep = 0.15f;
				}
				break;
			}
		}

		public void FreeAim(float angle)
		{
			Angle = angle;
			Step = AimStep.Aiming;
		}

		public void CoverAim(float angle)
		{
			Angle = angle;
			if (Step == AimStep.Aiming)
			{
				LeaveAfterAiming = false;
			}
			else if (Step != AimStep.Enter)
			{
				Step = AimStep.Enter;
				TimeLeftForNextStep = 0.2f;
			}
		}

		public void WaitAim(float angle)
		{
			Angle = angle;
			if (Step == AimStep.Aiming)
			{
				LeaveAfterAiming = false;
			}
			else if (Step != AimStep.Enter)
			{
				Step = AimStep.Enter;
				TimeLeftForNextStep = 10000f;
			}
		}
	}
}
