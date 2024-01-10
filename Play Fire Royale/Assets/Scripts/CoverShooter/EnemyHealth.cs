// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.EnemyHealth
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(HealthBar))]
	public class EnemyHealth : MonoBehaviour
	{
		[Tooltip("Character whose aim is used to determine the enemy.")]
		public CharacterMotor Motor;

		[Range(0f, 20f)]
		[Tooltip("Delay after which the health bar is hidden when there is no target.")]
		public float HideDelay = 4f;

		private float _timer = 10000f;

		private HealthBar _healthBar;

		private void Awake()
		{
			_healthBar = GetComponent<HealthBar>();
		}

		private void LateUpdate()
		{
			GameObject gameObject = (!(Motor == null)) ? Motor.AskForTarget() : null;
			if (Motor == null || gameObject == null || gameObject == Motor.gameObject)
			{
				_timer += Time.deltaTime;
				if (_timer >= HideDelay)
				{
					_healthBar.Target = null;
				}
			}
			else
			{
				_timer = 0f;
				_healthBar.Target = gameObject;
			}
		}
	}
}
