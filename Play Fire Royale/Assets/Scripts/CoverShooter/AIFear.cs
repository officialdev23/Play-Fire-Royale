// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFear
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	[RequireComponent(typeof(CharacterHealth))]
	[RequireComponent(typeof(AIFlee))]
	public class AIFear : AIBase, IAlertListener
	{
		[Tooltip("AI doesn't get afraid of enemies with no equipped weapons.")]
		public bool OnlyScaredOfArmed = true;

		[Tooltip("Chance that an alerted civilian will immediately flee.")]
		[Range(0f, 1f)]
		public float ImmediateScareChance = 0.25f;

		[Range(0f, 1f)]
		[Tooltip("Fraction of health at which the AI runs in fear.")]
		public float MinFightHealth = 0.25f;

		[Tooltip("Should the AI flee after some time passes.")]
		public bool FleeAfterSomeTime;

		[Tooltip("Minimum possible time the AI will fight before fleeing.. Ised only when FleeAfterSomeTime is enabled.")]
		public float MinFleeTime;

		[Tooltip("Maximum possible the AI will fight before fleeing.. Ised only when FleeAfterSomeTime is enabled.")]
		public float MaxFleeTime = 60f;

		[Tooltip("Will the AI flee on hearing gunfire and other hostile alerts.")]
		public bool FleeOnHostileAlerts;

		[Tooltip("Will the AI flee on sight of an active military.")]
		public bool FleeOnSeingMilitary;

		private Actor _actor;

		private CharacterHealth _health;

		private bool _isScared;

		private float _time;

		private bool _isCountingTime;

		private bool _wasThreatArmed;

		private Actor _threat;

		private List<Actor> _visibleFighters = new List<Actor>();

		public void OnAlert(ref GeneratedAlert alert)
		{
			if (alert.IsHostile && FleeOnHostileAlerts && base.isActiveAndEnabled)
			{
				flee();
			}
		}

		public void OnThreat(Actor threat)
		{
			_threat = threat;
			_wasThreatArmed = threat.IsArmed;
			if (base.isActiveAndEnabled && (_wasThreatArmed || !OnlyScaredOfArmed))
			{
				checkScare();
			}
		}

		public void OnNoThreat()
		{
			_threat = null;
		}

		public void OnSeeActor(Actor actor)
		{
			if (actor.Side == _actor.Side && actor.IsAggressive && !_visibleFighters.Contains(actor))
			{
				_visibleFighters.Add(actor);
			}
		}

		public void OnUnseeActor(Actor actor)
		{
			if (actor.Side == _actor.Side && actor.IsAggressive && _visibleFighters.Contains(actor))
			{
				_visibleFighters.Remove(actor);
			}
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
			_health = GetComponent<CharacterHealth>();
		}

		private void Update()
		{
			if (_isScared || !_actor.IsAlive)
			{
				return;
			}
			if (_threat != null && _threat.IsArmed && !_wasThreatArmed)
			{
				_wasThreatArmed = true;
				checkScare();
			}
			if (_health.Health < _health.MaxHealth * MinFightHealth)
			{
				flee();
				return;
			}
			if (FleeAfterSomeTime && _isCountingTime)
			{
				_time -= Time.deltaTime;
				if (_time < float.Epsilon)
				{
					flee();
					return;
				}
			}
			if (!FleeOnSeingMilitary)
			{
				return;
			}
			int num = 0;
			while (true)
			{
				if (num < _visibleFighters.Count)
				{
					if (_visibleFighters[num].IsAlerted)
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			flee();
		}

		private void checkScare()
		{
			if (!_isCountingTime)
			{
				_isCountingTime = true;
				if (MinFleeTime > MaxFleeTime)
				{
					_time = MinFleeTime;
				}
				else
				{
					_time = Random.Range(MinFleeTime, MaxFleeTime);
				}
			}
			if (Random.Range(0f, 1f) <= ImmediateScareChance)
			{
				flee();
			}
		}

		private void flee()
		{
			_isScared = true;
			Message("ToBecomeScared");
		}
	}
}
