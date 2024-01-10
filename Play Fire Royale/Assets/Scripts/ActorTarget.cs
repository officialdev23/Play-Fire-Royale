// DecompilerFi decompiler from Assembly-CSharp.dll class: ActorTarget
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct ActorTarget
	{
		public Vector3 Position;

		public Vector3 RelativeTopPosition;

		public Vector3 RelativeStandingTopPosition;

		public ActorTarget(Vector3 position, Vector3 relativeTopPosition, Vector3 relativeStandingTopPosition)
		{
			Position = position;
			RelativeTopPosition = relativeTopPosition;
			RelativeStandingTopPosition = relativeStandingTopPosition;
		}
	}
}
