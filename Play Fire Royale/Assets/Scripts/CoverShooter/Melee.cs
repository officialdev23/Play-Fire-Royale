// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Melee
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class Melee : BaseMelee
	{
		[Tooltip("Damage done by a melee attack.")]
		public float Damage = 20f;

		[Tooltip("Time in seconds for to wait for another melee hit.")]
		public float Cooldown = 0.5f;

		[Tooltip("Time in seconds between hits that the character will respond to with hurt animations.")]
		public float DamageResponseWaitTime;

		private bool _isAttacking;

		private bool _isScanning;

		private float _cooldown;

		private List<GameObject> _receptors = new List<GameObject>();

		private IMeleeListener[] _listeners;

		private Collider _collider;

		private void Awake()
		{
			_collider = GetComponent<Collider>();
			_listeners = Util.GetInterfaces<IMeleeListener>(base.gameObject);
		}

		private void OnTriggerEnter(Collider other)
		{
			if (!_isAttacking || !_isScanning || (Character != null && other.gameObject == Character.gameObject))
			{
				return;
			}
			BulletShield x = BulletShield.Get(other.gameObject);
			if (x != null)
			{
				return;
			}
			BodyPartHealth component = other.GetComponent<BodyPartHealth>();
			GameObject gameObject = (!(component == null) && !(component.Target == null)) ? component.Target.gameObject : other.gameObject;
			if (!_receptors.Contains(gameObject))
			{
				_receptors.Add(gameObject);
				Vector3 normalized = (Character.transform.position - gameObject.transform.position).normalized;
				HitType type;
				switch (Type)
				{
				case WeaponType.Pistol:
					type = HitType.PistolMelee;
					break;
				case WeaponType.Rifle:
					type = HitType.RifleMelee;
					break;
				case WeaponType.Shotgun:
					type = HitType.ShotgunMelee;
					break;
				case WeaponType.Sniper:
					type = HitType.SniperMelee;
					break;
				case WeaponType.Fist:
					type = HitType.Fist;
					break;
				case WeaponType.Machete:
					type = HitType.Machete;
					break;
				default:
					type = HitType.Fist;
					break;
				}
				Hit hit = new Hit(other.ClosestPointOnBounds(base.transform.position), normalized, Damage, Character.gameObject, other.gameObject, type, DamageResponseWaitTime);
				other.SendMessage("OnHit", hit, SendMessageOptions.DontRequireReceiver);
				for (int i = 0; i < _listeners.Length; i++)
				{
					_listeners[i].OnMeleeHit();
				}
			}
		}

		public override bool Request()
		{
			return !_isAttacking && _cooldown <= float.Epsilon;
		}

		public override void Begin()
		{
			_isAttacking = true;
			_isScanning = false;
			_cooldown = Cooldown;
			_collider.enabled = false;
		}

		public override void End()
		{
			_isAttacking = false;
		}

		public override void BeginScan()
		{
			if (!_isScanning)
			{
				_isScanning = true;
				_collider.enabled = true;
				_receptors.Clear();
				for (int i = 0; i < _listeners.Length; i++)
				{
					_listeners[i].OnMeleeAttack();
				}
			}
		}

		public override void EndScan()
		{
			if (_isScanning)
			{
				_collider.enabled = false;
				_isScanning = false;
			}
		}

		public override void Moment()
		{
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnMeleeMoment();
			}
		}

		private void Update()
		{
			if (_cooldown > float.Epsilon)
			{
				_cooldown -= Time.deltaTime;
			}
		}
	}
}
