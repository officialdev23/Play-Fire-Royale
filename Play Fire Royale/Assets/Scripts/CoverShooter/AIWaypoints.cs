// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIWaypoints
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIWaypoints : AIBase
	{
		[Tooltip("Points to visit.")]
		[HideInInspector]
		public Waypoint[] Waypoints;

		private bool _isVisiting;

		private bool _isWaiting;

		private int _waypoint;

		private float _waitTime;

		private bool _forceTake = true;

		private bool _foundWaypoints;

		public void ToStartVisitingWaypoints()
		{
			_isVisiting = true;
			_isWaiting = false;
			_waypoint = -1;
			_foundWaypoints = (Waypoints != null && Waypoints.Length > 0);
			if (_foundWaypoints && base.isActiveAndEnabled)
			{
				Message("OnWaypointsFound");
			}
		}

		public void ToStopVisitingWaypoints()
		{
			_isVisiting = false;
		}

		private void Update()
		{
			if (!_isVisiting)
			{
				return;
			}
			if (!_foundWaypoints && Waypoints != null && Waypoints.Length > 0)
			{
				_foundWaypoints = true;
				Message("OnWaypointsFound");
			}
			if (!_foundWaypoints)
			{
				return;
			}
			if (_waypoint < 0 || _waypoint >= Waypoints.Length)
			{
				_isWaiting = false;
			}
			if (_isWaiting)
			{
				_waitTime += Time.deltaTime;
				if (Waypoints[_waypoint].Pause <= _waitTime)
				{
					_waypoint = (_waypoint + 1) % Waypoints.Length;
					_isWaiting = false;
					_forceTake = true;
					_waitTime = 0f;
				}
				return;
			}
			bool flag = false;
			if (_waypoint < 0 || _waypoint >= Waypoints.Length)
			{
				_waypoint = 0;
				float num = Vector3.Distance(base.transform.position, Waypoints[0].Position);
				for (int i = 1; i < Waypoints.Length; i++)
				{
					float num2 = Vector3.Distance(base.transform.position, Waypoints[i].Position);
					if (num2 < num)
					{
						num = num2;
						_waypoint = i;
					}
				}
				flag = true;
			}
			else
			{
				flag = _forceTake;
			}
			_forceTake = false;
			if (Vector3.Distance(base.transform.position, Waypoints[_waypoint].Position) < 0.65f)
			{
				if (Waypoints[_waypoint].Pause > 0.0166666675f || Waypoints.Length == 1)
				{
					_isWaiting = true;
					flag = false;
					Message("ToStopMoving");
				}
				else
				{
					_waypoint = (_waypoint + 1) % Waypoints.Length;
					flag = true;
				}
			}
			if (flag)
			{
				if (Waypoints[_waypoint].Run)
				{
					Message("ToRunTo", Waypoints[_waypoint].Position);
				}
				else
				{
					Message("ToWalkTo", Waypoints[_waypoint].Position);
				}
				Message("ToFaceWalkDirection");
			}
		}
	}
}
