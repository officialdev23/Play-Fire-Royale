// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CoverSettings
	{
		[Tooltip("Can the character peek from tall cover corners to aim.")]
		public bool CanUseTallCorners;

		[Tooltip("Can the character peek from low cover corners to aim.")]
		public bool CanUseLowCorners;

		[Tooltip("Back area of a cover in angles, defined as a circle. Moving in this direction exits the cover.")]
		[Range(0f, 360f)]
		public float ExitBack;

		[Tooltip("Height of character's collision capsule when idle in low cover.")]
		[Range(0f, 10f)]
		public float LowCapsuleHeight;

		[Tooltip("Height of character's collision capsule when aiming back in low cover.")]
		[Range(0f, 10f)]
		public float LowAimCapsuleHeight;

		[Tooltip("How quickly the character is orientated towards a direction in a low cover.")]
		[Range(0f, 50f)]
		public float LowRotationSpeed;

		[Tooltip("How quickly the character is orientated towards a direction in a tall cover.")]
		[Range(0f, 50f)]
		public float TallRotationSpeed;

		[Tooltip("Character enter cover if it is closer than this value. Defined as a distance between a cover and an edge of players capsule.")]
		[Range(0f, 10f)]
		public float EnterDistance;

		[Tooltip("Character exit cover if it is furhter away than this value. Defined as a distance between a cover and an edge of players capsule.")]
		[Range(0f, 10f)]
		public float LeaveDistance;

		[Tooltip("Distance to cover at which the player can prompt a climb or vault action.")]
		[Range(0f, 10f)]
		public float ClimbDistance;

		[Tooltip("Distance to cover at which the character is fully crouching when near it.")]
		[Range(0f, 10f)]
		public float MinCrouchDistance;

		[Tooltip("Distance to cover at which the character begins to transition into the crouch state.")]
		[Range(0f, 10f)]
		public float MaxCrouchDistance;

		[Tooltip("Controls the location of camera pivot position when in cover. Pivot point does not move beyond this margin.")]
		[Range(-10f, 10f)]
		public float PivotSideMargin;

		[Tooltip("Distance from a side of a cover at which player can enter aiming from a corner.")]
		[Range(0f, 10f)]
		public float CornerAimTriggerDistance;

		[Tooltip("Capsule radius used when determining if the character is in front of a tall cover when entering it.")]
		[Range(0f, 10f)]
		public float TallSideEnterRadius;

		[Tooltip("Capsule radius used when determining if the character is in front of a tall cover when leaving it.")]
		[Range(0f, 10f)]
		public float TallSideLeaveRadius;

		[Tooltip("Point relative to a tall corner for the motor to go back to after corner aiming.")]
		[Range(0f, 10f)]
		public float LeftTallCornerOffset;

		[Tooltip("Point relative to a tall corner for the motor to go back to after corner aiming.")]
		[Range(0f, 10f)]
		public float RightTallCornerOffset;

		[Tooltip("Capsule radius used when determining if the character is in front of a low cover when entering it.")]
		[Range(0f, 10f)]
		public float LowSideEnterRadius;

		[Tooltip("Capsule radius used when determining if the character is in front of a low cover when leaving it.")]
		[Range(0f, 10f)]
		public float LowSideLeaveRadius;

		[Tooltip("Point relative to a low corner for the motor to go back to after corner aiming.")]
		[Range(0f, 10f)]
		public float LeftLowCornerOffset;

		[Tooltip("Point relative to a low corner for the motor to go back to after corner aiming.")]
		[Range(0f, 10f)]
		public float RightLowCornerOffset;

		[Tooltip("Time in seconds for player to start moving again after changing direction.")]
		[Range(0f, 5f)]
		public float DirectionChangeDelay;

		[Tooltip("Approximate position shift done by the corner peek animation. Inverted when peeking left.")]
		public Vector3 CornerOffset;

		[Tooltip("Settings for cover update delays.")]
		public CoverUpdateSettings Update;

		public static CoverSettings Default()
		{
			CoverSettings result = default(CoverSettings);
			result.CanUseTallCorners = true;
			result.CanUseLowCorners = false;
			result.ExitBack = 120f;
			result.LowCapsuleHeight = 0.75f;
			result.LowAimCapsuleHeight = 1.25f;
			result.LowRotationSpeed = 10f;
			result.TallRotationSpeed = 15f;
			result.EnterDistance = 0.15f;
			result.LeaveDistance = 0.25f;
			result.ClimbDistance = 0.5f;
			result.MinCrouchDistance = 0.2f;
			result.MaxCrouchDistance = 1.5f;
			result.PivotSideMargin = 0.5f;
			result.CornerAimTriggerDistance = 0.6f;
			result.TallSideEnterRadius = 0.15f;
			result.TallSideLeaveRadius = 0.05f;
			result.LeftTallCornerOffset = 0.2f;
			result.RightTallCornerOffset = 0.2f;
			result.LeftLowCornerOffset = 0.4f;
			result.RightLowCornerOffset = 0.4f;
			result.LowSideEnterRadius = 0.3f;
			result.LowSideLeaveRadius = 0.2f;
			result.DirectionChangeDelay = 0.25f;
			result.CornerOffset = new Vector3(0.8f, 0f, 0f);
			result.Update = CoverUpdateSettings.Default();
			return result;
		}
	}
}
