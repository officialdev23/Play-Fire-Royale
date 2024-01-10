// DecompilerFi decompiler from Assembly-CSharp.dll class: zombieEscolhido
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

public class zombieEscolhido : MonoBehaviour
{
	public GameObject[] zombie;

	public int escolha;

	public int totalalive;

	public int quantd;

	private void Start()
	{
		escolha = UnityEngine.Random.Range(0, quantd);
		zombie[escolha].SetActive(value: true);
		totalalive = PlayerPrefs.GetInt("totalalive");
		StartCoroutine(somando1());
	}

	private IEnumerator somando1()
	{
		yield return new WaitForSeconds(0.2f);
		totalalive++;
		PlayerPrefs.SetInt("totalalive", totalalive);
	}

	private void Update()
	{
	}
}
