// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIBase
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class AIBase : MonoBehaviour
	{
		public void Message(string name)
		{
			SendMessage(name, SendMessageOptions.DontRequireReceiver);
		}

		public void Message(string name, object value)
		{
			SendMessage(name, value, SendMessageOptions.DontRequireReceiver);
		}
	}
}
