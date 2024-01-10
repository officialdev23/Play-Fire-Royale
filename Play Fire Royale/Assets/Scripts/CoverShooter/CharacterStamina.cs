// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterStamina
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class CharacterStamina : MonoBehaviour, ICharacterWalkListener, ICharacterHealthListener
	{
		[Tooltip("Current health of the character.")]
		public float Stamina = 100f;

		[Tooltip("Max health to regenerate to.")]
		public float MaxStamina = 100f;

		[Tooltip("Amount of health regenerated per second.")]
		public float Regeneration = 30f;

		[Tooltip("Stamina consumed per second while running.")]
		public float RunCost = 20f;

		[Tooltip("Stamina that has to be regenerated before the ability to run returns.")]
		public float RunTrigger = 20f;

		[Tooltip("Stamina consumed per second while sprinting.")]
		public float SprintCost = 50f;

		[Tooltip("Stamina that has to be regenerated before the ability to sprint returns.")]
		public float SprintTrigger = 50f;

		private bool _isDead;

		private CharacterMotor _motor;

		private float _consumption;

		private void OnValidate()
		{
			Stamina = Mathf.Max(0f, Stamina);
			MaxStamina = Mathf.Max(0f, MaxStamina);
		}

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		public void OnStop()
		{
			_consumption = 0f;
		}

		public void OnWalk()
		{
			_consumption = 0f;
		}

		public void OnRun()
		{
			_consumption = RunCost;
		}

		public void OnSprint()
		{
			_consumption = SprintCost;
		}

		public void OnDead()
		{
			_isDead = true;
		}

		public void OnResurrect()
		{
			_isDead = false;
		}

		public bool Take(float amount)
		{
			if (Stamina > amount)
			{
				Stamina -= amount;
				return true;
			}
			Stamina = 0f;
			_motor.CanRun = false;
			return false;
		}

		private void LateUpdate()
		{
			if (!_isDead)
			{
				if (_consumption > float.Epsilon)
				{
					Take(_consumption * Time.deltaTime);
				}
				Stamina = Mathf.Clamp(Stamina + Regeneration * Time.deltaTime, 0f, MaxStamina);
				if (!_motor.CanRun)
				{
					_motor.CanRun = (Stamina >= RunTrigger);
				}
				if (!_motor.CanSprint)
				{
					_motor.CanSprint = (Stamina >= SprintTrigger);
				}
			}
		}
	}
}
