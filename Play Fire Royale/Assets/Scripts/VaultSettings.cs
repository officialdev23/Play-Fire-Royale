// DecompilerFi decompiler from Assembly-CSharp.dll class: VaultSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct VaultSettings
	{
		[Tooltip("Capsule height to set during a vault.")]
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

		[Tooltip("Moment in the vault animation to turn on the push force.")]
		[Range(0f, 1f)]
		public float PushOn;

		[Tooltip("Moment in the vault animation to turn off the push force.")]
		[Range(0f, 1f)]
		public float PushOff;

		[Tooltip("Moment in the climbing animation to turn off the capsule collider.")]
		[Range(0f, 1f)]
		public float CollisionOff;

		[Tooltip("Moment in the climbing animation to turn back on the capsule collider.")]
		[Range(0f, 1f)]
		public float CollisionOn;

		public static VaultSettings Default()
		{
			VaultSettings result = default(VaultSettings);
			result.CapsuleHeight = 1.5f;
			result.VerticalScale = 1.3f;
			result.HorizontalScale = 1.4f;
			result.Push = 0f;
			result.PushOn = 0f;
			result.PushOff = 1f;
			result.CollisionOff = 0.1f;
			result.CollisionOn = 0.7f;
			return result;
		}
	}
}
