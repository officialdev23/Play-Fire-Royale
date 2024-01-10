// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HitSounds
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class HitSounds : MonoBehaviour
	{
		[Tooltip("Possible sounds to play on bullet impact.")]
		public AudioClip[] Bullet;

		[Tooltip("Possible sounds to play on melee impact.")]
		public AudioClip[] Melee;

		public void OnHit(Hit hit)
		{
			AudioClip[] array = (!hit.IsMelee) ? Bullet : Melee;
			if (array != null && array.Length != 0)
			{
				AudioClip clip = array[Random.Range(0, array.Length)];
				AudioSource.PlayClipAtPoint(clip, hit.Position);
			}
		}
	}
}
