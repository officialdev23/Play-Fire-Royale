// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.StrategyCamera
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Camera))]
	public class StrategyCamera : BaseCamera
	{
		[Tooltip("Should the camera always stay on top of the target.")]
		public bool FollowTarget;

		[Tooltip("Field of view.")]
		public float FOV = 45f;

		[Tooltip("Speed at which the camera moves.")]
		public float Speed = 10f;

		[Tooltip("Speed at which the camera accelerates.")]
		public float Acceleration = 10f;

		[Tooltip("Time in seconds it takes for the camera to transition between targets.")]
		public float TargetTransitionDuration = 1f;

		[Tooltip("Min height the camera can reach.")]
		public float MinHeight = 5f;

		[Tooltip("Max height the camera can reach.")]
		public float MaxHeight = 15f;

		public float HeightSpeed = 1f;

		private CharacterMotor _lastTarget;

		private float _targetTravel;

		private Vector3 _travelStart;

		private Camera _camera;

		private Vector3 _velocity;

		private float _heightOffset;

		private void Awake()
		{
			_camera = GetComponent<Camera>();
		}

		protected override void Update()
		{
			base.Update();
			_camera.fieldOfView = Util.Lerp(_camera.fieldOfView, FOV, 6f);
			Vector3 forward = base.transform.forward;
			forward.y = 0f;
			if (forward.magnitude < float.Epsilon)
			{
				forward = Vector3.forward;
			}
			else
			{
				forward.Normalize();
			}
			Vector3 vector = Vector3.Cross(Vector3.up, forward);
			float Value = Vector3.Dot(_velocity, forward);
			float Value2 = Vector3.Dot(_velocity, vector);
			float num = 0f;
			float num2 = 0f;
			if (_lastTarget != Target)
			{
				_lastTarget = Target;
				_travelStart = base.transform.position;
				_targetTravel = 0f;
			}
			if (FollowTarget && Target != null)
			{
				Vector3 a = Target.transform.position;
				a.y += 2f;
				Vector3 position = base.transform.position;
				float y = position.y;
				Vector3 position2 = Target.transform.position;
				float num3 = y - position2.y;
				a.y += num3;
				a -= forward * num3;
				if (_targetTravel < 1f)
				{
					float targetTravel = _targetTravel;
					targetTravel = targetTravel * targetTravel * (3f - 2f * targetTravel);
					a = _travelStart + (a - _travelStart) * targetTravel;
					_targetTravel = Mathf.Clamp01(_targetTravel + Time.deltaTime / TargetTransitionDuration);
				}
				Vector3 lhs = (a - base.transform.position) / Time.deltaTime;
				Value = Vector3.Dot(lhs, forward);
				Value2 = Vector3.Dot(lhs, vector);
			}
			else
			{
				_targetTravel = 0f;
				_travelStart = base.transform.position;
				if (CF2Input.GetKey(KeyCode.W))
				{
					num = 1f;
				}
				if (CF2Input.GetKey(KeyCode.S))
				{
					num = -1f;
				}
				if (CF2Input.GetKey(KeyCode.D))
				{
					num2 = 1f;
				}
				if (CF2Input.GetKey(KeyCode.A))
				{
					num2 = -1f;
				}
				Util.Lerp(ref Value, num * Speed, Acceleration);
				Util.Lerp(ref Value2, num2 * Speed, Acceleration);
			}
			_velocity = forward * Value + vector * Value2;
			base.transform.position += _velocity * Time.deltaTime;
			Vector3 position3 = base.transform.position;
			float num4 = position3.y + _heightOffset;
			Vector2 mouseScrollDelta = CF2Input.mouseScrollDelta;
			float num5 = Mathf.Clamp(num4 - mouseScrollDelta.y * HeightSpeed * 0.5f, MinHeight, MaxHeight);
			Vector3 position4 = base.transform.position;
			_heightOffset = num5 - position4.y;
			float num6 = Mathf.Clamp(Time.deltaTime * 10f, 0f, Mathf.Abs(_heightOffset)) * Mathf.Sign(_heightOffset);
			base.transform.position += Vector3.up * num6;
			base.transform.position -= forward * num6;
			_heightOffset -= num6;
		}
	}
}
