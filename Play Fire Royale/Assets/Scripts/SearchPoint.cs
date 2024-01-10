// DecompilerFi decompiler from Assembly-CSharp.dll class: SearchPoint
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct SearchPoint
	{
		public Vector3 Position;

		public Vector3 Normal;

		public Vector3 ApproachPosition;

		public bool HasNormal;

		public float Visibility;

		public int Left;

		public int Right;

		public bool RequiresReaching;

		public SearchPoint(Vector3 position, Vector3 approachPosition, Vector3 normal, bool requiresReaching)
		{
			Position = position;
			ApproachPosition = approachPosition;
			Normal = normal;
			HasNormal = true;
			Visibility = 9999999f;
			Left = -1;
			Right = -1;
			RequiresReaching = requiresReaching;
		}

		public SearchPoint(Vector3 position, Vector3 normal, bool requiresReaching)
		{
			Position = position;
			ApproachPosition = position;
			Normal = normal;
			HasNormal = true;
			Visibility = 9999999f;
			Left = -1;
			Right = -1;
			RequiresReaching = requiresReaching;
		}

		public SearchPoint(Vector3 position, bool requiresReaching)
		{
			Position = position;
			ApproachPosition = position;
			Normal = Vector3.zero;
			HasNormal = false;
			Visibility = 9999999f;
			Left = -1;
			Right = -1;
			RequiresReaching = requiresReaching;
		}

		public void CalcVisibility(float maxDistance, bool isAlerted)
		{
			Visibility = Util.GetViewDistance(Position, maxDistance, isAlerted);
		}
	}
}
