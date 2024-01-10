// DecompilerFi decompiler from Assembly-CSharp.dll class: loadojk
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

public class loadojk : MonoBehaviour
{
	public string CENA;

	public float tempo;

	private IEnumerator Start()
	{
		yield return new WaitForSeconds(tempo);
		UnityEngine.SceneManagement.SceneManager.LoadScene(CENA);
	}
}
