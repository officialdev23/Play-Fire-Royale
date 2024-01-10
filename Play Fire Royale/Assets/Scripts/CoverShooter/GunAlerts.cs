// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GunAlerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BaseGun))]
	public class GunAlerts : MonoBehaviour, IGunListener
	{
		[Tooltip("Distance at which fire can be heard. Alert is not generated if value is zero or negative.")]
		public float Fire = 20f;

		[Tooltip("Distance at which a failed fire attempt can be heard.")]
		public float EmptyFire = 20f;

		[Tooltip("Distance at which reloads can be heard. Alert is not generated if value is zero or negative.")]
		public float Reload = 10f;

		private BaseGun _gun;

		private Actor _actor;

		private CharacterMotor _cachedMotor;

		private void Awake()
		{
			_gun = GetComponent<BaseGun>();
		}

		public void OnPump()
		{
			if (!(Reload <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Reload,  true, _actor,  true);
			}
		}

		public void OnRechamber()
		{
			if (!(Reload <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Reload,  true, _actor,  true);
			}
		}

		public void OnEject()
		{
			if (!(Reload <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Reload,  true, _actor,  true);
			}
		}

		public void OnFire(float delay)
		{
			if (!(Fire <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Fire,  true, _actor,  true);
			}
		}

		public void OnEmptyFire()
		{
			if (!(EmptyFire <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, EmptyFire,  true, _actor,  true);
			}
		}

		public void OnMagazineLoadStart()
		{
			if (!(Reload <= float.Epsilon))
			{
				checkActor();
				Alerts.Broadcast(base.transform.position, Reload,  true, _actor,  true);
			}
		}

		public void OnFullyLoaded()
		{
		}

		public void OnBulletLoad()
		{
		}

		public void OnPumpStart()
		{
		}

		public void OnBulletLoadStart()
		{
		}

		private void checkActor()
		{
			if (_gun.Character != _cachedMotor)
			{
				_cachedMotor = _gun.Character;
				_actor = _cachedMotor.GetComponent<Actor>();
			}
		}
	}
}
