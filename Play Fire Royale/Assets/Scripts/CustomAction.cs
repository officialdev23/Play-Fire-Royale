// DecompilerFi decompiler from Assembly-CSharp.dll class: CustomAction
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public struct CustomAction
	{
		[Tooltip("Key to be pressed to active the trigger.")]
		public KeyCode Key;

		[Tooltip("Name of the animation trigger.")]
		public string Name;

		[Tooltip("Name of the message.")]
		public string Message;
	}
}
