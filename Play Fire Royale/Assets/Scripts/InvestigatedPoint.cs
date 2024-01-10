// DecompilerFi decompiler from Assembly-CSharp.dll class: InvestigatedPoint
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct InvestigatedPoint
	{
		public Vector3 Position;

		public float Time;

		public InvestigatedPoint(Vector3 position)
		{
			Position = position;
			Time = UnityEngine.Time.timeSinceLevelLoad;
		}
	}
}
