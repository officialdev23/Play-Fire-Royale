// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.MobileCamera
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Camera))]
	public class MobileCamera : BaseCamera
	{
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

		[Tooltip("Min and max enemy distance. Enemies outside of the range are not considered when zooming.")]
		public EnemyDistanceRange EnemyDistances = new EnemyDistanceRange(5f, 10f);

		[Tooltip("Target offsets for each character direction. Targets are relative to the character's position.")]
		public MobileCameraTargetOffsets TargetOffsets = new MobileCameraTargetOffsets(new Vector3(1f, 0f, 1f), new Vector3(-1f, 0f, -1f), new Vector3(-1f, 0f, 1f), new Vector3(1f, 0f, -1f));

		private Vector3 _motorPosition;

		private float _motorPivotSpeed = 1f;

		private bool _wasInCover;

		private Vector3 _lookVector = new Vector3(0f, 0f, 1f);

		private Vector3 _offset;

		private Vector3 _targetOffset;

		private float _offsetScale;

		private float _zoom;

		private Camera _camera;

		public Vector3 Forward => new Vector3(0f - _offset.x, 0f, 0f - _offset.z).normalized;

		public Vector3 Right => Vector3.Cross(Vector3.up, Forward);

		private Vector3 perfectOffset => Vector3.Lerp(CalmOffset, DangerOffset, _offsetScale);

		private Vector3 perfectTargetOffset => TargetOffsets.Up * Mathf.Clamp01(Vector3.Dot(Forward, _lookVector)) + TargetOffsets.Down * Mathf.Clamp01(Vector3.Dot(-Forward, _lookVector)) + TargetOffsets.Right * Mathf.Clamp01(Vector3.Dot(Right, _lookVector)) + TargetOffsets.Left * Mathf.Clamp01(Vector3.Dot(-Right, _lookVector));

		private void Awake()
		{
			_camera = GetComponent<Camera>();
		}

		protected override void Update()
		{
			base.Update();
			if (!(Target == null))
			{
				MobileController component = Target.GetComponent<MobileController>();
				if (Target.IsInCover && !Target.IsAiming)
				{
					_lookVector = Target.Cover.Forward;
				}
				else
				{
					_lookVector = Target.transform.forward;
				}
				Util.Lerp(ref _offset, perfectOffset, OffsetSpeed);
				Util.Lerp(ref _targetOffset, perfectTargetOffset, OffsetSpeed);
				if (component != null)
				{
					component.Forward = Forward;
				}
				bool flag = false;
				foreach (Character item in Characters.AllAlive)
				{
					Character current = item;
					if (current.Object != Target.gameObject)
					{
						float magnitude = (current.Object.transform.position - Target.transform.position).magnitude;
						if (magnitude > EnemyDistances.Min && magnitude < EnemyDistances.Max)
						{
							flag = true;
						}
					}
				}
				if (flag)
				{
					_zoom = 1f;
				}
				else
				{
					_zoom = Mathf.Clamp01(_zoom - Time.deltaTime / ZoomDelay);
				}
				if (_zoom > float.Epsilon)
				{
					_offsetScale = Mathf.Clamp01(_offsetScale + Time.deltaTime * OffsetSpeed);
				}
				else
				{
					_offsetScale = Mathf.Clamp01(_offsetScale - Time.deltaTime * OffsetSpeed);
				}
				Vector3 position = Target.transform.position;
				Util.Lerp(ref _motorPivotSpeed, 1f, 5f);
				if (Target.IsInCover != _wasInCover)
				{
					_motorPivotSpeed = 0f;
				}
				_motorPosition = Vector3.Lerp(_motorPosition, position, _motorPivotSpeed);
				Vector3 position2 = _motorPosition + _offset;
				Vector3 vector = _motorPosition + _targetOffset;
				base.transform.position = position2;
				base.transform.LookAt(vector);
				SendMessage("OnFadeTarget", new FadeTarget(Target.gameObject, vector), SendMessageOptions.DontRequireReceiver);
				_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, FOV, 6f);
				_wasInCover = Target.IsInCover;
			}
		}
	}
}
