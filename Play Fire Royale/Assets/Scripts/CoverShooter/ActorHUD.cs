// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ActorHUD
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class ActorHUD : MonoBehaviour
	{
		[Tooltip("Prototype of a health bar to be shown on any visible actor.")]
		public RectTransform HealthPrototype;

		[Tooltip("Prototype of an arrow to be shown for any active actor that is away.")]
		public RectTransform ArrowPrototype;

		[Tooltip("Player that is used to determine allies and enemies.")]
		public Actor Player;

		[Tooltip("Maximum distance of out of screen objects that have arrows pointing to them.")]
		public float ArrowDistance = 14f;

		public bool ShowOnPlayer = true;

		public bool ShowOnAllies = true;

		public bool ShowOnEnemies = true;

		[Tooltip("Offset of the health bar relative to the screen height.")]
		public Vector2 Offset = new Vector2(0f, 0.1f);

		private Dictionary<GameObject, GameObject> _bars = new Dictionary<GameObject, GameObject>();

		private Dictionary<GameObject, GameObject> _away = new Dictionary<GameObject, GameObject>();

		private List<GameObject> _keep = new List<GameObject>();

		private bool shouldShow(Actor actor)
		{
			if (actor == null)
			{
				return false;
			}
			if (Player == null)
			{
				return true;
			}
			if (actor == Player)
			{
				return ShowOnPlayer;
			}
			if (actor.Side == Player.Side)
			{
				return ShowOnAllies;
			}
			return ShowOnEnemies;
		}

		private void LateUpdate()
		{
			_keep.Clear();
			if (HealthPrototype != null)
			{
				foreach (Character item in Characters.AllAlive)
				{
					Character current = item;
					if (shouldShow(current.Actor))
					{
						Vector3 vector = current.ViewportPoint();
						if (current.IsInSight(2f, -0.01f))
						{
							_keep.Add(current.Object);
							if (!_bars.ContainsKey(current.Object))
							{
								GameObject gameObject = UnityEngine.Object.Instantiate(HealthPrototype.gameObject);
								gameObject.transform.SetParent(base.transform);
								HealthBar healthBar = gameObject.GetComponent<HealthBar>();
								if (healthBar == null)
								{
									healthBar = gameObject.GetComponentInChildren<HealthBar>();
								}
								if (healthBar != null)
								{
									healthBar.Target = current.Object;
								}
								StaminaBar staminaBar = gameObject.GetComponent<StaminaBar>();
								if (staminaBar == null)
								{
									staminaBar = gameObject.GetComponentInChildren<StaminaBar>();
								}
								if (staminaBar != null)
								{
									staminaBar.Target = current.Object;
								}
								BuffBar buffBar = gameObject.GetComponent<BuffBar>();
								if (buffBar == null)
								{
									buffBar = gameObject.GetComponentInChildren<BuffBar>();
								}
								if (buffBar != null)
								{
									buffBar.Target = current.Object;
								}
								_bars.Add(current.Object, gameObject);
							}
							RectTransform component = _bars[current.Object].GetComponent<RectTransform>();
							component.gameObject.SetActive(value: true);
							RectTransform rectTransform = component;
							float x = vector.x * (float)Screen.width + Offset.x * (float)Screen.height;
							float y = vector.y * (float)Screen.height + Offset.y * (float)Screen.height;
							Vector3 position = component.position;
							rectTransform.position = new Vector3(x, y, position.z);
						}
					}
				}
			}
			for (int i = 0; i < _bars.Count - _keep.Count; i++)
			{
				foreach (GameObject key in _bars.Keys)
				{
					if (!_keep.Contains(key))
					{
						UnityEngine.Object.Destroy(_bars[key]);
						_bars.Remove(key);
						break;
					}
				}
			}
			_keep.Clear();
			if (ArrowPrototype != null)
			{
				foreach (Character item2 in Characters.AllAlive)
				{
					Character current3 = item2;
					if (shouldShow(current3.Actor) && !_bars.ContainsKey(current3.Object) && (Player == null || Vector3.Distance(current3.Object.transform.position, Player.transform.position) < ArrowDistance))
					{
						Vector3 vector2 = current3.ViewportPoint();
						if (vector2.z < 0f)
						{
							vector2.x = 1f - vector2.x;
							vector2.y = 1f - vector2.y;
						}
						float z = 0f;
						bool flag = vector2.x < 0.05f;
						bool flag2 = vector2.x > 0.95f;
						bool flag3 = vector2.y < 0.05f;
						bool flag4 = vector2.y > 0.95f;
						if (flag4)
						{
							z = (flag ? 45f : ((!flag2) ? 0f : (-45f)));
						}
						else if (flag3)
						{
							z = (flag ? 135f : ((!flag2) ? 180f : (-135f)));
						}
						else if (flag)
						{
							z = 90f;
						}
						else if (flag2)
						{
							z = -90f;
						}
						if (flag)
						{
							vector2.x = 0.05f;
						}
						if (flag3)
						{
							vector2.y = 0.05f;
						}
						if (flag2)
						{
							vector2.x = 0.95f;
						}
						if (flag4)
						{
							vector2.y = 0.95f;
						}
						_keep.Add(current3.Object);
						if (!_away.ContainsKey(current3.Object))
						{
							GameObject gameObject2 = UnityEngine.Object.Instantiate(ArrowPrototype.gameObject);
							gameObject2.transform.SetParent(base.transform);
							_away.Add(current3.Object, gameObject2);
						}
						RectTransform component2 = _away[current3.Object].GetComponent<RectTransform>();
						component2.gameObject.SetActive(value: true);
						RectTransform rectTransform2 = component2;
						float x2 = vector2.x * (float)Screen.width;
						float y2 = vector2.y * (float)Screen.height;
						Vector3 position2 = component2.position;
						rectTransform2.position = new Vector3(x2, y2, position2.z);
						RectTransform rectTransform3 = component2;
						Vector3 eulerAngles = component2.eulerAngles;
						float x3 = eulerAngles.x;
						Vector3 eulerAngles2 = component2.eulerAngles;
						rectTransform3.eulerAngles = new Vector3(x3, eulerAngles2.y, z);
					}
				}
			}
			for (int j = 0; j < _away.Count - _keep.Count; j++)
			{
				foreach (GameObject key2 in _away.Keys)
				{
					if (!_keep.Contains(key2))
					{
						UnityEngine.Object.Destroy(_away[key2]);
						_away.Remove(key2);
						break;
					}
				}
			}
		}
	}
}
