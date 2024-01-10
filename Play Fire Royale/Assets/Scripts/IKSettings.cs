// DecompilerFi decompiler from Assembly-CSharp.dll class: IKSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct IKSettings
	{
		[Tooltip("Is IK enabled.")]
		public bool Enabled;

		[Tooltip("Minimum amount of iterations performed for each IK chain.")]
		[Range(1f, 10f)]
		public int MinIterations;

		[Tooltip("The IK will be performed till either the target state is reached or maximum amount of iterations are performed.")]
		[Range(1f, 10f)]
		public int MaxIterations;

		[Tooltip("Time in seconds to wait between IK updates.")]
		public DistanceRange Delay;

		[Tooltip("Position of a left hand to maintain on a gun.\nBones defined in the LeftBones property are adjusted till LeftHand is in the intended position.\nFor this to work LeftHand must be in the same hierarchy as those bones.")]
		public Transform LeftHandOverride;

		[Tooltip("Position of a right hand to adjust by recoil.\nBones defined in the RightBones property are adjusted till RightHand is in the intended position.\nFor this to work RightHand must be in the same hierarchy as those bones.")]
		public Transform RightHandOverride;

		[Tooltip("Bone to adjust when a character is hit.")]
		public Transform HitBoneOverride;

		[Tooltip("Transform to manipulate so it is facing towards a target. Used when aiming a head.\nBones defined in the LookBones are modified till Look is pointing at the intended direction.\nTherefore it Look must be in the same hierarchy as thsoe bones.")]
		public Transform SightOverride;

		public static IKSettings Default()
		{
			IKSettings result = default(IKSettings);
			result.Enabled = true;
			result.MinIterations = 2;
			result.MaxIterations = 10;
			return result;
		}
	}
}
