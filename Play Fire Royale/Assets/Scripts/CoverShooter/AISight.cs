// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AISight
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AISight : AIBase
	{
		[Tooltip("Distance for AI to see objects in the world.")]
		public float Distance = 25f;

		[Tooltip("Distance at which the AI ignores closer obstacles preventing it from seeing something.")]
		public float ObstacleIgnoreDistance = 1f;

		[Tooltip("Field of sight to notice changes in the world.")]
		public float FieldOfView = 160f;

		[Tooltip("Time in seconds between each visibility update.")]
		public float UpdateDelay = 0.1f;

		[Tooltip("Should a debug graphic be drawn to show the field of view.")]
		public bool DebugFOV;

		private Actor _actor;

		private FighterBrain _brain;

		private List<Actor> _visible = new List<Actor>();

		private List<Actor> _oldVisible = new List<Actor>();

		private HashSet<Actor> _visibleHash = new HashSet<Actor>();

		private HashSet<Actor> _oldVisibleHash = new HashSet<Actor>();

		private HashSet<Actor> _seenDeadHash = new HashSet<Actor>();

		private Dictionary<Actor, float> _lastSeenAlive = new Dictionary<Actor, float>();

		private Collider[] _colliders = new Collider[128];

		private float _wait;

		private bool _isAlerted;

		public void OnNoThreat()
		{
			_isAlerted = false;
		}

		public void DoubleCheck(Actor actor)
		{
			if (!CheckVisibility(actor) && _visibleHash.Contains(actor))
			{
				_visible.Remove(actor);
				_visibleHash.Remove(actor);
				Message("OnUnseeActor", actor);
			}
		}

		public bool IsInDarkness(Actor actor)
		{
			float viewDistance = actor.GetViewDistance(Distance, _isAlerted);
			return viewDistance < Distance && Vector3.Distance(actor.TopPosition, _actor.TopPosition) > viewDistance;
		}

		public bool CheckVisibility(Actor actor)
		{
			float viewDistance = actor.GetViewDistance(Distance, _isAlerted);
			return AIUtil.IsInSight(_actor, actor.TopPosition, viewDistance, FieldOfView, ObstacleIgnoreDistance);
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_brain = GetComponent<FighterBrain>();
		}

		private void Update()
		{
			if (!_actor.IsAlive)
			{
				return;
			}
			_wait -= Time.deltaTime;
			if (_wait > float.Epsilon)
			{
				_oldVisible.Clear();
				_oldVisibleHash.Clear();
				for (int i = 0; i < _visible.Count; i++)
				{
					Actor actor = _visible[i];
					if (actor != null)
					{
						_oldVisible.Add(actor);
						_oldVisibleHash.Add(actor);
					}
				}
				for (int j = 0; j < _oldVisible.Count; j++)
				{
					Actor actor2 = _oldVisible[j];
					if (!actor2.IsAlive)
					{
						_visible.Remove(actor2);
						_visibleHash.Remove(actor2);
						if (!_seenDeadHash.Contains(actor2))
						{
							_seenDeadHash.Add(actor2);
							Message("OnSeeDeath", actor2);
						}
					}
				}
				return;
			}
			_wait = Random.Range(UpdateDelay * 0.8f, UpdateDelay * 1.2f);
			_oldVisible.Clear();
			_oldVisibleHash.Clear();
			for (int k = 0; k < _visible.Count; k++)
			{
				Actor actor3 = _visible[k];
				if (actor3 != null)
				{
					_oldVisible.Add(actor3);
					_oldVisibleHash.Add(actor3);
				}
			}
			_visible.Clear();
			_visibleHash.Clear();
			int num = AIUtil.FindActorsIncludingDead(_actor.TopPosition, Distance, _actor);
			for (int l = 0; l < num; l++)
			{
				Actor actor4 = AIUtil.Actors[l];
				if (CheckVisibility(actor4))
				{
					if (actor4.IsAlive)
					{
						_visible.Add(actor4);
						_visibleHash.Add(actor4);
					}
					else if (!_seenDeadHash.Contains(actor4))
					{
						_seenDeadHash.Add(actor4);
						Message("OnSeeDeath", actor4);
					}
					else if (_brain != null && _brain.Threat == actor4)
					{
						_brain.OnSeeDeath(actor4);
					}
				}
			}
			for (int m = 0; m < _oldVisible.Count; m++)
			{
				Actor actor5 = _oldVisible[m];
				if (!_visibleHash.Contains(actor5))
				{
					Message("OnUnseeActor", actor5);
				}
			}
			for (int n = 0; n < _visible.Count; n++)
			{
				Actor actor6 = _visible[n];
				if (!_oldVisibleHash.Contains(actor6))
				{
					Message("OnSeeActor", actor6);
				}
			}
		}
	}
}
