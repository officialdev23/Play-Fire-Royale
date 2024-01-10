// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.Demos.Helpers.AudioIgnoreListenerPauseAndVolume
// SourcesPostProcessor 
using UnityEngine;

namespace ControlFreak2.Demos.Helpers
{
	public class AudioIgnoreListenerPauseAndVolume : MonoBehaviour
	{
		public AudioSource[] targetSources;

		public bool ignoreListenerVolume = true;

		public bool ignoreListenerPause = true;

		private void OnEnable()
		{
			if (targetSources == null || targetSources.Length == 0)
			{
				targetSources = GetComponents<AudioSource>();
			}
			for (int i = 0; i < targetSources.Length; i++)
			{
				if (targetSources[i] != null)
				{
					targetSources[i].ignoreListenerPause = ignoreListenerPause;
					targetSources[i].ignoreListenerVolume = ignoreListenerVolume;
				}
			}
		}
	}
}
