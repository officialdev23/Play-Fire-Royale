// DecompilerFi decompiler from Assembly-CSharp.dll class: Waypoint
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct Waypoint
	{
		[Tooltip("Position of the waypoint.")]
		public Vector3 Position;

		[Tooltip("Should the AI run towards the position.")]
		public bool Run;

		[Tooltip("Duration in seconds of the pause after reaching the waypoint.")]
		public float Pause;
	}
}
