// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ArmorBuff
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterHealth))]
	public class ArmorBuff : BaseBuff
	{
		[Tooltip("Incoming damage multiplier.")]
		public float Multiplier = 0.5f;

		private CharacterHealth _health;

		private float _applied;

		private float _previous;

		public ArmorBuff()
		{
			Outline = true;
			OutlineColor = Color.blue;
		}

		private void Awake()
		{
			_health = GetComponent<CharacterHealth>();
		}

		protected override void Begin()
		{
			_applied = Multiplier;
			_previous = _health.DamageMultiplier;
			_health.DamageMultiplier *= Multiplier;
		}

		protected override void End()
		{
			if (_applied < -1.401298E-45f || _applied > float.Epsilon)
			{
				_health.DamageMultiplier /= _applied;
			}
			else
			{
				_health.DamageMultiplier = _previous;
			}
		}
	}
}
