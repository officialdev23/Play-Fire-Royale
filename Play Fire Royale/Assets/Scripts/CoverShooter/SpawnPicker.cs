// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SpawnPicker
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class SpawnPicker : MonoBehaviour
	{
		[Tooltip("A list of areas, the best will be chosen to spawn enemies.")]
		public SpawnGroup[] Areas;

		[Tooltip("Minimal number of possible spawn points used in a group.")]
		public int MinCount = 999;

		[Tooltip("Maximum number of possible spawn points used in a group.")]
		public int MaxCount = 999;

		[Tooltip("Player whose vision and position are used to determine which area is the best for spawning.")]
		public CharacterMotor Player;

		[Tooltip("An area won't be considered if it is closer than this distance.")]
		public float MinDistance = 32f;

		[Tooltip("Prefabs to use when spawning. Overrides the ones specified in SpawnGroups.")]
		public GameObject[] PrefabOverride;

		[Tooltip("Time in seconds before another call to spawn is allowed.")]
		public float MinInterval = 6f;

		[Tooltip("Another spawn picker to trigger instead by random chance.")]
		public SpawnPicker Secondary;

		[Tooltip("Chance that a secondary picker group will be used. Ignored if it not set to any.")]
		[Range(0f, 1f)]
		public float SecondaryChance = 0.5f;

		[Tooltip("By default Secondary Chance is evaluated only if Secondary is not none. Enabling this property allows evaluating even if Secondary is none.")]
		public bool UseNoneSecondary;

		private List<GameObject> _empty = new List<GameObject>();

		private List<SpawnGroup> _fitting = new List<SpawnGroup>();

		private float _lastTime;

		public void Spawn(Actor caller)
		{
			if ((UseNoneSecondary || Secondary != null) && UnityEngine.Random.Range(0f, 1f) <= SecondaryChance)
			{
				if (Secondary != null)
				{
					Secondary.Spawn(caller);
				}
			}
			else
			{
				if (Areas == null || Areas.Length == 0)
				{
					return;
				}
				_fitting.Clear();
				if (Player != null)
				{
					Vector3 lhs = Util.HorizontalVector(Player.BodyAngle);
					SpawnGroup[] areas = Areas;
					foreach (SpawnGroup spawnGroup in areas)
					{
						if (spawnGroup != null && !(Vector3.Distance(spawnGroup.transform.position, Player.transform.position) < MinDistance))
						{
							float num = Vector3.Dot(lhs, spawnGroup.transform.position - Player.transform.position);
							if (num < 0f)
							{
								_fitting.Add(spawnGroup);
							}
						}
					}
				}
				if (_fitting.Count == 0)
				{
					SpawnSpecific(Areas[Random.Range(0, Areas.Length)], caller);
				}
				else
				{
					SpawnSpecific(_fitting[Random.Range(0, _fitting.Count)], caller);
				}
			}
		}

		public void SpawnSpecific(SpawnGroup group, Actor caller, bool isForced = false)
		{
			if (!(group == null))
			{
				foreach (GameObject item in SpawnAndReturn(group, caller, isForced))
				{
				}
			}
		}

		public IEnumerable<GameObject> SpawnAndReturn(SpawnGroup group, Actor caller, bool isForced = false)
		{
			if (!isForced && Time.timeSinceLevelLoad - _lastTime < MinInterval)
			{
				return _empty;
			}
			_lastTime = Time.timeSinceLevelLoad;
			if (PrefabOverride == null || PrefabOverride.Length == 0)
			{
				return group.SpawnAndReturn(UnityEngine.Random.Range(MinCount, MaxCount), caller, isForced: true);
			}
			return group.SpawnAndReturn(UnityEngine.Random.Range(MinCount, MaxCount), PrefabOverride, caller, isForced: true);
		}
	}
}
