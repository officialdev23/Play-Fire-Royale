// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.Extra.ButtonPressEvent
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.Events;

namespace ControlFreak2.Extra
{
	public class ButtonPressEvent : MonoBehaviour
	{
		public enum EventType
		{
			OnPress,
			OnRelease,
			WhenPressed
		}

		public string buttonName = "Fire1";

		private int buttonId;

		public EventType eventType;

		public UnityEvent buttonEvent;

		public ButtonPressEvent()
		{
			buttonEvent = new UnityEvent();
		}

		private void Update()
		{
			bool flag = false;
			switch (eventType)
			{
			case EventType.OnPress:
				flag = CF2Input.GetButtonDown(buttonName, ref buttonId);
				break;
			case EventType.OnRelease:
				flag = CF2Input.GetButtonUp(buttonName, ref buttonId);
				break;
			case EventType.WhenPressed:
				flag = CF2Input.GetButton(buttonName, ref buttonId);
				break;
			}
			if (flag)
			{
				buttonEvent.Invoke();
			}
		}
	}
}
