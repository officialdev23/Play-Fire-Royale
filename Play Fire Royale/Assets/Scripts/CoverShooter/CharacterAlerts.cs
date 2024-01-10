// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterAlerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CharacterAlerts : MonoBehaviour, ICharacterPhysicsListener, ICharacterHealthListener
	{
		[Tooltip("Distance at which step can be heard. Alert is not generated if value is zero or negative.")]
		public float Step = 10f;

		[Tooltip("Distance at which step can be heard. Alert is not generated if value is zero or negative.")]
		public float Hurt = 10f;

		[Tooltip("Distance at which step can be heard. Alert is not generated if value is zero or negative.")]
		public float Death = 10f;

		[Tooltip("Distance at which step can be heard. Alert is not generated if value is zero or negative.")]
		public float Jump = 10f;

		[Tooltip("Distance at which step can be heard. Alert is not generated if value is zero or negative.")]
		public float Land = 10f;

		[Tooltip("Distance at which character's resurrection will be heard.Alert is not generated if value is zero or negative.")]
		public float Resurrect = 10f;

		private Actor _actor;

		private CharacterMotor _motor;

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		public void OnLand()
		{
			Alerts.Broadcast(base.transform.position, Land,  false, _actor,  true);
		}

		public void OnHit(Hit hit)
		{
			Alerts.Broadcast(base.transform.position, Hurt,  true, _actor,  true);
		}

		public void OnFootstep(Vector3 position)
		{
			if (_motor == null || (!_motor.IsCrouching && !_motor.IsInCover))
			{
				Alerts.Broadcast(base.transform.position, Step,  false, _actor,  true);
			}
		}

		public void OnDead()
		{
			Alerts.Broadcast(base.transform.position, Death,  true, _actor,  true);
		}

		public void OnResurrect()
		{
			Alerts.Broadcast(base.transform.position, Resurrect,  false, _actor,  true);
		}

		public void OnJump()
		{
			Alerts.Broadcast(base.transform.position, Jump,  false, _actor,  true);
		}
	}
}
