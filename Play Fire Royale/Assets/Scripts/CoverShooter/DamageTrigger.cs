// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.DamageTrigger
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Collider))]
	public class DamageTrigger : MonoBehaviour
	{
		[Tooltip("Type of damage dealt. Relative means relative to MaxHealth. Constant is always the same no matter the character that triggers.")]
		public DamageType Type;

		[Tooltip("Amount of damage. When damage type is set to relative this is a fraction of MaxHealth.")]
		public float Damage = 0.3f;

		[Tooltip("Is shut down after the first trigger.")]
		public bool OnlyOnce;

		[Tooltip("Sound to be played on trigger.")]
		public AudioClip Sound;

		private bool _wasTriggered;

		private void OnEnable()
		{
			_wasTriggered = false;
		}

		private void OnTriggerEnter(Collider other)
		{
			if (_wasTriggered && OnlyOnce)
			{
				return;
			}
			CharacterHealth component = other.GetComponent<CharacterHealth>();
			if (component != null)
			{
				if (Type == DamageType.Constant)
				{
					component.Deal(Damage);
				}
				else if (Type == DamageType.Relative)
				{
					component.Deal(Damage * component.MaxHealth);
				}
				if (Sound != null)
				{
					AudioSource.PlayClipAtPoint(Sound, base.transform.position);
				}
				_wasTriggered = true;
			}
		}
	}
}
