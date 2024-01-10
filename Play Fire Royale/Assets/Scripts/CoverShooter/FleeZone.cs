// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.FleeZone
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BoxCollider))]
	public class FleeZone : Zone<FleeZone>
	{
		[Tooltip("Time in seconds after an actor that reached the flee zone is removed from the game.")]
		public float RemoveDelay = 3f;

		[Tooltip("Are the actors removed from the game by destroying them. If false, they are disabled.")]
		public bool IsRemovingByDestroying = true;

		private List<GameObject> _actors = new List<GameObject>();

		private Dictionary<GameObject, float> _times = new Dictionary<GameObject, float>();

		public void Register(GameObject actor)
		{
			if (!_actors.Contains(actor))
			{
				_actors.Add(actor);
				_times[actor] = 0f;
			}
		}

		public void Unregister(GameObject actor)
		{
			if (_actors.Contains(actor))
			{
				_actors.Remove(actor);
			}
			if (_times.ContainsKey(actor))
			{
				_times.Remove(actor);
			}
		}

		private void Update()
		{
			for (int num = _actors.Count - 1; num >= 0; num--)
			{
				GameObject gameObject = _actors[num];
				Dictionary<GameObject, float> times = _times;
				GameObject key = gameObject;
				(times )[key ] = times[key] + Time.deltaTime;
				if (_times[gameObject] >= RemoveDelay)
				{
					Unregister(gameObject);
					if (IsRemovingByDestroying)
					{
						UnityEngine.Object.Destroy(gameObject.gameObject);
					}
					else
					{
						gameObject.gameObject.SetActive(value: false);
					}
				}
			}
		}
	}
}
