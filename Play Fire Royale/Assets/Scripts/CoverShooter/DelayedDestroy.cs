// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DelayedDestroy
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class DelayedDestroy : MonoBehaviour
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
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}

		private void OnValidate()
		{
			Delay = Mathf.Max(0f, Delay);
		}
	}
}
