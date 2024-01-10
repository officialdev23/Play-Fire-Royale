// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GunSounds
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

namespace CoverShooter
{
	public class GunSounds : MonoBehaviour, IGunListener
	{
		[Tooltip("Sound to play when ejecting a magazine.")]
		public AudioClip[] Eject;

		[Tooltip("Sound to play when a magazine is put inside the gun.")]
		public AudioClip[] Rechamber;

		[Tooltip("Possible sounds to when pumping a shotgun.")]
		public AudioClip[] Pump;

		[Tooltip("Possible sounds to play on each bullet fire.")]
		public AudioClip[] Fire;

		[Tooltip("Possible sounds to play on each fire attempt on empty magazine.")]
		public AudioClip[] EmptyFire;

		public void OnPump()
		{
			if (Pump.Length > 0)
			{
				play(Pump[Random.Range(0, Pump.Length)]);
			}
		}

		public void OnEject()
		{
			if (Eject.Length > 0)
			{
				play(Eject[Random.Range(0, Eject.Length)]);
			}
		}

		public void OnRechamber()
		{
			if (Rechamber.Length > 0)
			{
				play(Rechamber[Random.Range(0, Rechamber.Length)]);
			}
		}

		public void OnFire(float delay)
		{
			StartCoroutine(play(delay, Fire));
		}

		public void OnEmptyFire()
		{
			if (EmptyFire.Length > 0)
			{
				play(EmptyFire[Random.Range(0, EmptyFire.Length)]);
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

		public void OnMagazineLoadStart()
		{
		}

		public void OnBulletLoadStart()
		{
		}

		private void play(AudioClip clip)
		{
			if (clip != null)
			{
				AudioSource.PlayClipAtPoint(clip, base.transform.position);
			}
		}

		private void play(AudioClip[] clips)
		{
			if (clips.Length > 0)
			{
				play(clips[Random.Range(0, clips.Length)]);
			}
		}

		private IEnumerator play(float delay, AudioClip[] clips)
		{
			yield return new WaitForSeconds(delay);
			play(clips);
		}
	}
}
