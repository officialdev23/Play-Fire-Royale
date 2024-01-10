// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterSleep
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Rigidbody))]
	[RequireComponent(typeof(Animator))]
	[RequireComponent(typeof(CapsuleCollider))]
	public class CharacterSleep : MonoBehaviour
	{
		[Tooltip("Distance to the player when to activate the character.")]
		public float On = 20f;

		[Tooltip("Distance to the player when to deactivate the character.")]
		public float Off = 60f;

		private CharacterMotor _motor;

		private Rigidbody _body;

		private Animator _animator;

		private CapsuleCollider _capsule;

		private AIBase[] _ais;

		private bool _isFirst;

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
			_body = GetComponent<Rigidbody>();
			_animator = GetComponent<Animator>();
			_capsule = GetComponent<CapsuleCollider>();
			_ais = GetComponents<AIBase>();
			_isFirst = true;
		}

		private void on()
		{
			_motor.enabled = true;
			_animator.enabled = true;
			_capsule.enabled = true;
			_body.isKinematic = false;
			_body.detectCollisions = true;
			if (_ais != null)
			{
				AIBase[] ais = _ais;
				foreach (AIBase aIBase in ais)
				{
					aIBase.enabled = true;
				}
			}
		}

		private void off()
		{
			_motor.enabled = false;
			_animator.enabled = false;
			_capsule.enabled = false;
			_body.isKinematic = true;
			_body.detectCollisions = false;
			if (_ais != null)
			{
				AIBase[] ais = _ais;
				foreach (AIBase aIBase in ais)
				{
					aIBase.enabled = false;
				}
			}
		}

		private void Update()
		{
			if (_isFirst)
			{
				_isFirst = false;
				if (Characters.MainPlayer.Object != null && Vector3.Distance(base.transform.position, Characters.MainPlayer.Object.transform.position) > On)
				{
					off();
				}
			}
			else if (_motor.isActiveAndEnabled)
			{
				bool flag = false;
				if (Characters.MainPlayer.Object == null)
				{
					flag = true;
				}
				else if (Vector3.Distance(base.transform.position, Characters.MainPlayer.Object.transform.position) > Off)
				{
					flag = true;
				}
				if (flag)
				{
					off();
				}
			}
			else if (Characters.MainPlayer.Object != null && Vector3.Distance(base.transform.position, Characters.MainPlayer.Object.transform.position) < On)
			{
				on();
			}
		}
	}
}
