// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterEffects
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class CharacterEffects : MonoBehaviour, ICharacterPhysicsListener, ICharacterHealthListener
	{
		[Tooltip("Effect prefab to instantiate on each character step.")]
		public GameObject Step;

		[Tooltip("Effect prefab to instantiate when the character lands on ground.")]
		public GameObject Land;

		[Tooltip("Effect prefab to instantiate when the character dies.")]
		public GameObject Death;

		[Tooltip("Effect prefab to instantiate when the character resurrects.")]
		public GameObject Resurrection;

		[Tooltip("Effect prefab to instantiate at the beginning of a jump.")]
		public GameObject Jump;

		[Tooltip("Effect prefab to instantiate when the character is hurt.")]
		public GameObject Hurt;

		[Tooltip("Effect prefab to instantiate when the character blocks a melee attack.")]
		public GameObject Block;

		[Tooltip("Effect prefab to instantiate when the character is hit.")]
		public GameObject Hit;

		[Tooltip("Effect prefab to instantiate when the character is dealt a lot of damage by a hit.")]
		public GameObject BigHit;

		[Tooltip("Damage that has to be dealt to play big hit effect.")]
		public float BigDamageThreshold = 50f;

		private CharacterMotor _motor;

		private float _hurtSoundTimer;

		private float _fallSoundTimer;

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		private void LateUpdate()
		{
			if (_hurtSoundTimer > -1.401298E-45f)
			{
				_hurtSoundTimer -= Time.deltaTime;
			}
			if (_fallSoundTimer > -1.401298E-45f)
			{
				_fallSoundTimer -= Time.deltaTime;
			}
		}

		public void OnLand()
		{
			if (_fallSoundTimer <= 0f && _motor.IsAlive)
			{
				_fallSoundTimer = 0.4f;
				instantiate(Land, base.transform.position);
			}
		}

		public void OnTakenHit(Hit hit)
		{
			if (_motor.IsAlive)
			{
				if (_hurtSoundTimer < float.Epsilon)
				{
					_hurtSoundTimer = 0.5f;
					instantiate(Hurt, hit.Position);
				}
				if (BigHit != null && hit.Damage >= BigDamageThreshold)
				{
					instantiate(BigHit, hit.Position);
				}
				else if (Hit != null)
				{
					instantiate(Hit, hit.Position);
				}
			}
		}

		public void OnFootstep(Vector3 position)
		{
			if (_motor.IsAlive)
			{
				instantiate(Step, position);
			}
		}

		public void OnDead()
		{
			instantiate(Death, base.transform.position);
		}

		public void OnResurrect()
		{
			instantiate(Resurrection, base.transform.position);
		}

		public void OnBlock(Hit hit)
		{
			instantiate(Block, hit.Position);
		}

		public void OnJump()
		{
			if (_motor.IsAlive)
			{
				instantiate(Jump, base.transform.position);
			}
		}

		private void instantiate(GameObject prefab, Vector3 position)
		{
			if (!(prefab == null))
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(prefab);
				gameObject.transform.SetParent(null);
				gameObject.transform.position = position;
				gameObject.SetActive(value: true);
				UnityEngine.Object.Destroy(gameObject, 3f);
			}
		}
	}
}
