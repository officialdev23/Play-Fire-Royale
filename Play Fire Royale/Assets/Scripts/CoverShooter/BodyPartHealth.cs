// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BodyPartHealth
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class BodyPartHealth : MonoBehaviour
	{
		[Tooltip("By default target is the first found parent object with CharacterHealth. Setting TargetOverride overrides it.")]
		public CharacterHealth TargetOveride;

		[Tooltip("Multiplies taken damage before applying it to the target CharacterHealth.")]
		public float DamageScale = 1f;

		private CharacterHealth _target;

		private static Dictionary<GameObject, BodyPartHealth> _map = new Dictionary<GameObject, BodyPartHealth>();

		public CharacterHealth Target => (!(TargetOveride == null)) ? TargetOveride : _target;

		public static BodyPartHealth Get(GameObject gameObject)
		{
			if (_map.ContainsKey(gameObject))
			{
				return _map[gameObject];
			}
			return null;
		}

		public static bool Contains(GameObject gameObject)
		{
			return _map.ContainsKey(gameObject);
		}

		private void OnEnable()
		{
			_map[base.gameObject] = this;
		}

		private void OnDisable()
		{
			_map.Remove(base.gameObject);
		}

		private void Awake()
		{
			Transform transform = base.transform;
			while (transform != null && _target == null)
			{
				_target = transform.GetComponent<CharacterHealth>();
				transform = transform.transform.parent;
			}
		}

		public void OnHit(Hit hit)
		{
			CharacterHealth characterHealth = TargetOveride;
			if (characterHealth == null)
			{
				characterHealth = _target;
			}
			if (characterHealth == null)
			{
				Transform transform = base.transform;
				while (transform != null && characterHealth == null)
				{
					characterHealth = transform.GetComponent<CharacterHealth>();
					transform = transform.transform.parent;
				}
				_target = characterHealth;
			}
			if (!(characterHealth == null))
			{
				hit.Damage *= DamageScale;
				characterHealth.SendMessage("OnHit", hit, SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
