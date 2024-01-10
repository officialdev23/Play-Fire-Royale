// DecompilerFi decompiler from Assembly-CSharp.dll class: light_control
// SourcesPostProcessor 
using UnityEngine;

public class light_control : MonoBehaviour
{
	private float t;

	private void Start()
	{
	}

	private void Update()
	{
		t += Time.deltaTime;
		if (t > 0.5f)
		{
			GetComponent<Light>().intensity += (0f - GetComponent<Light>().intensity) / 100f;
		}
	}
}
