// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GrenadeAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class GrenadeAction : AIAction
	{
		[Tooltip("Associated UI color. Used if there is no preview explosion color on the grenade.")]
		public Color DefaultColor = Color.red;

		[Tooltip("Should the UI color always be set to default instead of looking for one inside the grenade prefab.")]
		public bool AlwaysUseDefaultColor;

		public float Distance = 10f;

		public Grenade Prefab;

		protected CharacterMotor _motor;

		private bool _isAnimating;

		private bool _isMoving;

		public override bool CanTargetGround => true;

		public override bool CanTargetEnemy => true;

		public override float UIRadius => (!(Grenade != null)) ? 0f : Grenade.ExplosionRadius;

		public override Color UIColor
		{
			get
			{
				if (AlwaysUseDefaultColor)
				{
					return DefaultColor;
				}
				Grenade grenade = Grenade;
				if (grenade == null)
				{
					return DefaultColor;
				}
				GameObject explosionPreview = grenade.ExplosionPreview;
				if (explosionPreview == null)
				{
					return DefaultColor;
				}
				Renderer renderer = explosionPreview.GetComponent<Renderer>();
				if (renderer == null)
				{
					renderer = explosionPreview.GetComponentInChildren<Renderer>();
				}
				if (renderer == null)
				{
					return DefaultColor;
				}
				Color color = renderer.material.color;
				color.a = 1f;
				return color;
			}
		}

		public Grenade Grenade
		{
			get
			{
				if (Prefab != null)
				{
					return Prefab;
				}
				CharacterMotor characterMotor = _motor;
				if (characterMotor == null && _actor != null)
				{
					characterMotor = _actor.GetComponent<CharacterMotor>();
				}
				if (characterMotor != null)
				{
					return characterMotor.PotentialGrenade;
				}
				return null;
			}
		}

		public override bool WillMoveForPosition(Vector3 target)
		{
			Grenade grenade = Grenade;
			if (grenade == null)
			{
				return false;
			}
			return Vector3.Distance(_actor.transform.position, target) > Distance + grenade.ExplosionRadius * 0.75f;
		}

		public override bool IsNeededFor(Actor target)
		{
			Grenade grenade = Grenade;
			if (grenade is ToxicGrenade)
			{
				DamageBuff component = target.GetComponent<DamageBuff>();
				if (component != null && component.enabled)
				{
					return component.Multiplier > 1f;
				}
				return true;
			}
			if (grenade is SmokeGrenade)
			{
				VisionBuff component2 = target.GetComponent<VisionBuff>();
				if (component2 != null && component2.enabled)
				{
					return component2.Multiplier > 1f;
				}
				return true;
			}
			return true;
		}

		protected override bool Start()
		{
			_motor = _actor.GetComponent<CharacterMotor>();
			_isMoving = false;
			return true;
		}

		public override bool OnThrow()
		{
			return true;
		}

		public override bool Update()
		{
			if (_isAnimating)
			{
				return true;
			}
			if (Vector3.Distance(_actor.transform.position, _targetPosition) < Distance)
			{
				_actor.SendMessage("ToStopMoving");
				MarkCooldown();
				_motor.InputThrowGrenade(_targetPosition, (!(Prefab != null)) ? null : Prefab.gameObject);
				_isAnimating = true;
			}
			else if (!_isMoving)
			{
				_isMoving = true;
				_actor.SendMessage("ToRunTo", _targetPosition);
			}
			return true;
		}

		public override void Stop()
		{
			if (_isAnimating)
			{
				_isAnimating = false;
			}
		}
	}
}
