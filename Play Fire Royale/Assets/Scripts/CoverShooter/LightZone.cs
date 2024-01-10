// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.LightZone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class LightZone : Zone<LightZone>
	{
		[Tooltip("Type of visibility modification. Choices are between a constant distance or a multiplier for the AI view distance.")]
		public VisibilityType Type = VisibilityType.multiplier;

		[Tooltip("Value that's used depending on the visibility type. Can be either a distance or a multiplier for the AI view distance.")]
		public float Value = 1f;

		private void OnTriggerEnter(Collider other)
		{
			other.SendMessage("OnEnterLight", this, SendMessageOptions.DontRequireReceiver);
		}

		private void OnTriggerExit(Collider other)
		{
			other.SendMessage("OnLeaveLight", this, SendMessageOptions.DontRequireReceiver);
		}
	}
}
