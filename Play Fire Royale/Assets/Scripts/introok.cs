// DecompilerFi decompiler from Assembly-CSharp.dll class: introok
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class introok : MonoBehaviour
{
	public string name1;

	public Text nomet;

	public GameObject tela1;

	public GameObject tela2;

	public InputField nomeinput;

	private void Start()
	{
		name1 = PlayerPrefs.GetString("nomeuser");
		if (name1 != string.Empty)
		{
			tela1.SetActive(value: false);
			tela2.SetActive(value: true);
		}
		else
		{
			tela2.SetActive(value: false);
			tela1.SetActive(value: true);
		}
	}

	public void salvar()
	{
		PlayerPrefs.SetString("nomeuser", nomeinput.text);
		name1 = PlayerPrefs.GetString("nomeuser");
		if (name1 != string.Empty)
		{
			tela1.SetActive(value: false);
			tela2.SetActive(value: true);
		}
		else
		{
			tela2.SetActive(value: false);
			tela1.SetActive(value: true);
		}
	}

	public void sair()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("loadmenu2");
	}

	private void Update()
	{
		name1 = PlayerPrefs.GetString("nomeuser");
		nomet.text = name1;
	}
}
