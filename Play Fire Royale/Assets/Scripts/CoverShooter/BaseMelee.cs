// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseMelee
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public abstract class BaseMelee : MonoBehaviour
	{
		[Tooltip("Animations and related assets to be used with this weapon.")]
		public WeaponType Type = WeaponType.Fist;

		[HideInInspector]
		public CharacterMotor Character;

		public abstract bool Request();

		public abstract void Begin();

		public abstract void End();

		public abstract void BeginScan();

		public abstract void EndScan();

		public abstract void Moment();
	}
}
