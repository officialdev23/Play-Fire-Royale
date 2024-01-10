// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIForget
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIForget : AIBase
	{
		[Tooltip("Time in seconds it takes for the AI to forget about the enemy. Time is measured from the moment the last information about the enemy was received.")]
		public float Duration = 30f;

		private bool _isActive;

		private float _time;

		private void OnThreat(Actor value)
		{
			_isActive = true;
			_time = 0f;
		}

		private void OnThreatPosition(Vector3 value)
		{
			_isActive = true;
			_time = 0f;
		}

		private void OnSearch()
		{
			_isActive = true;
			_time = 0f;
		}

		private void Update()
		{
			if (_isActive)
			{
				if (_time >= Duration - float.Epsilon)
				{
					_isActive = false;
					Message("ToForget");
				}
				else
				{
					_time += Time.deltaTime;
				}
			}
		}
	}
}
