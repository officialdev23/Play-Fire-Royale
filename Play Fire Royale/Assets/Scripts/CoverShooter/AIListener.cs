// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIListener
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIListener : MonoBehaviour
	{
		[Tooltip("Fraction of an alert distance at which the AI hears it. 0 means no hearing, 1 means perfect.")]
		public float Hearing = 1f;

		private IAlertListener[] _listeners;

		public void Hear(ref GeneratedAlert alert)
		{
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnAlert(ref alert);
			}
		}

		private void Awake()
		{
			_listeners = Util.GetInterfaces<IAlertListener>(base.gameObject);
		}

		private void OnEnable()
		{
			AIListeners.Register(this);
		}

		private void OnDisable()
		{
			AIListeners.Unregister(this);
		}

		private void OnDestroy()
		{
			AIListeners.Unregister(this);
		}
	}
}
