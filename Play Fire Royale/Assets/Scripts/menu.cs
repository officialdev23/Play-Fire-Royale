// DecompilerFi decompiler from Assembly-CSharp.dll class: menu
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

public class menu : MonoBehaviour
{
	private void Start()
	{
		Time.timeScale = 1f;
		CFCursor.lockState = CursorLockMode.None;
		CFCursor.visible = true;
	}

	public void chamar1()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("voo");
		PlayerPrefs.SetInt("modo", 0);
	}

	public void chamar2()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("voo");
		PlayerPrefs.SetInt("modo", 1);
	}

	private void Update()
	{
	}
}
