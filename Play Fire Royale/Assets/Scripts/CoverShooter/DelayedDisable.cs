// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DelayedDisable
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class DelayedDisable : MonoBehaviour
	{
		[Tooltip("Time to disable in seconds.")]
		public float Delay = 1f;

		private float _timer;

		private void OnEnable()
		{
			_timer = 0f;
		}

		private void Update()
		{
			_timer += Time.deltaTime;
			if (_timer >= Delay)
			{
				base.gameObject.SetActive(value: false);
			}
		}

		private void OnValidate()
		{
			Delay = Mathf.Max(0f, Delay);
		}
	}
}
