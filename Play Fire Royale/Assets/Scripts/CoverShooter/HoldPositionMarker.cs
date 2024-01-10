// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HoldPositionMarker
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class HoldPositionMarker : MonoBehaviour
	{
		[Tooltip("Target marker that projects a texture.")]
		public GameObject Prefab;

		private GameObject _marker;

		private void Awake()
		{
			if (!(Prefab == null))
			{
				_marker = UnityEngine.Object.Instantiate(Prefab);
				_marker.transform.SetParent(null, worldPositionStays: true);
			}
		}

		public void OnHoldPosition(Vector3 value)
		{
			if (!(_marker == null))
			{
				if (!_marker.activeSelf)
				{
					_marker.SetActive(value: true);
				}
				_marker.transform.position = value + Vector3.up * 0.5f;
			}
		}

		public void OnStopHoldingPosition()
		{
			hideMarker();
		}

		private void OnDisable()
		{
			hideMarker();
		}

		private void hideMarker()
		{
			if (_marker != null && _marker.activeSelf)
			{
				_marker.SetActive(value: false);
			}
		}
	}
}
