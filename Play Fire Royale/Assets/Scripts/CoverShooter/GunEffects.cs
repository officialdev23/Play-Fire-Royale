// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GunEffects
// SourcesPostProcessor 
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BaseGun))]
	public class GunEffects : MonoBehaviour, IGunListener
	{
		[Tooltip("Object to instantiate when ejecting a magazine.")]
		public GameObject Eject;

		[Tooltip("Object to instantiate when a magazine is put inside the gun.")]
		public GameObject Rechamber;

		[Tooltip("Object to instantiate on each bullet fire.")]
		public GameObject Fire;

		[Tooltip("Object to instantiate on each shotgun pump.")]
		public GameObject Pump;

		[Tooltip("Object to instantiate on each fire attempt with an empty magazine.")]
		public GameObject EmptyFire;

		[Tooltip("Object to instantiate to simulate shell ejection.")]
		public GameObject Shell;

		private List<GameObject> _particles = new List<GameObject>();

		private List<Coroutine> _coroutines = new List<Coroutine>();

		private BaseGun _gun;

		private void Awake()
		{
			_gun = GetComponent<BaseGun>();
		}

		public void OnEject()
		{
			instantiate(Eject, null, base.transform.position, Quaternion.identity);
		}

		public void OnRechamber()
		{
			instantiate(Rechamber, null, base.transform.position, Quaternion.identity);
		}

		public void OnPump()
		{
			instantiate(Pump, null, base.transform.position, Quaternion.identity);
		}

		public void OnFire(float delay)
		{
			if (_gun != null && _gun.Aim != null)
			{
				_coroutines.Add(StartCoroutine(play(delay, Fire, _gun.Aim.transform, Vector3.zero, Quaternion.identity)));
			}
			_coroutines.Add(StartCoroutine(play(delay, Shell, null, base.transform.position, Quaternion.identity)));
		}

		public void OnEmptyFire()
		{
			if (!(EmptyFire == null))
			{
				instantiate(EmptyFire, null, base.transform.position, Quaternion.identity, 3f);
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

		private void LateUpdate()
		{
			for (int num = _particles.Count - 1; num >= 0; num--)
			{
				GameObject x = _particles[num];
				if (x == null)
				{
					_particles.RemoveAt(num);
				}
			}
			for (int num2 = _coroutines.Count - 1; num2 >= 0; num2--)
			{
				Coroutine coroutine = _coroutines[num2];
				if (coroutine == null)
				{
					_coroutines.RemoveAt(num2);
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
			for (int j = 0; j < _coroutines.Count; j++)
			{
				Coroutine coroutine = _coroutines[j];
				if (coroutine != null)
				{
					StopCoroutine(coroutine);
				}
			}
			_coroutines.Clear();
		}

		private IEnumerator play(float delay, GameObject prefab, Transform parent, Vector3 position, Quaternion rotation, float destroyAfter = 4f)
		{
			if (!(prefab == null))
			{
				yield return new WaitForSeconds(delay);
				instantiate(prefab, parent, position, rotation, destroyAfter);
			}
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
