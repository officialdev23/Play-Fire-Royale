// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SpawnPoint
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class SpawnPoint : MonoBehaviour
	{
		[Tooltip("A random prefab is taken to be instantiated during a spawn.")]
		public GameObject[] Prefabs;

		public static GameObject SpawnPrefab(GameObject prefab, Vector3 position, Actor caller)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(prefab);
			gameObject.transform.SetParent(null);
			gameObject.transform.position = position;
			gameObject.SetActive(value: true);
			gameObject.SendMessage("OnSpawn", caller);
			return gameObject;
		}

		public GameObject Spawn(Actor caller)
		{
			if (Prefabs == null || Prefabs.Length == 0)
			{
				return null;
			}
			return SpawnPrefab(Prefabs[Random.Range(0, Prefabs.Length)], base.transform.position, caller);
		}
	}
}
