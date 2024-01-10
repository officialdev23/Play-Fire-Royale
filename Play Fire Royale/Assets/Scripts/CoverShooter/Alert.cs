// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Alert
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Alert : MonoBehaviour
	{
		[Tooltip("Range of the alert.")]
		public float Range = 20f;

		[Tooltip("Should the alert be activate when enabling the object.")]
		public bool AutoActivate = true;

		[Tooltip("Is threat regarded as hostile by civilians.")]
		public bool IsHostile;

		[HideInInspector]
		public Actor Generator;

		private Actor _actor;

		private void Awake()
		{
			_actor = GetComponent<Actor>();
		}

		public void Activate()
		{
			Alerts.Broadcast(base.transform.position, Range, IsHostile, (!(_actor == null)) ? _actor : Generator, _actor != null);
		}

		private void OnEnable()
		{
			if (AutoActivate)
			{
				Activate();
			}
		}
	}
}
