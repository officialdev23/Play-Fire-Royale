// DecompilerFi decompiler from Assembly-CSharp.dll class: smoke_force
// SourcesPostProcessor 
using UnityEngine;

public class smoke_force : MonoBehaviour
{
	private float t1;

	private float t;

	public float delay = 0.7f;

	private bool expl;

	public float force_k = 1f;

	private void explo()
	{
		expl = true;
		base.transform.eulerAngles = new Vector3(UnityEngine.Random.Range(-50f, -85f), UnityEngine.Random.Range(-180f, 180f), 0f);
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.forward * 50f * force_k * UnityEngine.Random.Range(0.9f, 1.1f));
	}

	private void Update()
	{
		t1 += Time.deltaTime;
		if (t1 >= delay)
		{
			t += Time.deltaTime;
			if (t > 3f)
			{
				MonoBehaviour.print(GetComponent<ParticleSystem>().startSize);
				GetComponent<ParticleSystem>().startSize += (0f - GetComponent<ParticleSystem>().startSize) / 30f;
				ParticleSystem component = GetComponent<ParticleSystem>();
				Color startColor = component.startColor;
				Color startColor2 = GetComponent<ParticleSystem>().startColor;
				float r = startColor2.r;
				Color startColor3 = GetComponent<ParticleSystem>().startColor;
				float g = startColor3.g;
				Color startColor4 = GetComponent<ParticleSystem>().startColor;
				component.startColor = startColor + (new Color(r, g, startColor4.b, 0f) - GetComponent<ParticleSystem>().startColor) / 10f;
			}
			if (t > 7f)
			{
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}
	}

	private void FixedUpdate()
	{
		if (t1 >= delay)
		{
			if (!expl)
			{
				explo();
			}
			GetComponent<Rigidbody>().AddForce(-Vector3.up / 4f);
		}
	}
}
