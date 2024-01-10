// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TouchBase
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;
using UnityEngine.EventSystems;

namespace CoverShooter
{
	public abstract class TouchBase : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
	{
		[Tooltip("Mobile controller that will be given the input.")]
		public MobileController Controller;

		[Tooltip("Link to the object that is always shown.")]
		public GameObject Control;

		[Tooltip("Link to the object that is only shown when pressed.")]
		public GameObject Selection;

		[Tooltip("Link to the object that is only shown when pressed and represents the center.")]
		public GameObject Center;

		[Tooltip("Relative size of the screen area at the same side as the touch control.")]
		public float ScreenAreaSize = 0.5f;

		[Tooltip("Distance from the control to it's center circle. Value is relative to the screen height.")]
		public float CenterDistance = 0.1f;

		[Tooltip("Cancel input when the distance from the control to the center is lesser than the value. Value is relative to the screen height.")]
		public float CancelDistance = 0.05f;

		private Vector2 _delta = Vector2.zero;

		private Vector2 _center = Vector2.zero;

		private float _magnitude;

		private bool _isPressed;

		private bool _isActive;

		private Vector2 _pixel;

		private int _touchId;

		private bool _isCancelled;

		private Vector2 _previousMousePosition;

		private bool _previousMouseDown;

		public Vector2 Delta => _delta;

		public float Magnitude => _magnitude;

		public bool IsCancelled => _isCancelled;

		public void OnPointerDown(PointerEventData eventData)
		{
			if (!_isPressed && isInside(eventData.position))
			{
				_isPressed = true;
				_isActive = false;
				_touchId = eventData.pointerId;
				if (eventData.delta.magnitude > 1f)
				{
					processDelta(eventData.position, eventData.delta);
				}
			}
		}

		protected virtual void Update()
		{
			bool isPressed = _isPressed;
			_isPressed = false;
			if (!isPressed)
			{
				Vector3 position = base.transform.position;
				float x = position.x;
				Vector3 position2 = base.transform.position;
				_center = new Vector2(x, position2.y);
			}
			Vector3 mousePosition = CF2Input.mousePosition;
			float x2 = mousePosition.x;
			Vector3 mousePosition2 = CF2Input.mousePosition;
			Vector2 delta = new Vector2(x2, mousePosition2.y) - _previousMousePosition;
			_previousMousePosition = CF2Input.mousePosition;
			bool previousMouseDown = _previousMouseDown;
			_previousMouseDown = CF2Input.GetMouseButton(0);
			int touchId = -10;
			if (Application.isMobilePlatform)
			{
				for (int i = 0; i < CF2Input.touchCount; i++)
				{
					InputRig.Touch touch = CF2Input.GetTouch(i);
					if (process(touch.fingerId, touch.position, touch.deltaPosition, isPressed, touch.phase == TouchPhase.Began))
					{
						touchId = touch.fingerId;
						break;
					}
				}
			}
			else if (CF2Input.GetMouseButton(0))
			{
				Vector3 mousePosition3 = CF2Input.mousePosition;
				float x3 = mousePosition3.x;
				Vector3 mousePosition4 = CF2Input.mousePosition;
				Vector2 pixel = new Vector2(x3, mousePosition4.y);
				if (process(-1, pixel, delta, isPressed, !previousMouseDown))
				{
					touchId = -1;
				}
			}
			_touchId = touchId;
			if (!_isPressed)
			{
				_delta = Vector2.zero;
				_isActive = false;
			}
			if (_isPressed && _isActive)
			{
				if (Control != null)
				{
					Transform transform = Control.transform;
					float x4 = _pixel.x;
					float y = _pixel.y;
					Vector3 position3 = Control.transform.position;
					transform.position = new Vector3(x4, y, position3.z);
				}
				if (Selection != null)
				{
					Transform transform2 = Selection.transform;
					float x5 = _pixel.x;
					float y2 = _pixel.y;
					Vector3 position4 = Selection.transform.position;
					transform2.position = new Vector3(x5, y2, position4.z);
					if (!Selection.activeSelf)
					{
						Selection.SetActive(value: true);
					}
				}
				if (Center != null)
				{
					Transform transform3 = Center.transform;
					float x6 = _center.x;
					float y3 = _center.y;
					Vector3 position5 = Center.transform.position;
					transform3.position = new Vector3(x6, y3, position5.z);
					if (!Center.activeSelf)
					{
						Center.SetActive(value: true);
					}
				}
			}
			else
			{
				if (Control != null)
				{
					Control.transform.position = base.transform.position;
				}
				if (Selection != null && Selection.activeSelf)
				{
					Selection.SetActive(value: false);
				}
				if (Center != null && Center.activeSelf)
				{
					Center.SetActive(value: false);
				}
			}
		}

		private bool process(int id, Vector2 pixel, Vector2 delta, bool wasPressed, bool canBegin)
		{
			bool flag = wasPressed && _touchId == id;
			bool flag2 = (id >= 0) ? EventSystem.current.IsPointerOverGameObject(id) : EventSystem.current.IsPointerOverGameObject();
			bool flag3 = canBegin && !wasPressed && !flag2 && isInside(pixel);
			if (flag || flag3)
			{
				if (!_isActive)
				{
					if (delta.magnitude > 1f)
					{
						processDelta(pixel, delta);
					}
					else
					{
						_isPressed = true;
					}
				}
				else
				{
					processPixel(pixel);
				}
				return true;
			}
			return false;
		}

		private bool isInside(Vector2 pixel)
		{
			Vector3 position = base.transform.position;
			if (position.x < (float)Screen.width * 0.5f)
			{
				if (pixel.x > (float)Screen.width * ScreenAreaSize)
				{
					return false;
				}
			}
			else if (pixel.x < (float)Screen.width - (float)Screen.width * ScreenAreaSize)
			{
				return false;
			}
			return true;
		}

		private void processDelta(Vector2 pixel, Vector2 delta)
		{
			_pixel = pixel;
			_delta = delta.normalized;
			_isPressed = true;
			_isActive = true;
			_isCancelled = false;
			_center = _pixel - _delta * CenterDistance * Screen.height;
		}

		private void processPixel(Vector2 pixel)
		{
			_pixel = pixel;
			_delta = pixel - _center;
			_isPressed = true;
			_isActive = true;
			float magnitude = _delta.magnitude;
			if (magnitude > float.Epsilon)
			{
				_delta.Normalize();
			}
			float num = CenterDistance * (float)Screen.height;
			float num2 = CancelDistance * (float)Screen.height;
			_isCancelled = (magnitude < num2);
			_magnitude = 0f;
			if (magnitude > num)
			{
				_center = _pixel - _delta * num;
				if (!_isCancelled)
				{
					_magnitude = 1f;
				}
			}
			else if (!_isCancelled)
			{
				_magnitude = (magnitude - num2) / (num - num2);
			}
		}
	}
}
