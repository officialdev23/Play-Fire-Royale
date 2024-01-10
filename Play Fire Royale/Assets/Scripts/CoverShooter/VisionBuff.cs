// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.VisionBuff
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(AISight))]
	public class VisionBuff : BaseBuff
	{
		[Tooltip("View distance multiplier.")]
		public float Multiplier = 2f;

		private AISight _sight;

		private float _applied;

		private float _previous;

		private void Awake()
		{
			_sight = GetComponent<AISight>();
		}

		protected override void Begin()
		{
			_applied = Multiplier;
			_previous = _sight.Distance;
			_sight.Distance *= Multiplier;
		}

		protected override void End()
		{
			if (_applied < -1.401298E-45f || _applied > float.Epsilon)
			{
				_sight.Distance /= _applied;
			}
			else
			{
				_sight.Distance = _previous;
			}
		}
	}
}
