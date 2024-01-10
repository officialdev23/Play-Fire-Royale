// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MeleeEffects
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BaseMelee))]
	public class MeleeEffects : MonoBehaviour, IMeleeListener
	{
		[Tooltip("Object to instantiate when attacking.")]
		public GameObject Attack;

		[Tooltip("Object to instantiate when hitting.")]
		public GameObject Hit;

		[Tooltip("Object to instantiate when attacking during a specific animation moment.")]
		public GameObject Moment;

		private List<GameObject> _particles = new List<GameObject>();

		public void OnMeleeAttack()
		{
			instantiate(Attack, null, base.transform.position, Quaternion.identity);
		}

		public void OnMeleeHit()
		{
			instantiate(Hit, null, base.transform.position, Quaternion.identity);
		}

		public void OnMeleeMoment()
		{
			instantiate(Moment, null, base.transform.position, Quaternion.identity);
		}

		private void LateUpdate()
		{
			int num = 0;
			while (num < _particles.Count)
			{
				if (_particles[num] == null)
				{
					_particles.RemoveAt(num);
				}
				else
				{
					num++;
				}
			}
			for (int num2 = _particles.Count - 1; num2 >= 0; num2--)
			{
				GameObject x = _particles[num2];
				if (x == null)
				{
					_particles.RemoveAt(num2);
				}
			}
		}

		private void OnDisable()
		{
			for (int i = 0; i < _particles.Count; i++)
			{
				GameObject gameObject = _particles[i];
				if (gameObject != null)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
			_particles.Clear();
		}

		private void instantiate(GameObject prefab, Transform parent, Vector3 position, Quaternion rotation, float destroyAfter = 4f)
		{
			if (!(prefab == null))
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(prefab);
				gameObject.transform.SetParent(parent);
				gameObject.transform.localPosition = position;
				gameObject.transform.localRotation = rotation;
				gameObject.SetActive(value: true);
				_particles.Add(gameObject);
				UnityEngine.Object.Destroy(gameObject, destroyAfter);
			}
		}
	}
}
