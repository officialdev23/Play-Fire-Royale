// DecompilerFi decompiler from Assembly-CSharp.dll class: ClimbSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct ClimbSettings
	{
		[Tooltip("Capsule height to set during a climb.")]
		[Range(0f, 10f)]
		public float CapsuleHeight;

		[Tooltip("Scale of movement in Y axis. The animation usually assumed a 1 meter high obstacle.")]
		[Range(0f, 3f)]
		public float VerticalScale;

		[Tooltip("Scale of movement done by the climbing animation in X and Z axes.")]
		[Range(0f, 3f)]
		public float HorizontalScale;

		[Tooltip("Additional velocity added to the character in the direction of cover.")]
		[Range(0f, 5f)]
		public float Push;

		[Tooltip("Moment in the climbing animation to turn on the push force.")]
		[Range(0f, 1f)]
		public float PushOn;

		[Tooltip("Moment in the climbing animation to turn off the push force.")]
		[Range(0f, 1f)]
		public float PushOff;

		[Tooltip("Moment in the climbing animation to turn off the capsule collider.")]
		[Range(0f, 1f)]
		public float CollisionOff;

		[Tooltip("Moment in the climbing animation to turn back on the capsule collider.")]
		[Range(0f, 1f)]
		public float CollisionOn;

		public static ClimbSettings Default()
		{
			ClimbSettings result = default(ClimbSettings);
			result.CapsuleHeight = 1.5f;
			result.VerticalScale = 1f;
			result.HorizontalScale = 1.05f;
			result.Push = 0.5f;
			result.PushOn = 0.6f;
			result.PushOff = 0.9f;
			result.CollisionOff = 0.3f;
			result.CollisionOn = 0.7f;
			return result;
		}
	}
}
