// DecompilerFi decompiler from Assembly-CSharp.dll class: CameraStates
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CameraStates
	{
		[Tooltip("Camera state used when the character is unarmed.")]
		public CameraState Default;

		[Tooltip("Camera state to use when the character is standing and aiming.")]
		public CameraState Aim;

		[Tooltip("Camera state to use when the controller is in melee mode.")]
		public CameraState Melee;

		[Tooltip("Camera state to use when the character is crouching.")]
		public CameraState Crouch;

		[Tooltip("Camera state to use when the character is in low cover and not aiming.")]
		public CameraState LowCover;

		[Tooltip("Camera state to use when the character is low cover and grenade mode.")]
		public CameraState LowCoverGrenade;

		[Tooltip("Camera state to use when the character is in tall cover.")]
		public CameraState TallCover;

		[Tooltip("Camera state to use when the character is in tall cover and camera is facing back.")]
		public CameraState TallCoverBack;

		[Tooltip("Camera state to use when the character is ready to fire from a corner of a cover.")]
		public CameraState Corner;

		[Tooltip("Camera state to use when the character is climbing.")]
		public CameraState Climb;

		[Tooltip("Camera state to use when the character is dead.")]
		public CameraState Dead;

		[Tooltip("Camera state to use when the character is using zoom.")]
		public CameraState Zoom;

		[Tooltip("Camera state to use when the character is aiming from a corner in low cover and using zoom.")]
		public CameraState LowCornerZoom;

		[Tooltip("Camera state to use when the character is aiming from a corner in tall cover and using zoom.")]
		public CameraState TallCornerZoom;

		public static CameraStates GetDefault()
		{
			CameraStates result = default(CameraStates);
			result.Default = CameraState.Default();
			result.Aim = CameraState.Aim();
			result.Melee = CameraState.Melee();
			result.Crouch = CameraState.Crouch();
			result.LowCover = CameraState.LowCover();
			result.LowCoverGrenade = CameraState.LowCoverGrenade();
			result.TallCover = CameraState.TallCover();
			result.TallCoverBack = CameraState.TallCoverBack();
			result.Corner = CameraState.Corner();
			result.Climb = CameraState.Climb();
			result.Dead = CameraState.Dead();
			result.Zoom = CameraState.Zoom();
			result.LowCornerZoom = CameraState.LowCornerZoom();
			result.TallCornerZoom = CameraState.TallCornerZoom();
			return result;
		}
	}
}
