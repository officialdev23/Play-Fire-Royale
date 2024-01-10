// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SpawnGroup
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class SpawnGroup : MonoBehaviour
	{
		[Tooltip("Positions at which the characters are spawned. Taken from child objects if not specified.")]
		public SpawnPoint[] SpawnPointOverride;

		[Tooltip("Prefabs to use when spawning. Overrides the ones specified in the SpawnPoints.")]
		public GameObject[] PrefabOverride;

		[Tooltip("Should the PrefabOverride be used only on the spawn points that have no prefabs specified.")]
		public bool OnlyOverrideEmptySpawnPoints = true;

		[Tooltip("Another spawn group to trigger instead by random chance.")]
		public SpawnGroup Secondary;

		[Tooltip("Chance that a secondary spawn group will be used. Ignored if it not set to any.")]
		[Range(0f, 1f)]
		public float SecondaryChance = 0.5f;

		[Tooltip("Time in seconds before another call to spawn is allowed. Ignored by SpawnPicker.")]
		public float MinInterval = 1f;

		private List<SpawnPoint> _points = new List<SpawnPoint>();

		private float _lastTime;

		public IEnumerable<SpawnPoint> Points
		{
			get
			{
				if (SpawnPointOverride != null && SpawnPointOverride.Length > 0)
				{
					return SpawnPointOverride;
				}
				return _points;
			}
		}

		private void Awake()
		{
			for (int i = 0; i < base.transform.childCount; i++)
			{
				SpawnPoint component = base.transform.GetChild(i).GetComponent<SpawnPoint>();
				if (component != null)
				{
					_points.Add(component);
				}
			}
		}

		public void Spawn(Actor caller)
		{
			foreach (GameObject item in SpawnAndReturn(int.MaxValue, caller))
			{
			}
		}

		public IEnumerable<GameObject> SpawnAndReturn(int max, Actor caller, bool isForced = false)
		{
			if (Secondary != null && UnityEngine.Random.Range(0f, 1f) <= SecondaryChance)
			{
				foreach (GameObject item in Secondary.SpawnAndReturn(max, caller))
				{
					yield return item;
				}
			}
			else if (isForced || !(Time.timeSinceLevelLoad - _lastTime < MinInterval))
			{
				_lastTime = Time.timeSinceLevelLoad;
				foreach (SpawnPoint point in Points)
				{
					if (PrefabOverride == null || PrefabOverride.Length == 0)
					{
						yield return point.Spawn(caller);
					}
					else if (point.Prefabs == null || point.Prefabs.Length == 0 || !OnlyOverrideEmptySpawnPoints)
					{
						yield return SpawnPoint.SpawnPrefab(PrefabOverride[Random.Range(0, PrefabOverride.Length)], point.transform.position, caller);
					}
					else
					{
						yield return point.Spawn(caller);
					}
				}
			}
		}

		public IEnumerable<GameObject> SpawnAndReturn(int max, GameObject[] prefabs, Actor caller, bool isForced = false)
		{
			if (Secondary != null && UnityEngine.Random.Range(0f, 1f) <= SecondaryChance)
			{
				foreach (GameObject item in Secondary.SpawnAndReturn(max, prefabs, caller))
				{
					yield return item;
				}
			}
			else if (isForced || !(Time.timeSinceLevelLoad - _lastTime < MinInterval))
			{
				_lastTime = Time.timeSinceLevelLoad;
				int i = 0;
				foreach (SpawnPoint point in Points)
				{
					if (i >= max)
					{
						break;
					}
					i++;
					yield return SpawnPoint.SpawnPrefab(prefabs[Random.Range(0, prefabs.Length)], point.transform.position, caller);
				}
			}
		}
	}
}
