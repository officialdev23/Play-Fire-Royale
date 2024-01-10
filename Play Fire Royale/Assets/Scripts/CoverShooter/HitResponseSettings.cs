// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.HitResponseSettings
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[Serializable]
	public class HitResponseSettings
	{
		[Tooltip("Minimum wait between hits in seconds.")]
		public float Wait;

		[Tooltip("Angles by which the bone is adjusted on hit.")]
		public float Strength;

		public static HitResponseSettings Default()
		{
			HitResponseSettings hitResponseSettings = new HitResponseSettings();
			hitResponseSettings.Wait = 0.5f;
			hitResponseSettings.Strength = 20f;
			return hitResponseSettings;
		}
	}
}
