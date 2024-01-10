// DecompilerFi decompiler from Assembly-CSharp.dll class: IKConfig
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct IKConfig
	{
		public int MinIterations;

		public int MaxIterations;

		public DistanceRange Delay;

		public Transform LeftHand;

		public Transform RightHand;

		public Transform HitBone;

		public Transform Sight;

		public BaseGun Gun;

		public bool TurnImmediately;

		public Vector3 AimTarget;

		public Vector3 BodyTarget;

		public bool IsPrecise;
	}
}
