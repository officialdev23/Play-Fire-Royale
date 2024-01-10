// DecompilerFi decompiler from Assembly-CSharp.dll class: IKBone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct IKBone
	{
		public float Weight;

		public IKTransform Link;

		public Transform Transform;

		public Transform Sibling;

		public IKBone(Transform transform, float weight)
		{
			Weight = weight;
			Link = null;
			Transform = transform;
			Sibling = null;
		}

		public IKBone(Transform transform, Transform sibling, float weight)
		{
			Weight = weight;
			Link = null;
			Transform = transform;
			Sibling = sibling;
		}
	}
}
