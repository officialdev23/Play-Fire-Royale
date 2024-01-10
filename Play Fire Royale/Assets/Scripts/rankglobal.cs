// DecompilerFi decompiler from Assembly-CSharp.dll class: rankglobal
// SourcesPostProcessor 
using UnityEngine;

public class rankglobal : MonoBehaviour
{
	public int extra;

	public int lugar;

	private void Start()
	{
	}

	private void Update()
	{
		extra = PlayerPrefs.GetInt(lugar.ToString() + "extra");
	}
}
