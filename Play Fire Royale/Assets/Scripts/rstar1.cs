// DecompilerFi decompiler from Assembly-CSharp.dll class: rstar1
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

public class rstar1 : MonoBehaviour
{
	public int modo;

	private void Start()
	{
		StartCoroutine(show1());
		PlayerPrefs.SetInt("encerra", 0);
		PlayerPrefs.SetInt("totalalive", 18);
		PlayerPrefs.SetInt("nomeinimigo", 0);
	}

	private IEnumerator show1()
	{
		yield return new WaitForSeconds(5f);
		if (modo == 0)
		{
			UnityEngine.SceneManagement.SceneManager.LoadScene("gameplay");
		}
		if (modo == 1)
		{
			UnityEngine.SceneManagement.SceneManager.LoadScene("gameplayzombie");
		}
	}

	private void Update()
	{
		modo = PlayerPrefs.GetInt("modo");
	}
}
