// DecompilerFi decompiler from Assembly-CSharp.dll class: Character
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct Character
	{
		public bool IsValid;

		public GameObject Object;

		public CharacterMotor Motor;

		public Actor Actor;

		public bool IsInSight(float height, float delta)
		{
			float num = delta * (float)Screen.height / (float)Screen.width;
			Vector3 vector = ViewportPoint(height);
			return vector.x >= 0f - num && vector.y >= 0f - delta && vector.x <= 1f + num && vector.y <= 1f + delta && vector.z > 0f;
		}

		public bool IsAnyInSight(float delta)
		{
			float num = delta * (float)Screen.height / (float)Screen.width;
			Vector3 vector = ViewportPoint();
			if (vector.x >= 0f - num && vector.y >= 0f - delta && vector.x <= 1f + num && vector.y <= 1f + delta && vector.z > 0f)
			{
				return true;
			}
			vector = ViewportPoint(2f);
			if (vector.x >= 0f - num && vector.y >= 0f - delta && vector.x <= 1f + num && vector.y <= 1f + delta && vector.z > 0f)
			{
				return true;
			}
			return false;
		}

		public Vector3 ViewportPoint(float height = 0f)
		{
			if (Object == null || CameraManager.Main == null)
			{
				return Vector2.zero;
			}
			return CameraManager.Main.WorldToViewportPoint(Object.transform.position);
		}
	}
}
