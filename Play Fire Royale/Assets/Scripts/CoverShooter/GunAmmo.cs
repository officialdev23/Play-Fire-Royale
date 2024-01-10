// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GunAmmo
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

namespace CoverShooter
{
	[RequireComponent(typeof(Text))]
	[ExecuteInEditMode]
	public class GunAmmo : MonoBehaviour
	{
		[Tooltip("")]
		public CharacterMotor Motor;

		[Tooltip("Determines if the display is hidden when the motor is dead.")]
		public bool HideWhenDead = true;

		[Tooltip("Determines if the display is hidden when there is no gun.")]
		public bool HideWhenNone;

		private Text _text;

		private void Awake()
		{
			_text = GetComponent<Text>();
		}

		private void LateUpdate()
		{
			if (!(Motor == null))
			{
				BaseGun baseGun = Motor.Weapon.Gun;
				if (!Motor.IsEquipped)
				{
					baseGun = null;
				}
				if (baseGun != null)
				{
					_text.text = baseGun.LoadedBulletsLeft.ToString();
				}
				if (Application.isPlaying)
				{
					bool flag = true;
					flag = ((!(Motor == null)) ? ((Motor.IsAlive || !HideWhenDead) && (baseGun != null || !HideWhenNone)) : (!HideWhenNone));
					_text.enabled = flag;
				}
			}
		}
	}
}
