// DecompilerFi decompiler from Assembly-CSharp.dll class: uirank
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class uirank : MonoBehaviour
{
	public string name1;

	public string score1;

	public int lugar;

	public Text nametx;

	public Text scoretx;

	public int tipo;

	private void Start()
	{
	}

	private void Update()
	{
		name1 = PlayerPrefs.GetString("nomeglobal" + lugar);
		score1 = PlayerPrefs.GetString("scoreglobal" + lugar);
		nametx.text = name1;
		scoretx.text = score1;
	}
}
