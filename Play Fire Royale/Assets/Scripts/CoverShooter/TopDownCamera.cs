// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TopDownCamera
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Camera))]
	public class TopDownCamera : CharacterCamera
	{
		[Tooltip("Target character motor.")]
		public CharacterMotor Target;

		[Tooltip("Camera offset from the target character when there are no enemies around.")]
		public Vector3 CalmOffset = new Vector3(-3f, 9f, -3f);

		[Tooltip("Camera offset from the target character when there are enemies around.")]
		public Vector3 DangerOffset = new Vector3(-4f, 14f, -4f);

		[Tooltip("Speed to move between different offsets.")]
		public float OffsetSpeed = 2f;

		[Tooltip("Time in seconds to go back to the calm offset after there are no more enemies around.")]
		public float ZoomDelay = 0.5f;

		[Tooltip("Field of view.")]
		public float FOV = 45f;

		[Tooltip("Time in seconds it takes for the camera to move between targets.")]
		public float Switch = 0.5f;

		[Tooltip("Min and max enemy distance. Enemies outside of the range are not considered when zooming.")]
		public EnemyDistanceRange EnemyDistances = new EnemyDistanceRange(5f, 10f);

		[Tooltip("Target offsets for each character direction. Targets are relative to the character's position.")]
		public MobileCameraTargetOffsets TargetOffsets = new MobileCameraTargetOffsets(new Vector3(1f, 0f, 1f), new Vector3(-1f, 0f, -1f), new Vector3(-1f, 0f, 1f), new Vector3(1f, 0f, -1f));

		private Vector3 _motorPosition;

		private float _motorPivotIntensity = 1f;

		private bool _wasInCover;

		private Vector3 _lookVector = new Vector3(0f, 0f, 1f);

		private Vector3 _offset;

		private Vector3 _targetOffset;

		private float _offsetScale;

		private float _zoom;

		private Camera _camera;

		private float _targetTravel;

		private CharacterMotor _lastTarget;

		private Vector3 _lastPosition;

		private float[] _zoomMultipliers = new float[4]
		{
			1f,
			1.5f,
			2f,
			2.5f
		};

		private int _zoomIndex;

		private CharacterMotor _cachedTarget;

		private MonoBehaviour _targetComponent;

		private ICharacterController _deferredController;

		private bool _hasAskedForLateUpdate;

		public Vector3 Forward => new Vector3(0f - _offset.x, 0f, 0f - _offset.z).normalized;

		public Vector3 Right => Vector3.Cross(Vector3.up, Forward);

		private Vector3 perfectOffset => Vector3.Lerp(CalmOffset, DangerOffset, _offsetScale);

		private Vector3 perfectTargetOffset => TargetOffsets.Up * Mathf.Clamp01(Vector3.Dot(Forward, _lookVector)) + TargetOffsets.Down * Mathf.Clamp01(Vector3.Dot(-Forward, _lookVector)) + TargetOffsets.Right * Mathf.Clamp01(Vector3.Dot(Right, _lookVector)) + TargetOffsets.Left * Mathf.Clamp01(Vector3.Dot(-Right, _lookVector));

		public T TargetComponent<T>() where T : MonoBehaviour
		{
			if (_cachedTarget != Target || _targetComponent == null || !(_targetComponent is T))
			{
				_cachedTarget = Target;
				_targetComponent = ((!(Target != null)) ? ((T)null) : Target.GetComponent<T>());
			}
			return _targetComponent as T;
		}

		private void Awake()
		{
			_camera = GetComponent<Camera>();
			_lastPosition = base.transform.position;
			_targetTravel = 1f;
			_lastTarget = Target;
		}

		public void SetTargetImmediately(CharacterMotor value)
		{
			_lastPosition = base.transform.position;
			_targetTravel = 1f;
			_lastTarget = value;
			Target = value;
		}

		private void updateZoom()
		{
			float num = 0f;
			if (Input.mousePresent)
			{
				num = 0f - CF2Input.GetAxisRaw("Mouse ScrollWheel");
			}
			else if (Input.touchSupported)
			{
				num = Util.GetPinch();
			}
			if (num < 0f)
			{
				_zoomIndex--;
			}
			else if (num > 0f)
			{
				_zoomIndex++;
			}
			_zoomIndex = Mathf.Clamp(_zoomIndex, 0, _zoomMultipliers.Length - 1);
		}

		private void Update()
		{
			if ((bool)Target)
			{
				_hasAskedForLateUpdate = true;
				Target.AskForLateUpdate(this);
			}
			else
			{
				_hasAskedForLateUpdate = false;
			}
		}

		private void LateUpdate()
		{
			if (!_hasAskedForLateUpdate)
			{
				UpdateForCharacterMotor();
			}
		}

		public override void DeferUpdate(ICharacterController controller)
		{
			_deferredController = controller;
		}

		public override void UpdateForCharacterMotor()
		{
			if (!(Target == null))
			{
				if (Target != _lastTarget)
				{
					_lastPosition = base.transform.position;
					_targetTravel = 0f;
					_lastTarget = Target;
				}
				updateZoom();
				if (Target.IsInCover && !Target.IsAiming)
				{
					_lookVector = Target.Cover.Forward;
				}
				else
				{
					_lookVector = Target.transform.forward;
				}
				Util.Lerp(ref _offset, perfectOffset * _zoomMultipliers[_zoomIndex], OffsetSpeed);
				Util.Lerp(ref _targetOffset, perfectTargetOffset, OffsetSpeed);
				bool flag = false;
				Actor component = Target.GetComponent<Actor>();
				if (component != null)
				{
					foreach (Character item in Characters.AllAlive)
					{
						Character current = item;
						if (current.Actor != null && current.Actor.Side != component.Side)
						{
							float magnitude = (current.Object.transform.position - Target.transform.position).magnitude;
							if (magnitude > EnemyDistances.Min && magnitude < EnemyDistances.Max)
							{
								flag = true;
							}
						}
					}
				}
				if (flag)
				{
					_zoom = 1f;
				}
				else
				{
					_zoom = Mathf.Clamp(_zoom - Time.deltaTime / ZoomDelay, 0f, 1f);
				}
				if (_zoom > float.Epsilon)
				{
					_offsetScale = Mathf.Clamp(_offsetScale + Time.deltaTime * OffsetSpeed, 0f, 1f);
				}
				else
				{
					_offsetScale = Mathf.Clamp(_offsetScale - Time.deltaTime * OffsetSpeed, 0f, 1f);
				}
				Vector3 position = Target.transform.position;
				Util.Lerp(ref _motorPivotIntensity, 1f, 5f);
				if (Target.IsInCover != _wasInCover)
				{
					_motorPivotIntensity = 0f;
				}
				_motorPosition = Vector3.Lerp(_motorPosition, position, _motorPivotIntensity);
				float targetTravel = _targetTravel;
				targetTravel = targetTravel * targetTravel * (3f - 2f * targetTravel);
				_targetTravel = Mathf.Clamp01(_targetTravel + Time.deltaTime / Switch);
				Vector3 b = _motorPosition + _offset;
				Vector3 a = _motorPosition + _targetOffset;
				Vector3 vector = Vector3.Lerp(_lastPosition, b, targetTravel);
				Vector3 vector2 = vector + (a - b);
				base.transform.position = vector;
				base.transform.LookAt(vector2);
				SendMessage("OnFadeTarget", new FadeTarget(Target.gameObject, vector2), SendMessageOptions.DontRequireReceiver);
				_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, FOV, 6f);
				_wasInCover = Target.IsInCover;
				if (_deferredController != null)
				{
					ICharacterController deferredController = _deferredController;
					_deferredController = null;
					deferredController.UpdateAfterCamera();
				}
			}
		}
	}
}
