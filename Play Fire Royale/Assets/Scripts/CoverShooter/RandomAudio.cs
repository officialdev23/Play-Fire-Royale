// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.RandomAudio
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(AudioSource))]
	public class RandomAudio : MonoBehaviour
	{
		[Tooltip("Array of possible audio clips to be played.")]
		public AudioClip[] Clips;

		[Tooltip("Should the clip selection happen during the object's awakening.")]
		public bool PlayOnAwake = true;

		private void Awake()
		{
			if (PlayOnAwake)
			{
				Play();
			}
		}

		public void Play()
		{
			if (Clips.Length != 0)
			{
				AudioSource component = GetComponent<AudioSource>();
				if (!(component == null))
				{
					component.clip = Clips[Random.Range(0, Clips.Length)];
					component.Play();
				}
			}
		}
	}
}
