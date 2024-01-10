// DecompilerFi decompiler from Assembly-CSharp.dll class: inimigoescolhido
// SourcesPostProcessor 
using UnityEngine;

public class inimigoescolhido : MonoBehaviour
{
	public GameObject[] inimigo;

	public GameObject[] mascaras;

	public int escolha;

	public int escolha2;

	public int totalalive;

	public int quantd;

	public int quantd2;

	private void Start()
	{
		escolha = UnityEngine.Random.Range(0, quantd);
		escolha2 = UnityEngine.Random.Range(0, quantd2);
		inimigo[escolha].SetActive(value: true);
		mascaras[escolha].SetActive(value: true);
	}

	private void Update()
	{
		totalalive = PlayerPrefs.GetInt("totalalive");
	}
}
