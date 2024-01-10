// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterPlatform
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CharacterPlatform : MonoBehaviour
	{
		[Tooltip("Distance below feet to check for ground.")]
		[Range(0f, 1f)]
		public float Threshold = 0.2f;

		private GameObject _platform;

		private GameObject _previousPlatform;

		private Vector3 _lastLocalPointOnPlatform;

		private Vector3 _lastPlatformRelevantPosition;

		private RaycastHit[] _cache = new RaycastHit[16];

		private void LateUpdate()
		{
			findPlatform();
			if (_platform != null && _platform == _previousPlatform)
			{
				Transform transform = base.transform;
				Vector3 eulerAngles = _platform.transform.eulerAngles;
				float y = eulerAngles.y;
				Vector3 eulerAngles2 = _previousPlatform.transform.eulerAngles;
				transform.Rotate(0f, y - eulerAngles2.y, 0f);
				base.transform.position += _platform.transform.TransformPoint(_lastLocalPointOnPlatform) - _lastPlatformRelevantPosition;
				updatePlatformPoints();
			}
			_previousPlatform = _platform;
		}

		private void updatePlatformPoints()
		{
			_lastPlatformRelevantPosition = base.transform.position;
			_lastLocalPointOnPlatform = _platform.transform.InverseTransformPoint(base.transform.position);
		}

		private void findPlatform()
		{
			GameObject gameObject = null;
			float num = Threshold + 0.1f;
			if (_platform != null)
			{
				Vector3 vector = _platform.transform.TransformPoint(_lastLocalPointOnPlatform) - _lastPlatformRelevantPosition;
				if (vector.y < 0f)
				{
					num -= vector.y;
				}
			}
			int num2 = Physics.RaycastNonAlloc(base.transform.position + Vector3.up * 0.1f, Vector3.down, _cache, num, Layers.Geometry);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = _cache[i];
				if (!raycastHit.collider.isTrigger && raycastHit.collider.gameObject != base.gameObject)
				{
					gameObject = raycastHit.collider.gameObject;
				}
			}
			if (gameObject != _platform && gameObject != null)
			{
				_platform = gameObject;
				updatePlatformPoints();
			}
			else
			{
				_platform = gameObject;
			}
		}
	}
}
