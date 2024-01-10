// DecompilerFi decompiler from Assembly-CSharp.dll class: iconearma
// SourcesPostProcessor 
using UnityEngine;

public class iconearma : MonoBehaviour
{
	public GameObject pistola;

	public GameObject armagrande;

	public GameObject MELEE;

	private void Start()
	{
	}

	private void Update()
	{
		if (pistola.gameObject.active)
		{
			PlayerPrefs.SetInt("slot", 2);
		}
		if (armagrande.gameObject.active)
		{
			PlayerPrefs.SetInt("slot", 3);
		}
		if (MELEE.gameObject.active)
		{
			PlayerPrefs.SetInt("slot", 1);
		}
		if (!MELEE.gameObject.active && !armagrande.gameObject.active && !pistola.gameObject.active)
		{
			PlayerPrefs.SetInt("slot", 0);
		}
	}
}
