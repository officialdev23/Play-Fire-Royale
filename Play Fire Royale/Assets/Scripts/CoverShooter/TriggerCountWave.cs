// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TriggerCountWave
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class TriggerCountWave : SpawnGroup
	{
		[Tooltip("Team whose members are counted to check the trigger.")]
		public int TriggerSide;

		[Tooltip("Number of AIs left to trigger a new wave.")]
		public int TriggerCount;

		[Tooltip("Time in seconds to wait before spawning a new wave.")]
		public float TriggerDelay = 1f;

		private float _buildup;

		private void Update()
		{
			int num = 0;
			foreach (Actor item in Actors.All)
			{
				if (item.IsAlive && item.Side == TriggerSide && item.isActiveAndEnabled && item.IsAlive)
				{
					num++;
				}
			}
			if (num <= TriggerCount)
			{
				_buildup += Time.deltaTime;
				if (_buildup >= TriggerDelay)
				{
					Spawn(null);
					_buildup = 0f;
				}
			}
			else
			{
				_buildup = 0f;
			}
		}
	}
}
