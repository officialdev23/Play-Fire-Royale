// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MeleeAlerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BaseMelee))]
	public class MeleeAlerts : MonoBehaviour, IMeleeListener
	{
		[Tooltip("Distance at which any attack can be heard. Alert is not generated if value is zero or negative.")]
		public float Attack;

		[Tooltip("Distance at which a hit can be heard. Alert is not generated if value is zero or negative.")]
		public float Hit = 20f;

		[Tooltip("Distance at which a melee moment can be heard. Alert is not generated if value is zero or negative.")]
		public float Moment;

		private BaseMelee _melee;

		private Actor _actor;

		private CharacterMotor _cachedMotor;

		private void Awake()
		{
			_melee = GetComponent<BaseMelee>();
		}

		public void OnMeleeAttack()
		{
			if (!(Attack <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Attack,  true, _actor,  true);
			}
		}

		public void OnMeleeHit()
		{
			if (!(Hit <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Hit,  true, _actor,  true);
			}
		}

		public void OnMeleeMoment()
		{
			if (!(Moment <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Moment,  true, _actor,  true);
			}
		}

		private void checkActor()
		{
			if (_melee.Character != _cachedMotor)
			{
				_cachedMotor = _melee.Character;
				_actor = _cachedMotor.GetComponent<Actor>();
			}
		}
	}
}
