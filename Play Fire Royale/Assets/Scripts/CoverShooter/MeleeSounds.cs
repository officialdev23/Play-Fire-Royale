// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MeleeSounds
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class MeleeSounds : MonoBehaviour, IMeleeListener
	{
		[Tooltip("Sounds to be played when attacking.")]
		public AudioClip[] Attack;

		[Tooltip("Sounds to be played upon a successful hit.")]
		public AudioClip[] Hit;

		[Tooltip("Sounds to be played upon a specific melee moment defined by the animation.")]
		public AudioClip[] Moment;

		public void OnMeleeAttack()
		{
			if (Attack.Length > 0)
			{
				play(Attack[Random.Range(0, Attack.Length)]);
			}
		}

		public void OnMeleeHit()
		{
			if (Hit.Length > 0)
			{
				play(Hit[Random.Range(0, Hit.Length)]);
			}
		}

		public void OnMeleeMoment()
		{
			if (Moment.Length > 0)
			{
				play(Moment[Random.Range(0, Moment.Length)]);
			}
		}

		private void play(AudioClip clip)
		{
			if (clip != null)
			{
				AudioSource.PlayClipAtPoint(clip, base.transform.position);
			}
		}
	}
}
