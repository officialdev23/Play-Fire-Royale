// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GrassZone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class GrassZone : Zone<GrassZone>
	{
		[Tooltip("Type of visibility modification. Choices are between a constant distance or a multiplier for the AI view distance.")]
		public VisibilityType Type;

		[Tooltip("Value that's used when the AI is not alerted. Can be either a distance or a multiplier for the AI view distance depending on the Type.")]
		public float DefaultValue = 1f;

		[Tooltip("Value that's used when the AI knows about the threat. Can be either a distance or a multiplier for the AI view distance depending on the Type.")]
		public float AlertValue = 6f;

		private void OnTriggerEnter(Collider other)
		{
			other.SendMessage("OnEnterGrass", this, SendMessageOptions.DontRequireReceiver);
		}

		private void OnTriggerExit(Collider other)
		{
			other.SendMessage("OnLeaveGrass", this, SendMessageOptions.DontRequireReceiver);
		}
	}
}
