// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AISearch
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AISearch : AIBase
	{
		public static float CoverOffset = 2f;

		public static float BlockThreshold = 3f;

		public static float BlockCenterThreshold = 6f;

		public static float VerifyDistance = 16f;

		public static float MaxDistance = 10000f;

		[Tooltip("At which height the AI confirms the point as investigated.")]
		public float VerifyHeight = 0.7f;

		[Tooltip("Field of sight to register the search position.")]
		public float FieldOfView = 90f;

		[Tooltip("Distance at which AI turns from running to walking to safely investigate the position.")]
		public float WalkDistance = 8f;

		[Tooltip("Should a line to the intended search point be drawn in the editor.")]
		public bool DebugTarget;

		[Tooltip("Should information about search points be displayed.")]
		public bool DebugPoints;

		private Actor _actor;

		private bool _hasSearchDirection;

		private bool _hasBlockDirection;

		private Vector3 _searchDirection;

		private Vector3 _blockDirection;

		private Vector3 _searchPosition;

		private bool _hasPoint;

		private int _pointIndex;

		private SearchPoint _point;

		private bool _hasPreviousPoint;

		private int _previousPointIndex;

		private bool _isSearching;

		private bool _wasRunning;

		private bool _hasApproached;

		private SearchPointData _points = new SearchPointData();

		private SearchBlock _block;

		private SearchBlockCache _blockCache;

		private List<SearchBlock> _investigatedBlocks = new List<SearchBlock>();

		private List<SearchBlock> _blocks = new List<SearchBlock>();

		private List<InvestigatedPoint> _investigated = new List<InvestigatedPoint>();

		private List<AISearch> _friends = new List<AISearch>();

		private float _timeOfReset;

		private float _checkWait;

		public void ToSearch()
		{
			startSearch();
			_searchPosition = base.transform.position;
			_hasSearchDirection = false;
		}

		public void ToSearchAt(SearchPoint point)
		{
			startSearch();
			setPoint(addPoint(point));
			_hasBlockDirection = _hasSearchDirection;
			_blockDirection = _searchDirection;
		}

		public void ToStopSearch()
		{
			_isSearching = false;
		}

		public void ToMarkPointInspected(Vector3 position)
		{
			if (base.isActiveAndEnabled)
			{
				InvestigatedPoint point = new InvestigatedPoint(position);
				if (!considerPoint(point))
				{
					markInvestigated(point);
				}
				for (int i = 0; i < _friends.Count; i++)
				{
					_friends[i].considerPoint(point);
				}
			}
		}

		public void ToClearSearchHistory()
		{
			_timeOfReset = Time.timeSinceLevelLoad;
			_investigated.Clear();
			_blocks.Clear();
			_block.Clear();
		}

		public void SearchCheck()
		{
			if (base.isActiveAndEnabled)
			{
				Message("SearchResponse");
			}
		}

		public void OnFoundFriend(Actor friend)
		{
			AISearch component = friend.GetComponent<AISearch>();
			if (!(component != null) || _friends.Contains(component))
			{
				return;
			}
			if (base.isActiveAndEnabled)
			{
				for (int i = 0; i < component._investigated.Count; i++)
				{
					considerPoint(component._investigated[i]);
				}
			}
			_friends.Add(component);
		}

		public void OnLostFriend(Actor friend)
		{
			AISearch component = friend.GetComponent<AISearch>();
			if (component != null && _friends.Contains(component))
			{
				_friends.Remove(component);
			}
		}

		public void OnPositionUnreachable(Vector3 point)
		{
			if (_isSearching && _hasPoint && Vector3.Distance(point, _point.ApproachPosition) < 0.5f)
			{
				finishInvestigatingThePoint();
			}
		}

		private void Awake()
		{
			_block = new SearchBlock(_points);
			_blockCache = new SearchBlockCache(_points);
			_actor = GetComponent<Actor>();
		}

		private void OnLevelWasLoaded(int level)
		{
			GlobalSearchCache.Restart();
		}

		private void Update()
		{
			GlobalSearchCache.Update();
			if (!_isSearching)
			{
				return;
			}
			if (_blocks.Count == 0 && !_hasPoint)
			{
				_isSearching = false;
				Message("OnFinishSearch");
			}
			if (DebugPoints)
			{
				foreach (SearchBlock block in _blocks)
				{
					debugBlock(block);
				}
				foreach (SearchBlock investigatedBlock in _investigatedBlocks)
				{
					debugBlock(investigatedBlock);
				}
			}
			if (_block.Empty && !_hasPoint && _blocks.Count > 0)
			{
				int num = -1;
				float num2 = 0f;
				for (int i = 0; i < _blocks.Count; i++)
				{
					Vector3 searchPosition = _searchPosition;
					SearchBlock searchBlock = _blocks[i];
					Vector3 a = searchPosition - searchBlock.Center;
					float magnitude = a.magnitude;
					Vector3 lhs = a / magnitude;
					float num3 = magnitude;
					num3 = ((!_hasBlockDirection) ? (num3 * ((0f - Vector3.Dot(lhs, _actor.HeadDirection)) * 0.5f + 1.5f)) : (num3 * ((0f - Vector3.Dot(lhs, _blockDirection)) * 0.5f + 1.5f)));
					if (num < 0 || num3 < num2)
					{
						num = i;
						num2 = num3;
					}
				}
				_block = _blocks[num];
				_blocks.RemoveAt(num);
				_investigatedBlocks.Add(_block);
				_hasBlockDirection = true;
				_blockDirection = (_block.Center - _searchPosition).normalized;
			}
            int pointIndex; float  _;

            if (!_hasPoint && findBestPoint(_block, out  pointIndex, out  _))
			{
				setPoint(_block.Indices[pointIndex]);
				_block.Investigate(pointIndex);
			}
			if (!_hasPoint)
			{
				return;
			}
			if (!_hasApproached && !shouldApproach(_point))
			{
				_hasApproached = true;
				if (_wasRunning)
				{
					run();
				}
				else
				{
					walk();
				}
			}
			if (_wasRunning && !shouldRunTo(_point.Position))
			{
				walk();
			}
			_checkWait -= Time.deltaTime;
			if (_checkWait <= float.Epsilon)
			{
				glimpse(_block);
				for (int num4 = _blocks.Count - 1; num4 >= 0; num4--)
				{
					glimpse(_blocks[num4]);
					if (_blocks[num4].Empty)
					{
						_investigatedBlocks.Add(_blocks[num4]);
						_blocks.RemoveAt(num4);
					}
				}
				_checkWait = 0.25f;
			}
			if (DebugTarget)
			{
				UnityEngine.Debug.DrawLine(base.transform.position, _point.Position, Color.yellow);
			}
			if (canBeInvestigated(_point))
			{
				finishInvestigatingThePoint();
			}
		}

		private void finishInvestigatingThePoint()
		{
			InvestigatedPoint point = new InvestigatedPoint(_point.Position);
			_hasPoint = false;
			markInvestigated(point);
			for (int i = 0; i < _friends.Count; i++)
			{
				_friends[i].considerPoint(point);
			}
		}

		private int addPoint(SearchPoint point)
		{
			point.CalcVisibility(VerifyDistance, isAlerted: false);
			int num = _points.Add(point);
			if (!_block.Empty && _block.IsClose(point, BlockThreshold, BlockCenterThreshold))
			{
				_block.Add(num);
				return num;
			}
			for (int i = 0; i < _blocks.Count; i++)
			{
				if (_blocks[i].IsClose(point, BlockThreshold, BlockCenterThreshold))
				{
					_blocks[i].Add(num);
					return num;
				}
			}
			SearchBlock item = _blockCache.Take();
			item.Add(num);
			_blocks.Add(item);
			return num;
		}

		private void debugBlock(SearchBlock block)
		{
			Color color = Color.white;
			switch (block.Index % 5)
			{
			case 0:
				color = Color.red;
				break;
			case 1:
				color = Color.green;
				break;
			case 2:
				color = Color.blue;
				break;
			case 3:
				color = Color.yellow;
				break;
			case 4:
				color = Color.cyan;
				break;
			}
			for (int i = 0; i < block.Count; i++)
			{
				debugPoint(block.Get(i),  false, color);
			}
			foreach (int investigatedIndex in block.InvestigatedIndices)
			{
				debugPoint(_points.Points[investigatedIndex], !_hasPoint || investigatedIndex != _pointIndex, color);
			}
		}

		private void debugPoint(SearchPoint point, bool wasInvestigated, Color color)
		{
			UnityEngine.Debug.DrawLine(point.Position, point.Position + Vector3.up * ((!wasInvestigated) ? 0.75f : 0.2f), color);
		}

		private bool findBestPoint(SearchBlock block, out int pointIndex, out float pointValue)
		{
			int num = -1;
			float num2 = 0f;
			int num3 = -1;
			int num4 = -1;
			if (_hasPreviousPoint)
			{
				SearchPoint searchPoint = _points.Points[_previousPointIndex];
				num3 = searchPoint.Left;
				num4 = searchPoint.Right;
			}
			for (int i = 0; i < block.Count; i++)
			{
				int num5 = block.Indices[i];
				SearchPoint searchPoint2 = block.Get(i);
				Vector3 a = _searchPosition - searchPoint2.Position;
				float magnitude = a.magnitude;
				Vector3 lhs = a / magnitude;
				float num6 = magnitude;
				num6 = ((_hasPreviousPoint && (num5 == num3 || num5 == num4)) ? (num6 * -1f) : ((!_hasSearchDirection) ? (num6 * ((0f - Vector3.Dot(lhs, _actor.HeadDirection)) * 0.5f + 1.5f)) : (num6 * ((0f - Vector3.Dot(lhs, _searchDirection)) * 0.5f + 1.5f))));
				if (num < 0 || (num6 > 0f && num6 < num2) || (num6 < 0f && num2 < 0f && num6 > num2) || (num6 < 0f && num2 > 0f))
				{
					num = i;
					num2 = num6;
				}
			}
			pointIndex = num;
			pointValue = num2;
			return pointIndex >= 0;
		}

		private bool canBeInvestigated(SearchPoint point)
		{
			Vector3 vector = point.Position + Vector3.up * VerifyHeight;
			float num = Vector3.Distance(base.transform.position, vector);
			float num2 = VerifyDistance;
			if (point.Visibility < num2)
			{
				num2 = point.Visibility;
			}
			if (num < num2 && (num < 1f || AIUtil.IsInSight(_actor, vector, num2, FieldOfView)))
			{
				return !point.RequiresReaching || num < 1.1f;
			}
			return false;
		}

		private void glimpse(SearchBlock block)
		{
			for (int num = block.Count - 1; num >= 0; num--)
			{
				SearchPoint point = block.Get(num);
				if (canBeInvestigated(point))
				{
					InvestigatedPoint point2 = new InvestigatedPoint(point.Position);
					markInvestigated(point2);
					for (int i = 0; i < _friends.Count; i++)
					{
						_friends[i].considerPoint(point2);
					}
					block.Investigate(num);
				}
			}
		}

		private bool considerPoint(InvestigatedPoint point)
		{
			if (point.Time < _timeOfReset)
			{
				return false;
			}
			if (_hasPoint && areCloseEnough(point, _point))
			{
				_hasPoint = false;
				markInvestigated(point);
				return true;
			}
			if (considerPoint(_block, point))
			{
				return true;
			}
			for (int i = 0; i < _blocks.Count; i++)
			{
				if (considerPoint(_blocks[i], point))
				{
					if (_blocks[i].Empty)
					{
						_investigatedBlocks.Add(_blocks[i]);
						_blocks.RemoveAt(i);
					}
					return true;
				}
			}
			return false;
		}

		private bool considerPoint(SearchBlock block, InvestigatedPoint point)
		{
			for (int i = 0; i < block.Count; i++)
			{
				if (areCloseEnough(point, block.Get(i)))
				{
					block.Investigate(i);
					markInvestigated(point);
					return true;
				}
			}
			return false;
		}

		private void markInvestigated(InvestigatedPoint point)
		{
			_investigated.Add(point);
			Message("OnPointInvestigated", point.Position);
		}

		private bool areCloseEnough(InvestigatedPoint a, SearchPoint b)
		{
			if (Vector3.Distance(a.Position, b.Position) < 0.5f)
			{
				return true;
			}
			return false;
		}

		private bool shouldRunTo(Vector3 position)
		{
			float num = Vector3.Distance(base.transform.position, position);
			if (num > WalkDistance || (num > VerifyDistance && !AIUtil.IsInSight(_actor, position, VerifyDistance, 360f)))
			{
				return true;
			}
			return false;
		}

		private void setPoint(int index)
		{
			_pointIndex = index;
			_point = _points.Points[index];
			_searchPosition = _point.Position;
			_hasPoint = true;
			_hasPreviousPoint = true;
			_previousPointIndex = index;
			_hasSearchDirection = true;
			_searchDirection = (_point.Position - base.transform.position).normalized;
			_hasApproached = !shouldApproach(_point);
			if (shouldRunTo(_point.Position))
			{
				run();
			}
			else
			{
				walk();
			}
		}

		private bool shouldApproach(SearchPoint point)
		{
			return Vector3.Dot(point.Normal, point.Position - base.transform.position) > 0f;
		}

		private void walk()
		{
			_wasRunning = false;
			Message("ToSlowlyAimAt", _point.Position);
			Message("ToTurnAt", _point.Position);
			if (!_hasApproached)
			{
				Message("ToWalkTo", _point.ApproachPosition);
			}
			else
			{
				Message("ToWalkTo", _point.Position);
			}
		}

		private void run()
		{
			_wasRunning = true;
			Message("ToFaceWalkDirection");
			if (!_hasApproached)
			{
				Message("ToRunTo", _point.ApproachPosition);
			}
			else
			{
				Message("ToRunTo", _point.Position);
			}
		}

		private void startSearch()
		{
			_isSearching = true;
			_hasPoint = false;
			_blocks.Clear();
			ToClearSearchHistory();
			for (int i = 0; i < _investigatedBlocks.Count; i++)
			{
				_blockCache.Give(_investigatedBlocks[i]);
			}
			_investigatedBlocks.Clear();
			_hasPreviousPoint = false;
			_points.Clear();
			GlobalSearchCache.GeneratedPoints.WriteTo(_points);
			for (int j = 0; j < GlobalSearchCache.GeneratedBlocks.Count; j++)
			{
				SearchBlock other = _blockCache.Take();
				GlobalSearchCache.GeneratedBlocks[j].WriteTo(ref other);
				_blocks.Add(other);
			}
		}
	}
}
