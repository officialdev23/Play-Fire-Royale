// DecompilerFi decompiler from Assembly-CSharp.dll class: areasuporte
// SourcesPostProcessor 
using UnityEngine;

public class areasuporte : MonoBehaviour
{
	public int area;

	public int suportehero;

	public GameObject suporte1;

	public GameObject suporte2;

	public GameObject suporte3;

	public GameObject suporte4;

	public GameObject suporte5;

	public GameObject suporte6;

	public GameObject suporte7;

	public float x;

	public float y;

	public float z;

	private void Start()
	{
		suportehero = PlayerPrefs.GetInt("suportehero" + area);
	}

	private void Update()
	{
		suportehero = PlayerPrefs.GetInt("suportehero" + area);
		if (suportehero == 1)
		{
			suporte1.SetActive(value: true);
		}
		else
		{
			suporte1.SetActive(value: false);
		}
		if (suportehero == 2)
		{
			suporte2.SetActive(value: true);
		}
		else
		{
			suporte2.SetActive(value: false);
		}
		if (suportehero == 3)
		{
			suporte3.SetActive(value: true);
		}
		else
		{
			suporte3.SetActive(value: false);
		}
		if (suportehero == 4)
		{
			suporte4.SetActive(value: true);
		}
		else
		{
			suporte4.SetActive(value: false);
		}
		if (suportehero == 5)
		{
			suporte5.SetActive(value: true);
		}
		else
		{
			suporte5.SetActive(value: false);
		}
		if (suportehero == 6)
		{
			suporte6.SetActive(value: true);
		}
		else
		{
			suporte6.SetActive(value: false);
		}
		if (suportehero == 7)
		{
			suporte7.SetActive(value: true);
		}
		else
		{
			suporte7.SetActive(value: false);
		}
	}
}
