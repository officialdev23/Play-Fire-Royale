// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseBrain
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class BaseBrain : AIBase
	{
		private Actor _actor;

		private Vector3 _startingPosition;

		private Actor _threat;

		private Actor _forgottenThreat;

		private Vector3 _lastKnownThreatPosition;

		private float _lastSeenThreatTime;

		private Cover _threatCover;

		private bool _canSeeTheThreat;

		private bool _isActualThreatPosition;

		private bool _hasSeenTheEnemy;

		private bool _hasHeardTheEnemy;

		private int _danger;

		public Actor Actor => _actor;

		public Actor Threat => _threat;

		public Actor ForgottenThreat => _forgottenThreat;

		public float ThreatAge => Time.timeSinceLevelLoad - _lastSeenThreatTime;

		public Vector3 LastKnownThreatPosition => _lastKnownThreatPosition;

		public float LastSeenThreatTime => _lastSeenThreatTime;

		public bool CanSeeTheThreat => _canSeeTheThreat && _threat != null && _threat.IsAlive;

		public Cover ThreatCover => (!(_threat == null)) ? _threatCover : null;

		public bool IsActualThreatPosition => _isActualThreatPosition && _threat != null;

		public bool HasSeenTheEnemy => _hasSeenTheEnemy && _threat != null;

		public bool HasHeardTheEnemy => _hasHeardTheEnemy && _threat != null;

		public Vector3 StartingLocation => _startingPosition;

		public bool IsInDanger => _danger > 0;

		protected virtual void Awake()
		{
			_actor = GetComponent<Actor>();
			_startingPosition = base.transform.position;
		}

		public void OnEnterDanger()
		{
			_danger++;
		}

		public void OnLeaveDanger()
		{
			_danger--;
		}

		public virtual void ToForget()
		{
			_forgottenThreat = Threat;
			RemoveThreat();
		}

		protected void RemoveThreat()
		{
			_threat = null;
			_canSeeTheThreat = false;
			Message("OnNoThreat");
		}

		protected void UnseeThreat()
		{
			_canSeeTheThreat = false;
		}

		protected void SetUnseenThreat(bool isHeard, bool isDirect, Actor threat, Vector3 position, Cover threatCover)
		{
			SetThreat( false, isHeard, isDirect, threat, position, threatCover, Time.timeSinceLevelLoad);
		}

		protected void SetThreat(Actor threat, Vector3 position, Cover threatCover)
		{
			SetThreat( true,false,  true, threat, position, threatCover, Time.timeSinceLevelLoad);
		}

		protected void SetThreat(bool isVisible, bool isHeard, bool isActual, Actor threat, Vector3 position, Cover threatCover, float time)
		{
			Actor threat2 = _threat;
			_forgottenThreat = null;
			_lastSeenThreatTime = time;
			_lastKnownThreatPosition = position;
			_threatCover = threatCover;
			_threat = threat;
			_canSeeTheThreat = isVisible;
			_isActualThreatPosition = isActual;
			if (isHeard)
			{
				_hasHeardTheEnemy = true;
			}
			if (_canSeeTheThreat)
			{
				_hasSeenTheEnemy = true;
			}
			if (_threat != threat2)
			{
				if (_threat != null)
				{
					Message("OnThreat", _threat);
				}
				else
				{
					Message("OnNoThreat");
				}
			}
			if (threat != null)
			{
				Message("OnThreatPosition", _lastKnownThreatPosition);
			}
		}
	}
}
