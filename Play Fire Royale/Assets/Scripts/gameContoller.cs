// DecompilerFi decompiler from Assembly-CSharp.dll class: gameContoller
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class gameContoller : MonoBehaviour
{
	public Image darkness;

	private void Start()
	{
		darkness.enabled = true;
		darkness.CrossFadeAlpha(1f, 0f, ignoreTimeScale: false);
		darkness.CrossFadeAlpha(0f, 0.5f, ignoreTimeScale: false);
	}

	public void resetLevel()
	{
		darkness.CrossFadeAlpha(1f, 0.5f, ignoreTimeScale: false);
		StartCoroutine(reload());
	}

	public IEnumerator reload()
	{
		yield return new WaitForSeconds(0.5f);
		UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name);
	}
}
