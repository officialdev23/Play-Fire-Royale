// DecompilerFi decompiler from Assembly-CSharp.dll class: Hit
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct Hit
	{
		public Vector3 Position;

		public Vector3 Normal;

		public float Damage;

		public GameObject Attacker;

		public GameObject Target;

		public HitType Type;

		public float ReactionDelay;

		public bool IsMelee
		{
			get
			{
				switch (Type)
				{
				case HitType.Fist:
				case HitType.Machete:
				case HitType.PistolMelee:
				case HitType.RifleMelee:
				case HitType.ShotgunMelee:
				case HitType.SniperMelee:
					return true;
				default:
					return false;
				}
			}
		}

		public Hit(Vector3 position, Vector3 normal, float damage, GameObject attacker, GameObject target, HitType type, float reactionDelay)
		{
			Position = position;
			Normal = normal;
			Damage = damage;
			Attacker = attacker;
			Target = target;
			Type = type;
			ReactionDelay = reactionDelay;
		}
	}
}
