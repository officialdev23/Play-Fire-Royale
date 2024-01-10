// DecompilerFi decompiler from Assembly-CSharp.dll class: CameraState
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CameraState
	{
		[Tooltip("Offset from the pivot. The offset is rotated using camera's Horizontal and Vertical values.")]
		public Vector3 Offset;

		[Tooltip("Final rotation of the camera once it is in position.")]
		public Vector3 Orientation;

		[Tooltip("Position around which the camera is rotated.")]
		public Pivot Pivot;

		public Vector3 ConstantPivot;

		[Tooltip("Field of view.")]
		[Range(0f, 360f)]
		public float FOV;

		[Tooltip("Minimum allowed vertical angle in degrees.")]
		public float MinAngle;

		[Tooltip("Maximum allow vertical angle in degrees.")]
		public float MaxAngle;

		public static CameraState Default()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.64f, 0.1f, -2.5f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Aim()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.75f, -0.25f, -1.7f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Melee()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.3f, -0.3f, -4f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Crouch()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.75f, -0.8f, -1f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState LowCover()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 1.75f, 0f);
			result.Offset = new Vector3(0.5f, -0.3f, -1.5f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState LowCoverGrenade()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.23f, -0.23f, -2.2f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState TallCover()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.5f, -0.8f, -1.5f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState TallCoverBack()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 1.6f, 0f);
			result.Offset = new Vector3(0.65f, -0.2f, -1.5f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Corner()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 1.75f, 0f);
			result.Offset = new Vector3(1.2f, -0.2f, -2.4f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Climb()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 2f, 0f);
			result.Offset = new Vector3(0.75f, -0.25f, -1.7f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Dead()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 0f, 0f);
			result.Offset = new Vector3(0f, 1f, -2.5f);
			result.FOV = 60f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState Zoom()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.rightShoulder;
			result.ConstantPivot = new Vector3(0f, 0f, 0f);
			result.Offset = new Vector3(0.5f, 0.15f, -1f);
			result.FOV = 40f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState LowCornerZoom()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 1.35f, 0f);
			result.Offset = new Vector3(1.2f, -0.2f, -1.2f);
			result.FOV = 40f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}

		public static CameraState TallCornerZoom()
		{
			CameraState result = default(CameraState);
			result.Pivot = Pivot.constant;
			result.ConstantPivot = new Vector3(0f, 1.75f, 0f);
			result.Offset = new Vector3(0.8f, -0.2f, -1.2f);
			result.FOV = 40f;
			result.MinAngle = -65f;
			result.MaxAngle = 45f;
			return result;
		}
	}
}
