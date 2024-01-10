// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HitEffect
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.Serialization;

namespace CoverShooter
{
	public class HitEffect : MonoBehaviour
	{
		[Tooltip("Effect to be instantiated on the point of bullet impact.")]
		[FormerlySerializedAs("Effect")]
		public GameObject Bullet;

		[Tooltip("Effect to be instantiated on the point of melee impact.")]
		public GameObject Melee;

		[Tooltip("Time to wait before destroying an instantiated effect object.")]
		public float DestroyAfter = 5f;

		private Collider _collider;

		public void OnHit(Hit hit)
		{
			GameObject gameObject = (!hit.IsMelee) ? Bullet : Melee;
			if (!(gameObject == null))
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject);
				gameObject2.transform.SetParent(null);
				gameObject2.transform.position = hit.Position + hit.Normal * 0.1f;
				gameObject2.SetActive(value: true);
				UnityEngine.Object.Destroy(gameObject2, 4f);
			}
		}

		private void Awake()
		{
			_collider = GetComponent<Collider>();
		}

		private void OnValidate()
		{
			DestroyAfter = Mathf.Max(0f, DestroyAfter);
		}
	}
}
