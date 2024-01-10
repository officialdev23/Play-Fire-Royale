// DecompilerFi decompiler from Assembly-CSharp.dll class: AICall
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct AICall
	{
		[Tooltip("Target object that will receive the message.")]
		public GameObject Target;

		[Tooltip("Function name in a script that belongs in the target object.")]
		public string Message;

		[Tooltip("Should the calling Actor component be passed to the called function as an argument.")]
		public bool PassCaller;

		public void Make(Actor caller)
		{
			if (Target != null)
			{
				if (PassCaller)
				{
					Target.SendMessage(Message, caller, SendMessageOptions.RequireReceiver);
				}
				else
				{
					Target.SendMessage(Message, SendMessageOptions.RequireReceiver);
				}
			}
		}

		public static AICall Default()
		{
			AICall result = default(AICall);
			result.Target = null;
			result.Message = "Spawn";
			result.PassCaller = true;
			return result;
		}
	}
}
