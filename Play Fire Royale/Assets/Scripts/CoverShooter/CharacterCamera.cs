// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterCamera
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public abstract class CharacterCamera : MonoBehaviour
	{
		public abstract void UpdateForCharacterMotor();

		public abstract void DeferUpdate(ICharacterController controller);
	}
}
