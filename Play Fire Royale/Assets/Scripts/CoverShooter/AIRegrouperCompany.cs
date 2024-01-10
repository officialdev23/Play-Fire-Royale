// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIRegrouperCompany
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(AIMovement))]
	[RequireComponent(typeof(AICommunication))]
	public class AIRegrouperCompany : AIBaseRegrouper
	{
		[Tooltip("Regroup is triggered if number of friends is equal or below the value.")]
		public int TriggerCount;

		private bool _wasTriggered;

		private AICommunication _comm;

		protected override void Awake()
		{
			_comm = GetComponent<AICommunication>();
			base.Awake();
		}

		private void Update()
		{
			if (_comm.FriendCount <= TriggerCount && base.Brain.HasSeenTheEnemy)
			{
				if (!_wasTriggered)
				{
					_wasTriggered = true;
					Regroup();
				}
			}
			else
			{
				_wasTriggered = false;
			}
		}
	}
}
