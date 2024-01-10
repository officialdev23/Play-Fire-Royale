// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIAlerts
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Actor))]
	public class AIAlerts : MonoBehaviour
	{
		[Tooltip("Distance at which the alerted AI can be heard. Alert is not generated if value is zero or negative.")]
		public float Alert = 10f;

		[Tooltip("Distance at which the scared AI can be heard. Alert is not generated if value is zero or negative.")]
		public float Fear = 10f;

		[Tooltip("Distance at which the AI calling for cops can be heard. Alert is not generated if value is zero or negative.")]
		public float CopCall = 10f;

		[Tooltip("Distance at which the AI calling for backup can be heard. Alert is not generated if value is zero or negative.")]
		public float BackupCall = 10f;

		[Tooltip("Distance at which the AI announcing a cover switch can be heard. Alert is not generated if value is zero or negative.")]
		public float CoverSwitch = 10f;

		[Tooltip("Distance at which the AI announcing an assault can be heard. Alert is not generated if value is zero or negative.")]
		public float Assault = 10f;

		private Actor _actor;

		private void Awake()
		{
			_actor = GetComponent<Actor>();
		}

		public void OnAlerted()
		{
			if (_actor.IsAlive && Alert > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, Alert,  false, _actor,  true);
			}
		}

		public void OnScared()
		{
			if (_actor.IsAlive && Fear > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, Fear,  false, _actor,  true);
			}
		}

		public void OnBackupCall()
		{
			if (_actor.IsAlive && BackupCall > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, BackupCall,  false, _actor,  true);
			}
		}

		public void OnCopCall()
		{
			if (_actor.IsAlive && CopCall > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, CopCall,  false, _actor,  true);
			}
		}

		public void OnCoverSwitch()
		{
			if (_actor.IsAlive && CoverSwitch > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, CoverSwitch,  false, _actor,  true);
			}
		}

		public void OnAssaultStart()
		{
			if (_actor.IsAlive && Assault > float.Epsilon)
			{
				Alerts.Broadcast(base.transform.position, Assault,  false, _actor,  true);
			}
		}
	}
}
