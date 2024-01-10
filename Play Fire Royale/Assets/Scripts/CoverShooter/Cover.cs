// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Cover
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BoxCollider))]
	public class Cover : MonoBehaviour
	{
		public const float TallThreshold = 1.2f;

		[Tooltip("Can the character use the left corner of the cover.")]
		public bool OpenLeft = true;

		[Tooltip("Can the character use the rgiht corner of the cover.")]
		public bool OpenRight = true;

		[Tooltip("Maximum allowed distance to adjacent covers.")]
		public float AdjacentDistance = 1f;

		private Vector3 _size;

		private Cover _leftAdjacent;

		private Cover _rightAdjacent;

		private BoxCollider _collider;

		private bool _hasLeftCorner;

		private bool _hasRightCorner;

		private bool _hasOrientationAndSize;

		private Vector3 _leftCorner;

		private Vector3 _rightCorner;

		private Quaternion _orientation;

		private Quaternion _negativeOrientation;

		private Dictionary<Actor, CoverUser> _userMap = new Dictionary<Actor, CoverUser>();

		public IEnumerable<CoverUser> Users => _userMap.Values;

		public float Top
		{
			get
			{
				if (!Application.isPlaying || _collider == null)
				{
					Vector3 max = GetComponent<BoxCollider>().bounds.max;
					return max.y;
				}
				Vector3 max2 = _collider.bounds.max;
				return max2.y;
			}
		}

		public float Bottom
		{
			get
			{
				if (!Application.isPlaying || _collider == null)
				{
					Vector3 min = GetComponent<BoxCollider>().bounds.min;
					return min.y;
				}
				Vector3 min2 = _collider.bounds.min;
				return min2.y;
			}
		}

		public Vector3 Forward => base.transform.forward;

		public Vector3 Right => base.transform.right;

		public Vector3 Left => -base.transform.right;

		public float Angle
		{
			get
			{
				Vector3 eulerAngles = base.transform.eulerAngles;
				return eulerAngles.y;
			}
		}

		public float Width
		{
			get
			{
				checkOrientationAndSize();
				return _size.x;
			}
		}

		public float Height
		{
			get
			{
				checkOrientationAndSize();
				return _size.y;
			}
		}

		public float Depth
		{
			get
			{
				checkOrientationAndSize();
				return _size.z;
			}
		}

		public Cover LeftAdjacent => _leftAdjacent;

		public Cover RightAdjacent => _rightAdjacent;

		public bool IsTall => Top - Bottom > 1.2f;

		public bool IsLeftAdjacent(Cover cover, Vector3 position)
		{
			return isAdjacent(cover, position, -120f, 60f);
		}

		public bool IsRightAdjacent(Cover cover, Vector3 position)
		{
			return isAdjacent(cover, position, -60f, 120f);
		}

		private void Start()
		{
			if (_collider == null)
			{
				_collider = GetComponent<BoxCollider>();
			}
			if (_leftAdjacent == null)
			{
				_leftAdjacent = findAdjacentTo(LeftCorner(Bottom), -120f, 60f, useLeftCorner: false);
				if (_leftAdjacent != null)
				{
					_leftAdjacent._rightAdjacent = this;
				}
			}
			if (_rightAdjacent == null)
			{
				_rightAdjacent = findAdjacentTo(RightCorner(Bottom), -60f, 120f, useLeftCorner: true);
				if (_rightAdjacent != null)
				{
					_rightAdjacent._leftAdjacent = this;
				}
			}
		}

		private bool isAdjacent(Cover other, Vector3 position, float minAngle, float maxAngle)
		{
			Vector3 b = other.ClosestPointTo(position, 0f, 0f);
			float num = Vector3.Distance(position, b);
			if (num > AdjacentDistance)
			{
				return false;
			}
			float angle = other.Angle;
			float num2 = Mathf.DeltaAngle(Angle, angle);
			return num2 >= minAngle && num2 <= maxAngle;
		}

		private Cover findAdjacentTo(Vector3 point, float minAngle, float maxAngle, bool useLeftCorner)
		{
			float num = 0f;
			Cover cover = null;
			Cover[] array = UnityEngine.Object.FindObjectsOfType<Cover>();
			foreach (Cover cover2 in array)
			{
				if (!(cover2 != this))
				{
					continue;
				}
				Vector3 b = (!useLeftCorner) ? cover2.RightCorner(point.y) : cover2.LeftCorner(point.y);
				float num2 = Vector3.Distance(point, b);
				if (!(num2 > AdjacentDistance))
				{
					float angle = cover2.Angle;
					float num3 = Mathf.DeltaAngle(Angle, angle);
					if (num3 >= minAngle && num3 <= maxAngle && (cover == null || num2 < num))
					{
						cover = cover2;
						num = num2;
					}
				}
			}
			return cover;
		}

		public CoverClimb GetClimbAt(Vector3 position, float radius, float maxClimbHeight, float maxVaultHeight, float maxVaultDistance)
		{
			Vector3 b = LeftCorner(position.y);
			Vector3 vector = RightCorner(position.y);
			float num = Vector3.Dot(Right, position - b) / Width;
			if ((num < 0f && _leftAdjacent == null) || (num > 1f && _rightAdjacent == null))
			{
				return CoverClimb.No;
			}
			float num2 = radius / Width;
			if ((Height > maxClimbHeight && Height > maxVaultHeight) || checkForward(num - num2) || checkForward(num) || checkForward(num + num2) || checkUp(num - num2, -0.2f, -0.2f) || checkUp(num, -0.2f, -0.2f) || checkUp(num + num2, -0.2f, -0.2f) || checkUp(num - num2, 0.1f, 0.3f) || checkUp(num, 0.1f, 0.3f) || checkUp(num + num2, 0.1f, 0.3f))
			{
				return CoverClimb.No;
			}
			if (Height < maxVaultHeight && !checkDown(num - num2, maxVaultDistance) && !checkDown(num, maxVaultDistance) && !checkDown(num + num2, maxVaultDistance))
			{
				return CoverClimb.Vault;
			}
			return CoverClimb.Climb;
		}

		public void RegisterUser(Actor actor, Vector3 position)
		{
			CoverUser value = default(CoverUser);
			value.Actor = actor;
			value.Position = position;
			_userMap[actor] = value;
		}

		public void UnregisterUser(Actor actor)
		{
			if (_userMap.ContainsKey(actor))
			{
				_userMap.Remove(actor);
			}
		}

		public bool CheckTall(float observer)
		{
			return Top - observer > 1.2f;
		}

		public bool IsInFront(Vector3 observer, bool isOld)
		{
			Vector3 a = ClosestPointTo(observer, 0f, 0f);
			Vector3 normalized = (a - observer).normalized;
			float num = Vector3.Dot(normalized, Forward);
			if (isOld)
			{
				return num >= 0.85f;
			}
			return num >= 0.95f;
		}

		public Vector3 LeftCorner(float y, float offset = 0f)
		{
			Vector3 vector = _leftCorner;
			if (!_hasLeftCorner)
			{
				vector = (_leftCorner = ClosestPointTo(base.transform.position + Left * 999f, 0f, 0f));
				_hasLeftCorner = Application.isPlaying;
			}
			vector += Left * offset;
			vector.y = y;
			return vector;
		}

		public Vector3 RightCorner(float y, float offset = 0f)
		{
			Vector3 vector = _rightCorner;
			if (!_hasRightCorner)
			{
				vector = (_rightCorner = ClosestPointTo(base.transform.position + Right * 999f, 0f, 0f));
				_hasRightCorner = Application.isPlaying;
			}
			vector += Right * offset;
			vector.y = y;
			return vector;
		}

		public bool IsByLeftCorner(Vector3 position, float distance)
		{
			return Vector3.Distance(LeftCorner(position.y), position) <= distance;
		}

		public bool IsByRightCorner(Vector3 position, float distance)
		{
			return Vector3.Distance(RightCorner(position.y), position) <= distance;
		}

		public int ClosestCornerToSegment(Vector3 a, Vector3 b, float radius, out Vector3 position)
		{
			Vector3 vector = LeftCorner(0f, 0f - radius);
			Vector3 vector2 = RightCorner(0f, 0f - radius);
			float num = Util.DistanceToSegment(vector, a, b);
			float num2 = Util.DistanceToSegment(vector2, a, b);
			if (num < num2)
			{
				position = vector;
				return -1;
			}
			position = vector2;
			return 1;
		}

		public int ClosestCornerTo(Vector3 point, float radius, out Vector3 position)
		{
			Vector3 vector = LeftCorner(0f, 0f - radius);
			Vector3 vector2 = RightCorner(0f, 0f - radius);
			float num = Vector3.Distance(vector, point);
			float num2 = Vector3.Distance(vector2, point);
			if (num < num2)
			{
				position = vector;
				return -1;
			}
			position = vector2;
			return 1;
		}

		private void checkOrientationAndSize()
		{
			if (Application.isPlaying && _collider == null)
			{
				_collider = GetComponent<BoxCollider>();
			}
			BoxCollider boxCollider = (!Application.isPlaying) ? GetComponent<BoxCollider>() : _collider;
			if (!_hasOrientationAndSize)
			{
				Vector3 eulerAngles = base.transform.eulerAngles;
				_orientation = Quaternion.Euler(0f, 0f - eulerAngles.y, 0f);
				Vector3 eulerAngles2 = base.transform.eulerAngles;
				_negativeOrientation = Quaternion.Euler(0f, eulerAngles2.y, 0f);
				_size.x = 1f / base.transform.InverseTransformVector(_negativeOrientation * Vector3.right).magnitude;
				 Vector3 size =  _size;
				Vector3 size2 = boxCollider.bounds.size;
				size.y = size2.y;
				_size.z = 1f / base.transform.InverseTransformVector(_negativeOrientation * Vector3.forward).magnitude;
				_hasOrientationAndSize = Application.isPlaying;
			}
		}

		public Vector3 ClosestPointTo(Vector3 point, float sideRadius, float frontRadius)
		{
			checkOrientationAndSize();
			float num = _size.x * 0.5f;
			float num2 = _size.z * 0.5f;
			Vector3 point2 = _orientation * (point - base.transform.position);
			Vector3 vector = new Vector3(0f - num, point2.y, 0f - num2);
			Vector3 a = new Vector3(num, point2.y, 0f - num2);
			Vector3 normalized = (a - vector).normalized;
			vector += normalized * sideRadius;
			a -= normalized * sideRadius;
			point2 = Util.FindClosestToPath(vector, a, point2);
			return _negativeOrientation * point2 + base.transform.position - Forward * frontRadius;
		}

		public Vector3 ClosestPointTo(Vector3 point, float leftSideRadius, float rightSideRadius, float frontRadius)
		{
			checkOrientationAndSize();
			float num = _size.x * 0.5f;
			float num2 = _size.z * 0.5f;
			Vector3 point2 = _orientation * (point - base.transform.position);
			Vector3 vector = new Vector3(0f - num, point2.y, 0f - num2);
			Vector3 a = new Vector3(num, point2.y, 0f - num2);
			Vector3 normalized = (a - vector).normalized;
			vector += normalized * leftSideRadius;
			a -= normalized * rightSideRadius;
			point2 = Util.FindClosestToPath(vector, a, point2);
			return _negativeOrientation * point2 + base.transform.position - Forward * frontRadius;
		}

		public bool IsFrontField(float angle, float field)
		{
			return IsFront(angle, (180f - field) / 2f);
		}

		public bool IsFront(float angle, float margin = 0f)
		{
			float num = Mathf.DeltaAngle(angle, Angle);
			return num >= -90f + margin && num <= 90f - margin;
		}

		public bool IsBack(float angle, float margin = 0f)
		{
			float num = Mathf.DeltaAngle(angle, Angle);
			return num <= -90f - margin || num >= 90f + margin;
		}

		public bool IsLeft(float angle, float margin = 0f)
		{
			float num = Mathf.DeltaAngle(angle, Angle);
			return num >= margin && num <= 180f - margin;
		}

		public bool IsLeftField(float angle, float field)
		{
			return IsLeft(angle, (180f - field) / 2f);
		}

		public bool IsRight(float angle, float margin = 0f)
		{
			float num = Mathf.DeltaAngle(angle, Angle);
			return num >= -180f + margin && num <= 0f - margin;
		}

		public bool IsRightField(float angle, float field)
		{
			return IsRight(angle, (180f - field) / 2f);
		}

		private bool checkForward(float x)
		{
			return checkRay(LeftCorner(Top + 0.1f, (0f - Width) * x), Forward, 0.5f);
		}

		private bool checkDown(float x, float distance)
		{
			return checkRay(LeftCorner(Top + 0.1f, (0f - Width) * x) + Forward * distance, Vector3.down, 0.5f);
		}

		private bool checkUp(float x, float yoffset, float distance)
		{
			return checkRay(LeftCorner(Top + yoffset, (0f - Width) * x) + Forward * distance, Vector3.up, 2f);
		}

		private bool checkRay(Vector3 position, Vector3 direction, float distance)
		{
			return checkLine(position, position + direction * distance);
		}

		private bool checkLine(Vector3 position, Vector3 end)
		{
			if (Physics.Raycast(position, (end - position).normalized, Vector3.Distance(end, position), Layers.Geometry, QueryTriggerInteraction.Ignore))
			{
				return true;
			}
			return false;
		}
	}
}
