// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ResetOnDeath
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace CoverShooter
{
	public class ResetOnDeath : MonoBehaviour, ICharacterHealthListener
	{
		[Tooltip("Time in seconds to reset the level after character's death")]
		public float Delay = 3f;

		public void OnDead()
		{
			StartCoroutine(delayedReset());
		}

		public void OnResurrect()
		{
		}

		private IEnumerator delayedReset()
		{
			yield return new WaitForSeconds(Delay);
			SceneManager.LoadScene(SceneManager.GetActiveScene().name);
		}

		private void OnValidate()
		{
			Delay = Mathf.Max(0f, Delay);
		}
	}
}
