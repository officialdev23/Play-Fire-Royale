// DecompilerFi decompiler from Assembly-CSharp.dll class: debris_force_big
// SourcesPostProcessor 
using UnityEngine;

public class debris_force_big : MonoBehaviour
{
	private float t;

	public float delay = 0.7f;

	private bool expl;

	private void Start()
	{
		GetComponent<Collider>().enabled = false;
	}

	private void explo()
	{
		expl = true;
		GetComponent<Collider>().enabled = true;
		base.transform.eulerAngles = new Vector3(UnityEngine.Random.Range(-0f, -45f), UnityEngine.Random.Range(-180f, 180f), 0f);
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.forward * 30f * UnityEngine.Random.Range(1f, 1.5f));
		base.transform.localScale = new Vector3(UnityEngine.Random.Range(0.9f, 1.4f), UnityEngine.Random.Range(0.8f, 1.2f), UnityEngine.Random.Range(0.9f, 1.4f));
	}

	private void Update()
	{
		t += Time.deltaTime;
		if (t >= delay)
		{
			GetComponent<Renderer>().material.color += (new Color(1f, 1f, 1f, 1f) - GetComponent<Renderer>().material.color) / 30f;
		}
	}

	private void FixedUpdate()
	{
		if (t >= delay)
		{
			if (!expl)
			{
				explo();
			}
			GetComponent<Rigidbody>().AddForce(-Vector3.up / 2f);
		}
	}
}
