// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIRegrouperHealth
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(AIMovement))]
	[RequireComponent(typeof(CharacterHealth))]
	public class AIRegrouperHealth : AIBaseRegrouper
	{
		[Tooltip("Fraction of health that triggers a regroup.")]
		[Range(0f, 1f)]
		public float Health = 0.4f;

		private bool _wasTriggered;

		private CharacterHealth _health;

		protected override void Awake()
		{
			_health = GetComponent<CharacterHealth>();
			base.Awake();
		}

		private void Update()
		{
			if (_health.Health / _health.MaxHealth <= Health && base.Brain.Threat != null)
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
