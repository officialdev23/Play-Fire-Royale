// DecompilerFi decompiler from Assembly-CSharp.dll class: FadeTarget
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct FadeTarget
	{
		public GameObject Object;

		public Vector3 Position;

		public FadeTarget(GameObject obj, Vector3 position)
		{
			Object = obj;
			Position = position;
		}
	}
}
