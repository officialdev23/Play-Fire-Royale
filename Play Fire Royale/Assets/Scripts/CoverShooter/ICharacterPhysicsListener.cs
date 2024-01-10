// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ICharacterPhysicsListener
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public interface ICharacterPhysicsListener
	{
		void OnLand();

		void OnFootstep(Vector3 position);

		void OnJump();
	}
}
