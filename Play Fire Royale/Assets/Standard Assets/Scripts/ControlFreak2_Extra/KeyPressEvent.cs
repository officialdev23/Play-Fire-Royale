// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.Extra.KeyPressEvent
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.Events;

namespace ControlFreak2.Extra
{
	public class KeyPressEvent : MonoBehaviour
	{
		public enum EventType
		{
			OnPress,
			OnRelease,
			WhenPressed
		}

		public KeyCode keyCode;

		public EventType eventType;

		public UnityEvent keyEvent;

		public KeyPressEvent()
		{
			keyEvent = new UnityEvent();
		}

		private void Update()
		{
			bool flag = false;
			switch (eventType)
			{
			case EventType.OnPress:
				flag = CF2Input.GetKeyDown(keyCode);
				break;
			case EventType.OnRelease:
				flag = CF2Input.GetKeyUp(keyCode);
				break;
			case EventType.WhenPressed:
				flag = CF2Input.GetKey(keyCode);
				break;
			}
			if (flag)
			{
				keyEvent.Invoke();
			}
		}
	}
}
