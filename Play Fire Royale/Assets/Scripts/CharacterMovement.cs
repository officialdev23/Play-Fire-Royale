// DecompilerFi decompiler from Assembly-CSharp.dll class: CharacterMovement
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct CharacterMovement
	{
		public Vector3 Direction;

		public float Magnitude;

		public float MinDuration;

		public bool IsSlowedDown;

		public Vector3 Value => Direction * Magnitude;

		public bool IsMoving => Value.sqrMagnitude > 0.1f;

		public bool IsRunning => ((Magnitude > 0.6f) & IsMoving) && !IsSprinting;

		public bool IsSprinting => Magnitude > 1.1f && IsMoving;

		public CharacterMovement(Vector3 direction, float magnitude, float minDuration = 0f, bool isSlowedDown = false)
		{
			Direction = direction;
			Magnitude = magnitude;
			MinDuration = minDuration;
			IsSlowedDown = isSlowedDown;
		}
	}
}
