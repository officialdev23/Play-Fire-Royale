// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Actor
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class Actor : MonoBehaviour, ICharacterHeightListener, ICharacterCoverListener, ICharacterHealthListener
	{
		[Tooltip("Team number used by the AI.")]
		public int Side;

		[Tooltip("Is the actor aggresive. Value used by the AI. Owning AI usually overwrites the value if present.")]
		public bool IsAggressive = true;

		private bool _isAlive = true;

		private Cover _cover;

		private bool _hasStandingHeight;

		private float _standingHeight;

		private float _height;

		private Collider _collider;

		private CharacterMotor _motor;

		private CharacterHealth _health;

		private Rigidbody _body;

		private BaseBrain _brain;

		private Actor _possibleThreat;

		private List<DarkZone> _darkZones = new List<DarkZone>();

		private List<LightZone> _lightZones = new List<LightZone>();

		private List<GrassZone> _grassZones = new List<GrassZone>();

		private bool _isAlerted;

		public int modo;

		public bool IsAlive => _isAlive;

		public bool IsArmed => _motor != null && _motor.EquippedWeapon.Gun != null;

		public Cover Cover => _cover;

		public Vector3 RelativeStandingTopPosition
		{
			get
			{
				if (_hasStandingHeight)
				{
					return Vector3.up * _standingHeight;
				}
				return Vector3.up * _height;
			}
		}

		public Vector3 RelativeTopPosition => Vector3.up * _height;

		public Vector3 StandingTopPosition
		{
			get
			{
				if (_hasStandingHeight)
				{
					return base.transform.position + Vector3.up * _standingHeight;
				}
				return base.transform.position + Vector3.up * _height;
			}
		}

		public Vector3 TopPosition => base.transform.position + Vector3.up * _height;

		public Collider Collider => _collider;

		public Vector3 HeadDirection
		{
			get
			{
				if (_motor == null)
				{
					return base.transform.forward;
				}
				return _motor.AimForward;
			}
		}

		public bool IsAlerted => _isAlerted;

		public float HealthFraction
		{
			get
			{
				if (_health == null)
				{
					return 1f;
				}
				return _health.Health / _health.MaxHealth;
			}
		}

		public float Health
		{
			get
			{
				if (_health == null)
				{
					return 1E+09f;
				}
				return _health.Health;
			}
		}

		public Actor Threat
		{
			get
			{
				if (_brain != null)
				{
					return _brain.Threat;
				}
				return _possibleThreat;
			}
		}

		public Rigidbody Body => _body;

		public CharacterMotor Motor => _motor;

		public void OnEnterGrass(GrassZone zone)
		{
			if (!_grassZones.Contains(zone))
			{
				_grassZones.Add(zone);
			}
		}

		public void OnLeaveGrass(GrassZone zone)
		{
			if (_grassZones.Contains(zone))
			{
				_grassZones.Remove(zone);
			}
		}

		public void OnEnterLight(LightZone zone)
		{
			if (!_lightZones.Contains(zone))
			{
				_lightZones.Add(zone);
			}
		}

		public void OnLeaveLight(LightZone zone)
		{
			if (_lightZones.Contains(zone))
			{
				_lightZones.Remove(zone);
			}
		}

		public void OnEnterDarkness(DarkZone zone)
		{
			if (!_darkZones.Contains(zone))
			{
				_darkZones.Add(zone);
			}
		}

		public void OnLeaveDarkness(DarkZone zone)
		{
			if (_darkZones.Contains(zone))
			{
				_darkZones.Remove(zone);
			}
		}

		public void OnStandingHeight(float value)
		{
			_hasStandingHeight = true;
			_standingHeight = value;
		}

		public void OnCurrentHeight(float value)
		{
		}

		public void OnDead()
		{
			_isAlive = false;
		}

		public void OnResurrect()
		{
			_isAlive = true;
		}

		public void OnEnterCover(Cover cover)
		{
			if (_cover != null)
			{
				_cover.UnregisterUser(this);
			}
			_cover = cover;
			_cover.RegisterUser(this, base.transform.position);
		}

		public void OnLeaveCover()
		{
			if (_cover != null)
			{
				_cover.UnregisterUser(this);
			}
			_cover = null;
		}

		public void OnAlerted()
		{
			_isAlerted = true;
		}

		public void OnSuccessfulHit(Hit hit)
		{
			Actor component = hit.Target.GetComponent<Actor>();
			if (component != null && component.Side != Side)
			{
				_possibleThreat = component;
			}
		}

		private void Update()
		{
			Vector3 extents = _collider.bounds.extents;
			_height = extents.y * 2f;
			if (_cover != null)
			{
				_cover.RegisterUser(this, base.transform.position);
			}
		}

		private void Awake()
		{
			if (modo == 0)
			{
				Side = UnityEngine.Random.Range(0, 99);
			}
			if (modo == 1)
			{
				Side = 1000;
			}
			_collider = GetComponent<Collider>();
			_motor = GetComponent<CharacterMotor>();
			_health = GetComponent<CharacterHealth>();
			_brain = GetComponent<BaseBrain>();
			_body = GetComponent<Rigidbody>();
			Vector3 extents = _collider.bounds.extents;
			_height = extents.y * 2f;
		}

		private void OnEnable()
		{
			Actors.Register(this);
		}

		private void OnDisable()
		{
			Actors.Unregister(this);
		}

		private void OnDestroy()
		{
			Actors.Unregister(this);
		}

		public float GetViewDistance(float viewDistance, bool isAlerted)
		{
			return Util.GetViewDistance(viewDistance, _darkZones, _lightZones, (!_motor.IsCrouching) ? null : _grassZones, isAlerted);
		}
	}
}
