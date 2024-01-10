// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CoverSearch
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class CoverSearch
	{
		private Vector3 _position;

		private Vector3 _head;

		private CoverState _current;

		private float _capsuleRadius;

		private float _takeRadius;

		private float _crouchRadius;

		private float _climbRadius;

		private CoverSettings _settings;

		private Cover[] _covers = new Cover[16];

		private int _coverCount;

		private static Dictionary<GameObject, Cover> _coverMap = new Dictionary<GameObject, Cover>();

		public static Cover GetCover(GameObject gameObject)
		{
			if (!_coverMap.ContainsKey(gameObject))
			{
				_coverMap[gameObject] = gameObject.GetComponent<Cover>();
			}
			return _coverMap[gameObject];
		}

		public void Clear()
		{
			_coverCount = 0;
		}

		public void Update(CoverState current, Vector3 position, Vector3 head, float takeRadius, float crouchRadius, float climbRadius, float capsuleRadius, CoverSettings settings)
		{
			_current = current;
			_position = position;
			_head = head;
			_capsuleRadius = capsuleRadius;
			_settings = settings;
			_takeRadius = takeRadius;
			_crouchRadius = crouchRadius;
			_climbRadius = climbRadius;
			float num = (!(takeRadius > crouchRadius)) ? crouchRadius : takeRadius;
			num = ((!(num > climbRadius)) ? climbRadius : num);
			int num2 = Physics.OverlapSphereNonAlloc(position, num, Util.Colliders, Layers.Cover);
			_coverCount = 0;
			for (int i = 0; i < num2; i++)
			{
				Cover cover = GetCover(Util.Colliders[i].gameObject);
				if (cover != null)
				{
					_covers[_coverCount++] = cover;
					if (_coverCount == _covers.Length)
					{
						break;
					}
				}
			}
		}

		public Cover FindClosest()
		{
			Cover cover = null;
			for (int i = 0; i < _coverCount; i++)
			{
				Cover cover2 = _covers[i];
				if (cover2 != null && cover2 == _current.Main && doesCoverFit(cover2, checkDistance: true))
				{
					cover = cover2;
				}
			}
			_head.y = _position.y;
			for (int j = 0; j < _coverCount; j++)
			{
				Cover cover3 = _covers[j];
				if (!(cover3 != null) || !(cover3 != _current.Main) || !doesCoverFit(cover3, checkDistance: true))
				{
					continue;
				}
				if (cover == null)
				{
					cover = cover3;
					continue;
				}
				float num = Vector3.Distance(_head, cover3.ClosestPointTo(_head, 0f, 0f));
				if (num < 0.3f)
				{
					cover = cover3;
				}
			}
			return cover;
		}

		public bool IsCloserThan(Cover first, Cover second, float threshold)
		{
			float num = Vector3.Distance(_head, first.ClosestPointTo(_head, 0f, 0f));
			float num2 = Vector3.Distance(_head, second.ClosestPointTo(_head, 0f, 0f));
			return num + threshold < num2;
		}

		public bool FindClosestCrouchPosition(ref Vector3 position)
		{
			Cover x = null;
			_head.y = _position.y;
			for (int i = 0; i < _coverCount; i++)
			{
				Cover cover = _covers[i];
				if (!(cover != null) || cover.IsTall || !doesCoverFit(cover, checkDistance: false))
				{
					continue;
				}
				if (x == null)
				{
					x = cover;
					position = cover.ClosestPointTo(_head, 0f, 0f);
					continue;
				}
				Vector3 vector = cover.ClosestPointTo(_head, 0f, 0f);
				float num = Vector3.Distance(_head, vector);
				if (num < _crouchRadius)
				{
					x = cover;
					position = vector;
				}
			}
			return x != null;
		}

		public Cover FindClimbCoverInDirection(Vector3 direction)
		{
			Cover cover = null;
			float num = 0f;
			float num2 = 0f;
			for (int i = 0; i < _coverCount; i++)
			{
				Cover cover2 = _covers[i];
				Vector3 a = cover2.ClosestPointTo(_position, 0f, 0f);
				float num3 = Vector3.Dot(cover2.Forward, direction);
				if (!(num3 < 0.5f))
				{
					Vector3 a2 = a - _position;
					float num4 = a2.magnitude;
					if (num4 <= float.Epsilon)
					{
						num4 = float.Epsilon;
					}
					num3 = Vector3.Dot(direction, a2 / num4);
					if (!(num3 < float.Epsilon) && (cover == null || (num3 > num && num4 < num2)))
					{
						cover = cover2;
						num = num3;
						num2 = num4;
					}
				}
			}
			return cover;
		}

		private bool doesCoverFit(Cover cover, bool checkDistance)
		{
			if (cover == null || cover.Top < _position.y + 0.5f)
			{
				return false;
			}
			Vector3 vector = _position + cover.Forward * _capsuleRadius;
			float num = Vector3.Distance(vector, cover.ClosestPointTo(vector, 0f, 0f));
			float d = (!(cover == _current.Main)) ? ((!cover.CheckTall(_position.y)) ? _settings.LowSideEnterRadius : _settings.TallSideEnterRadius) : ((!cover.CheckTall(_position.y)) ? _settings.LowSideLeaveRadius : _settings.TallSideLeaveRadius);
			bool flag = cover.IsInFront(_position, cover == _current.Main) && (cover.IsInFront(_position + cover.Right * d, cover == _current.Main) || cover.RightAdjacent != null) && (cover.IsInFront(_position + cover.Left * d, cover == _current.Main) || cover.LeftAdjacent != null);
			if (checkDistance)
			{
				if (flag && num <= _settings.LeaveDistance && cover == _current.Main)
				{
					return true;
				}
				if (flag && num <= _settings.EnterDistance && cover != _current.Main)
				{
					return true;
				}
				return false;
			}
			return flag;
		}
	}
}
