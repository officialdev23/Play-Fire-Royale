// DecompilerFi decompiler from Assembly-CSharp.dll class: intro
// SourcesPostProcessor 
using UnityEngine;

public class intro : MonoBehaviour
{
	public string cena;

	public void chamarjogo()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene(cena);
	}

	public void chamarsite()
	{
		Application.OpenURL("https://play.google.com/store/apps/dev?id=6361396019019131256");
	}
}
