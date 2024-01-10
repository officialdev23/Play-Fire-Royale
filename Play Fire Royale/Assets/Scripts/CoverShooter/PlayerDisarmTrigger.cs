// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.PlayerDisarmTrigger
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class PlayerDisarmTrigger : MonoBehaviour
	{
		private void OnTriggerEnter(Collider other)
		{
			CharacterMotor component = other.GetComponent<CharacterMotor>();
			if (!(component == null))
			{
				component.IsEquipped = false;
			}
		}
	}
}
