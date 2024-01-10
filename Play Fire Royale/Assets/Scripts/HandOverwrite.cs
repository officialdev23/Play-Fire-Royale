// DecompilerFi decompiler from Assembly-CSharp.dll class: HandOverwrite
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct HandOverwrite
	{
		[Tooltip("Marker to use when the character is aiming.")]
		public Transform Aim;

		[Tooltip("Marker to use when the character is crouching.")]
		public Transform Crouch;

		[Tooltip("Marker to use when the character is standing in a low cover.")]
		public Transform LowCover;

		[Tooltip("Marker to use when the character is standing in a tall cover.")]
		public Transform TallCover;
	}
}
