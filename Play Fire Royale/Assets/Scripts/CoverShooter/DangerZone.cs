// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DangerZone
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class DangerZone : Zone<DangerZone>
	{
		private void OnTriggerEnter(Collider other)
		{
			other.SendMessage("OnEnterDanger", this, SendMessageOptions.DontRequireReceiver);
		}

		private void OnTriggerExit(Collider other)
		{
			other.SendMessage("OnLeaveDanger", this, SendMessageOptions.DontRequireReceiver);
		}
	}
}
