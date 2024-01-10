// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIEffects
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class AIEffects : MonoBehaviour
	{
		[Tooltip("Effect prefab to instantiate when the AI becomes alerted.")]
		public GameObject Alert;

		[Tooltip("Effect prefab to instantiate when the AI becomes scared.")]
		public GameObject Fear;

		[Tooltip("Effect prefab to instantiate when the AI calls for cops.")]
		public GameObject CopCall;

		[Tooltip("Effect prefab to instantiate when the AI calls for backup.")]
		public GameObject BackupCall;

		[Tooltip("Effect prefab to instantiate when the AI decides to switch a cover.")]
		public GameObject CoverSwitch;

		[Tooltip("Effect prefab to instantiate when the AI begins an assault.")]
		public GameObject Assault;

		private CharacterMotor _motor;

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		public void OnAlerted()
		{
			if (_motor.IsAlive)
			{
				instantiate(Alert, base.transform.position);
			}
		}

		public void OnScared()
		{
			if (_motor.IsAlive)
			{
				instantiate(Fear, base.transform.position);
			}
		}

		public void OnBackupCall()
		{
			if (_motor.IsAlive)
			{
				instantiate(BackupCall, base.transform.position);
			}
		}

		public void OnCopCall()
		{
			if (_motor.IsAlive)
			{
				instantiate(CopCall, base.transform.position);
			}
		}

		public void OnCoverSwitch()
		{
			if (_motor.IsAlive)
			{
				instantiate(CoverSwitch, base.transform.position);
			}
		}

		public void OnAssaultStart()
		{
			if (_motor.IsAlive)
			{
				instantiate(Assault, base.transform.position);
			}
		}

		private void instantiate(GameObject prefab, Vector3 position)
		{
			if (!(prefab == null))
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(prefab);
				gameObject.transform.SetParent(null);
				gameObject.transform.position = position;
				gameObject.SetActive(value: true);
				UnityEngine.Object.Destroy(gameObject, 3f);
			}
		}
	}
}
