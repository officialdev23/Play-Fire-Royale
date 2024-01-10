// DecompilerFi decompiler from Assembly-CSharp.dll class: ShoulderSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct ShoulderSettings
	{
		[Tooltip("Relative right shoulder position when the character is standing up.")]
		public Vector3 Standing;

		[Tooltip("Relative right shoulder position when the character is crouching.")]
		public Vector3 Crouching;

		public static ShoulderSettings Default()
		{
			ShoulderSettings result = default(ShoulderSettings);
			result.Standing = new Vector3(0f, 1.4f, 0f);
			result.Crouching = new Vector3(0f, 0.9f, 0f);
			return result;
		}
	}
}
