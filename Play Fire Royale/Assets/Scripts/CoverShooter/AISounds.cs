// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AISounds
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	public class AISounds : MonoBehaviour
	{
		[Tooltip("Possible sounds to play when the AI becomes alerted.")]
		public AudioClip[] Alert;

		[Tooltip("Possible sounds to play when the AI becomes scared.")]
		public AudioClip[] Fear;

		[Tooltip("Possible sounds to play when the AI calls for cops.")]
		public AudioClip[] CopCall;

		[Tooltip("Possible sounds to play when the AI calls for backup.")]
		public AudioClip[] BackupCall;

		[Tooltip("Possible sounds to play when the AI decides to switch a cover.")]
		public AudioClip[] CoverSwitch;

		[Tooltip("Possible sounds to play when the AI begins an assault.")]
		public AudioClip[] Assault;

		private CharacterMotor _motor;

		private void Awake()
		{
			_motor = GetComponent<CharacterMotor>();
		}

		public void OnAlerted()
		{
			if (_motor.IsAlive)
			{
				playSound(Alert);
			}
		}

		public void OnScared()
		{
			if (_motor.IsAlive)
			{
				playSound(Fear);
			}
		}

		public void OnBackupCall()
		{
			if (_motor.IsAlive)
			{
				playSound(BackupCall);
			}
		}

		public void OnCopCall()
		{
			if (_motor.IsAlive)
			{
				playSound(CopCall);
			}
		}

		public void OnCoverSwitch()
		{
			if (_motor.IsAlive)
			{
				playSound(CoverSwitch);
			}
		}

		public void OnAssaultStart()
		{
			if (_motor.IsAlive)
			{
				playSound(Assault);
			}
		}

		private void playSound(AudioClip[] clips)
		{
			if (clips.Length != 0)
			{
				AudioClip clip = clips[Random.Range(0, clips.Length)];
				AudioSource.PlayClipAtPoint(clip, base.transform.position);
			}
		}
	}
}
