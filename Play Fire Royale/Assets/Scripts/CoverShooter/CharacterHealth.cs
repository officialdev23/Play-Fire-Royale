// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterHealth
// SourcesPostProcessor 
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class CharacterHealth : MonoBehaviour, ICharacterHealthListener
	{
		[Tooltip("Current health of the character.")]
		public float Health = 100f;

		public int tipo;

		[Tooltip("Max health to regenerate to.")]
		public float MaxHealth = 100f;

		[Tooltip("Amount of health regenerated per second.")]
		public float Regeneration;

		[Tooltip("How much the incoming damage is multiplied by.")]
		public float DamageMultiplier = 1f;

		[Tooltip("Does the component reduce damage on hits. Usually used for debugging purposes to make immortal characters.")]
		public bool IsTakingDamage = true;

		[Tooltip("Are bullet hits done to the main collider registered as damage.")]
		public bool IsRegisteringHits = true;

		public Action Died;

		public Action<float> Hurt;

		public Action<float> Healed;

		public Action<float> Changed;

		private CharacterMotor _motor;

		private bool _isDead;

		private float _previousHealth;

		private static Dictionary<GameObject, CharacterHealth> _map = new Dictionary<GameObject, CharacterHealth>();

		public GameObject cura;

		public int pode;

		public static CharacterHealth Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return null;
		}

		public static bool Contains(GameObject gameObject)
		{
			return _map.ContainsKey(gameObject);
		}

		private void Awake()
		{
			_previousHealth = Health;
			_motor = GetComponent<CharacterMotor>();
		}

		private void OnEnable()
		{
			_map[base.gameObject] = this;
		}

		private void OnDisable()
		{
			_map.Remove(base.gameObject);
		}

		private void OnValidate()
		{
			Health = Mathf.Max(0f, Health);
			MaxHealth = Mathf.Max(0f, MaxHealth);
		}

		private void LateUpdate()
		{
			if (!_isDead)
			{
				Health = Mathf.Clamp(Health + Regeneration * Time.deltaTime, 0f, MaxHealth);
				check();
			}
		}

		public void OnResurrect()
		{
			_isDead = false;
			if (Health <= float.Epsilon)
			{
				Health = 0.001f;
			}
		}

		private IEnumerator desliga()
		{
			yield return new WaitForSeconds(3f);
			cura.SetActive(value: false);
			pode = 0;
		}

		private void OnTriggerEnter(Collider other)
		{
			if (tipo == 1 && other.tag == "saude" && pode == 0)
			{
				Health += 200f;
				cura.SetActive(value: true);
				StartCoroutine(desliga());
				pode = 1;
			}
		}

		public void OnDead()
		{
			bool isDead = _isDead;
			_isDead = true;
			Health = 0f;
			if (!isDead && Died != null)
			{
				Died();
			}
		}

		public void OnTakenHit(Hit hit)
		{
			Deal(hit.Damage);
		}

		public void Heal(float amount)
		{
			Health = Mathf.Clamp(Health + amount, 0f, MaxHealth);
			if (Health > float.Epsilon && _motor != null && !_motor.IsAlive)
			{
				_motor.Resurrect();
			}
			if (!_isDead)
			{
				check();
			}
		}

		public void Deal(float amount)
		{
			if (!(Health <= 0f) && IsTakingDamage)
			{
				amount *= DamageMultiplier;
				Health = Mathf.Clamp(Health - amount, 0f, MaxHealth);
				check();
				if (Health <= 0f && _motor != null)
				{
					_motor.Die();
				}
			}
		}

		private void check()
		{
			if (_previousHealth != Health)
			{
				_previousHealth = Health;
				if (Changed != null)
				{
					Changed(Health);
				}
				if (_previousHealth < Health && Healed != null)
				{
					Healed(Health);
				}
				if (_previousHealth > Health && Hurt != null)
				{
					Hurt(Health);
				}
			}
		}
	}
}
