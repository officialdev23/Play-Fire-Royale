// DecompilerFi decompiler from Assembly-CSharp.dll class: controleui
// SourcesPostProcessor 
using UnityEngine;

public class controleui : MonoBehaviour
{
	public int hero;

	public GameObject[] ui1;

	private void Start()
	{
		hero = PlayerPrefs.GetInt("hero");
		ui1[hero].SetActive(value: true);
	}
}
