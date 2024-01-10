// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Tool
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public abstract class Tool : MonoBehaviour
	{
		[HideInInspector]
		public bool HasAiming;

		[HideInInspector]
		public bool IsContinuous;

		[HideInInspector]
		public bool HasAlternateAiming;

		[HideInInspector]
		public bool IsAlternateContinuous;

		public virtual void ContinuousUse(CharacterMotor character, bool isAlternate)
		{
		}

		public virtual void Use(CharacterMotor character, bool isAlternate)
		{
		}
	}
}
