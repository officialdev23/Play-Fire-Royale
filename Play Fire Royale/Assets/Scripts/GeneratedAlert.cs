// DecompilerFi decompiler from Assembly-CSharp.dll class: GeneratedAlert
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct GeneratedAlert
	{
		public Vector3 Position;

		public float Range;

		public bool IsHostile;

		public Actor Actor;

		public bool IsDirect;

		public GeneratedAlert(Vector3 position, float range, bool isHostile, Actor actor, bool isDirect)
		{
			Position = position;
			Range = range;
			IsHostile = isHostile;
			Actor = actor;
			IsDirect = isDirect;
		}
	}
}
