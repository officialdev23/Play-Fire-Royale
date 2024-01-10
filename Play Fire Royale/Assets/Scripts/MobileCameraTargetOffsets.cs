// DecompilerFi decompiler from Assembly-CSharp.dll class: MobileCameraTargetOffsets
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct MobileCameraTargetOffsets
	{
		[Tooltip("Target position relative to the player for camera to look at when the character is facing up.")]
		public Vector3 Up;

		[Tooltip("Target position relative to the player for camera to look at when the character is facing down.")]
		public Vector3 Down;

		[Tooltip("Target position relative to the player for camera to look at when the character is facing left.")]
		public Vector3 Left;

		[Tooltip("Target position relative to the player for camera to look at when the character is facing right.")]
		public Vector3 Right;

		public MobileCameraTargetOffsets(Vector3 up, Vector3 down, Vector3 left, Vector3 right)
		{
			Up = up;
			Down = down;
			Left = left;
			Right = right;
		}
	}
}
