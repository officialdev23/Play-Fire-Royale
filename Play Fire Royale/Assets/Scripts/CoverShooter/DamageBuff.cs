// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DamageBuff
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class DamageBuff : BaseBuff
	{
		[Tooltip("Damage multiplier for each weapon.")]
		public float Multiplier = 2f;

		private float _multiplier;

		private float _original;

		private CharacterMotor _motor;

		public DamageBuff()
		{
			Outline = true;
			OutlineColor = Color.red;
		}

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		protected override void Begin()
		{
			_multiplier = Multiplier;
			_original = _motor.DamageMultiplier;
			_motor.DamageMultiplier *= Multiplier;
		}

		protected override void End()
		{
			if (_multiplier > float.Epsilon || _multiplier < -1.401298E-45f)
			{
				_motor.DamageMultiplier /= _multiplier;
			}
			else
			{
				_motor.DamageMultiplier = _original;
			}
		}
	}
}
