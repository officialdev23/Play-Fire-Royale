// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFollow
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIFollow : AIBase
	{
		[Tooltip("Distance to maintain against a threat.")]
		public float AvoidDistance = 10f;

		[Tooltip("AI walks closer if it is further than this distance.")]
		public float FollowDistance = 20f;

		[Tooltip("Is the AI using covers to follow a threat.")]
		public bool UseCovers = true;

		[Tooltip("Chance that the AI will leave covers to follow the threat.")]
		[Range(0f, 1f)]
		public float FollowFromCoverChance = 0.6f;

		[Tooltip("Is the AI running towards covers.")]
		public bool RunToCovers;

		[Tooltip("Should the AI continuously turn back and forward between walk direction and the threat.")]
		public bool UsePeeks;

		[Tooltip("Duration of a peek in seconds.")]
		public float PeekDuration = 1.5f;

		[Tooltip("How long to wait between peeks.")]
		public float PeekDelay = 3f;

		private Actor _actor;

		private bool _isFollowing;

		private Vector3 _threatPosition;

		private bool _hasFoundCover;

		private bool _isUsingCover;

		private bool _isFollowingFromCovers;

		private float _peek;

		private bool _isKeepingCloseTo;

		private KeepCloseTo _keepCloseTo;

		private bool needsNewPosition
		{
			get
			{
				Vector3 vector = _threatPosition - base.transform.position;
				vector.y = 0f;
				return vector.magnitude < AvoidDistance || vector.magnitude > FollowDistance;
			}
		}

		public void OnFoundCover()
		{
			_hasFoundCover = true;
		}

		public void OnInvalidCover()
		{
			if (_isUsingCover && _isFollowing && base.isActiveAndEnabled)
			{
				findNewCover();
			}
		}

		public void OnThreatPosition(Vector3 position)
		{
			_threatPosition = position;
			if (!base.isActiveAndEnabled || !_isFollowing || (!_isFollowingFromCovers && !(_actor.Cover == null)))
			{
				return;
			}
			if (needsNewPosition)
			{
				if (!_isUsingCover)
				{
					if (UseCovers)
					{
						findNewCover();
					}
					else
					{
						findNewWalkPosition();
					}
				}
			}
			else if (UseCovers && !_isUsingCover)
			{
				findNewCover();
			}
		}

		public void ToStartFollowing(Vector3 position)
		{
			_isFollowing = true;
			_threatPosition = position;
			_isFollowingFromCovers = (Random.Range(0f, 1f) <= FollowFromCoverChance);
			if (base.isActiveAndEnabled)
			{
				if (UseCovers)
				{
					findNewCover();
				}
				else
				{
					findNewWalkPosition();
				}
			}
		}

		public void ToStopFollowing()
		{
			if (_isFollowing && base.isActiveAndEnabled)
			{
				Message("ToStopMoving");
			}
			_isFollowing = false;
		}

		public void ToKeepCloseTo(KeepCloseTo value)
		{
			_isKeepingCloseTo = true;
			_keepCloseTo = value;
		}

		private void Awake()
		{
			_actor = GetComponent<Actor>();
		}

		private void Update()
		{
			if (_isFollowing)
			{
				if (!_isUsingCover || _actor.Cover != null || _peek > PeekDuration || !UsePeeks)
				{
					Message("ToTurnAt", _threatPosition);
					Message("ToAimAt", _threatPosition);
				}
				else
				{
					Message("ToFaceWalkDirection");
				}
				_peek += Time.deltaTime;
				_peek %= PeekDuration + PeekDelay;
			}
		}

		private void findNewCover()
		{
			_hasFoundCover = false;
			_isUsingCover = false;
			if (RunToCovers)
			{
				Message("ToRunToCovers");
			}
			else
			{
				Message("ToWalkToCovers");
			}
			Message("ToTakeCoverAgainst", _threatPosition);
			if (_hasFoundCover)
			{
				_isUsingCover = true;
			}
			else
			{
				findNewWalkPosition();
			}
		}

		private void findNewWalkPosition()
		{
			Vector3 vector = _threatPosition - base.transform.position;
			vector.y = 0f;
			if (vector.magnitude < AvoidDistance)
			{
				walkTo(_threatPosition - vector.normalized * FollowDistance);
			}
			else if (vector.magnitude > FollowDistance)
			{
				walkTo(_threatPosition - vector.normalized * AvoidDistance);
			}
		}

		private void walkTo(Vector3 position)
		{
			if (_isKeepingCloseTo && Vector3.Distance(position, _keepCloseTo.Position) > _keepCloseTo.Distance)
			{
				position = _keepCloseTo.Position + (position - _keepCloseTo.Position).normalized * _keepCloseTo.Distance;
			}
			Message("ToWalkTo", position);
		}
	}
}
