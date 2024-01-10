// DecompilerFi decompiler from Assembly-CSharp.dll class: controlcaixa
// SourcesPostProcessor 
using UnityEngine;

public class controlcaixa : MonoBehaviour
{
	public int suportehero;

	public int ataque;

	public int area;

	public GameObject h1;

	public GameObject h2;

	public GameObject h3;

	public GameObject h4;

	public GameObject h5;

	public GameObject h6;

	public GameObject h7;

	public AudioSource reload0;

	public AudioSource reload1;

	public void ataque0()
	{
		PlayerPrefs.SetInt("ataque" + area, 0);
		reload0.GetComponent<AudioSource>().Play();
	}

	public void ataque1()
	{
		PlayerPrefs.SetInt("ataque" + area, 1);
		reload1.GetComponent<AudioSource>().Play();
	}

	public void ataque2()
	{
		PlayerPrefs.SetInt("ataque" + area, 2);
		reload1.GetComponent<AudioSource>().Play();
	}

	private void Start()
	{
	}

	private void Update()
	{
		area = PlayerPrefs.GetInt("area");
		suportehero = PlayerPrefs.GetInt("suportehero" + area);
		if (suportehero == 1)
		{
			h1.SetActive(value: true);
		}
		else
		{
			h1.SetActive(value: false);
		}
		if (suportehero == 2)
		{
			h2.SetActive(value: true);
		}
		else
		{
			h2.SetActive(value: false);
		}
		if (suportehero == 3)
		{
			h3.SetActive(value: true);
		}
		else
		{
			h3.SetActive(value: false);
		}
		if (suportehero == 4)
		{
			h4.SetActive(value: true);
		}
		else
		{
			h4.SetActive(value: false);
		}
		if (suportehero == 5)
		{
			h5.SetActive(value: true);
		}
		else
		{
			h5.SetActive(value: false);
		}
		if (suportehero == 6)
		{
			h6.SetActive(value: true);
		}
		else
		{
			h6.SetActive(value: false);
		}
		if (suportehero == 7)
		{
			h7.SetActive(value: true);
		}
		else
		{
			h7.SetActive(value: false);
		}
	}
}
