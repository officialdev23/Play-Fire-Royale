// DecompilerFi decompiler from Assembly-CSharp.dll class: rsetar
// SourcesPostProcessor 
using UnityEngine;

public class rsetar : MonoBehaviour
{
	public int tutorial;

	private void Start()
	{
		tutorial = PlayerPrefs.GetInt("tutorial");
		if (tutorial == 0)
		{
			PlayerPrefs.SetInt("level", 1);
			PlayerPrefs.SetInt("hero", 1);
			PlayerPrefs.SetInt("block1", 2);
			PlayerPrefs.SetInt("block2", 2);
			PlayerPrefs.SetInt("block3", 2);
		}
	}

	private void Update()
	{
	}
}
