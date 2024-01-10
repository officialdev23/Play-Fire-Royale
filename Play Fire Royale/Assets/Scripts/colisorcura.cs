// DecompilerFi decompiler from Assembly-CSharp.dll class: colisorcura
// SourcesPostProcessor 
using UnityEngine;

public class colisorcura : MonoBehaviour
{
	public GameObject cura1;

	private void Start()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag == "suport")
		{
			cura1.SetActive(value: false);
		}
	}

	private void Update()
	{
	}
}
