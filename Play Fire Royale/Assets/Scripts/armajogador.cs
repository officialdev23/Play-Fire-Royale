// DecompilerFi decompiler from Assembly-CSharp.dll class: armajogador
// SourcesPostProcessor 
using UnityEngine;

public class armajogador : MonoBehaviour
{
	public int area;

	public GameObject arma1;

	public GameObject arma2;

	public GameObject arma3;

	public int ataque;

	public int areacerta;

	private void Start()
	{
	}

	private void Update()
	{
		ataque = PlayerPrefs.GetInt("ataque" + area);
		if (ataque == 0)
		{
			arma1.SetActive(value: true);
		}
		else
		{
			arma1.SetActive(value: false);
		}
		if (ataque == 1)
		{
			arma2.SetActive(value: true);
		}
		else
		{
			arma2.SetActive(value: false);
		}
		if (ataque == 2)
		{
			arma3.SetActive(value: true);
		}
		else
		{
			arma3.SetActive(value: false);
		}
	}
}
