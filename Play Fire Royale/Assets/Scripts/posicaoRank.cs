// DecompilerFi decompiler from Assembly-CSharp.dll class: posicaoRank
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class posicaoRank : MonoBehaviour
{
	public int posicao;

	public string nomeglobal;

	public string scoreglobal;

	public Text nometx;

	public Text scoretx;

	private void Start()
	{
		nomeglobal = PlayerPrefs.GetString("nomeglobal" + posicao.ToString());
		scoreglobal = PlayerPrefs.GetString("scoreglobal" + posicao.ToString());
		if (posicao != 1)
		{
			nometx.text = posicao.ToString() + " - " + nomeglobal;
		}
		else
		{
			nometx.text = nomeglobal;
		}
		scoretx.text = scoreglobal;
	}

	private void Update()
	{
	}
}
