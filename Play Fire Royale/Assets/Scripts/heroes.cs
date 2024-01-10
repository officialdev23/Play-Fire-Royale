// DecompilerFi decompiler from Assembly-CSharp.dll class: heroes
// SourcesPostProcessor 
using UnityEngine;

public class heroes : MonoBehaviour
{
	public int area;

	public int suportehero;

	public GameObject[] suporte;

	private void Start()
	{
		suportehero = PlayerPrefs.GetInt("suportehero" + area);
		suporte[suportehero].SetActive(value: true);
	}

	private void Update()
	{
	}
}
