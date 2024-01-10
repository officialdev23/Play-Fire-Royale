// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.EffectAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public abstract class EffectAction : AIAction
	{
		[Tooltip("Hit effect prefab that is instantiated on hit.")]
		public GameObject EffectPrefab;

		[Tooltip("Random sounds played on hit.")]
		public AudioClip[] Sounds;

		protected void PlayEffect(Actor parent, Vector3 position)
		{
			if (EffectPrefab != null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(EffectPrefab);
				gameObject.transform.position = position;
				if (parent != null)
				{
					gameObject.transform.SetParent(parent.transform, worldPositionStays: true);
				}
				gameObject.SetActive(value: true);
				UnityEngine.Object.Destroy(gameObject, 3f);
			}
			if (Sounds.Length > 0)
			{
				AudioClip clip = Sounds[UnityEngine.Random.Range(0, Sounds.Length)];
				AudioSource.PlayClipAtPoint(clip, position);
			}
		}
	}
}
