// DecompilerFi decompiler from Assembly-CSharp.dll class: AIApproximationSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AIApproximationSettings
	{
		[Tooltip("Minimal possible error the AI makes when approximating the position of an enemy. Error is measured in meters around the target. Smaller values mean the AI is better at guessing the position.")]
		public float Min;

		[Tooltip("Maximum possible error the AI makes when approximating the position of an enemy. Error is measured in meters around the target. Smaller values mean the AI is better at guessing the position.")]
		public float Max;

		[Tooltip("Distance at which the AI is using Min value for guessing. If a target is at a greater distance the value is interpolated between Min and Max.")]
		public float MinDistance;

		[Tooltip("Distance at which the AI is using Max value for guessing. If a target is at a greater distance the value is interpolated between Min and Max.")]
		public float MaxDistance;

		public AIApproximationSettings(float min, float max, float minDistance, float maxDistance)
		{
			Min = min;
			Max = max;
			MinDistance = minDistance;
			MaxDistance = maxDistance;
		}

		public float Get(Vector3 position)
		{
			if (CameraManager.Main == null || CameraManager.Main.transform == null)
			{
				return Min;
			}
			return Get(Vector3.Distance(CameraManager.Main.transform.position, position));
		}

		public float Get(float distance)
		{
			float t = Mathf.Clamp01((distance - MinDistance) / (MaxDistance - MinDistance));
			return Mathf.Lerp(Min, Max, t);
		}
	}
}
