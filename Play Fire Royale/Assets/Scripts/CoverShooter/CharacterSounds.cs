// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterSounds
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class CharacterSounds : MonoBehaviour, ICharacterPhysicsListener, ICharacterHealthListener
	{
		[Tooltip("Possible sounds to play on each footstep.")]
		public AudioClip[] Footstep;

		[Tooltip("Possible sounds to play when the character dies.")]
		public AudioClip[] Death;

		[Tooltip("Possible sounds to play at the beginning of a jump.")]
		public AudioClip[] Jump;

		[Tooltip("Possible sounds to play when the character lands.")]
		public AudioClip[] Land;

		[Tooltip("Possible sounds to play when the character blocks a melee attack.")]
		public AudioClip[] Block;

		[Tooltip("Possible sounds to play when the character is hurt.")]
		public AudioClip[] Hurt;

		[Tooltip("Possible sounds to play when the character is hit.")]
		public AudioClip[] Hit;

		[Tooltip("Possible sounds to play when the character is dealt a lot of damage by a hit.")]
		public AudioClip[] BigHit;

		[Tooltip("Damage that has to be dealt to play big hit sound.")]
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
				playSound(Land, base.transform.position);
			}
		}

		public void OnFootstep(Vector3 position)
		{
			if (_motor.IsAlive)
			{
				playSound(Footstep, position);
			}
		}

		public void OnDead()
		{
			playSound(Death, base.transform.position, 0.3f);
		}

		public void OnResurrect()
		{
		}

		public void OnBlock(Hit hit)
		{
			playSound(Block, hit.Position);
		}

		public void OnJump()
		{
			if (_motor.IsAlive)
			{
				playSound(Jump, base.transform.position);
			}
		}

		public void OnTakenHit(Hit hit)
		{
			if (_hurtSoundTimer < float.Epsilon && _motor.IsAlive)
			{
				_hurtSoundTimer = 0.5f;
				playSound(Hurt, hit.Position, 0.1f);
			}
			if (BigHit != null && BigHit.Length > 0 && hit.Damage >= BigDamageThreshold)
			{
				playSound(BigHit, hit.Position);
			}
			else
			{
				playSound(Hit, hit.Position);
			}
		}

		private void playSound(AudioClip[] clips, Vector3 position, float delay = 0f)
		{
			if (clips.Length != 0)
			{
				AudioClip clip = clips[Random.Range(0, clips.Length)];
				if (delay < float.Epsilon)
				{
					AudioSource.PlayClipAtPoint(clip, position);
				}
				else
				{
					StartCoroutine(delayedClip(clip, position, delay));
				}
			}
		}

		private IEnumerator delayedClip(AudioClip clip, Vector3 position, float delay)
		{
			yield return new WaitForSeconds(delay);
			AudioSource.PlayClipAtPoint(clip, position);
		}
	}
}
