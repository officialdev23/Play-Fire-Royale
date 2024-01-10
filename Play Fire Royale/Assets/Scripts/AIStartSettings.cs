// DecompilerFi decompiler from Assembly-CSharp.dll class: AIStartSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AIStartSettings
	{
		[Tooltip("Should the AI return to the starting state when becoming idle.")]
		public bool ReturnOnIdle;

		[Tooltip("Mode in which the AI starts.")]
		public AIStartMode Mode;

		[Tooltip("Position the AI should investigate if the mode is set to searchPosition or investigate.")]
		public Vector3 Position;

		public static AIStartSettings Default()
		{
			AIStartSettings result = default(AIStartSettings);
			result.ReturnOnIdle = false;
			result.Mode = AIStartMode.patrol;
			result.Position = Vector3.zero;
			return result;
		}
	}
}
