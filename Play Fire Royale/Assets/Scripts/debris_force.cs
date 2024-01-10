// DecompilerFi decompiler from Assembly-CSharp.dll class: debris_force
// SourcesPostProcessor 
using UnityEngine;

public class debris_force : MonoBehaviour
{
	private float t;

	private void Start()
	{
		base.transform.eulerAngles = new Vector3(UnityEngine.Random.Range(-0f, -45f), UnityEngine.Random.Range(-180f, 180f), 0f);
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.forward * 20f * UnityEngine.Random.Range(1f, 1.5f));
		base.transform.localScale = new Vector3(UnityEngine.Random.Range(0.6f, 1.2f), UnityEngine.Random.Range(0.3f, 1f), UnityEngine.Random.Range(0.3f, 1f));
	}

	private void Update()
	{
		GetComponent<Renderer>().material.color += (new Color(1f, 1f, 1f, 1f) - GetComponent<Renderer>().material.color) / 30f;
	}

	private void FixedUpdate()
	{
		GetComponent<Rigidbody>().AddForce(-Vector3.up / 2f);
	}
}
