// DecompilerFi decompiler from Assembly-CSharp.dll class: smoky_explosion
// SourcesPostProcessor 
using UnityEngine;

public class smoky_explosion : MonoBehaviour
{
	private float t1;

	private float t;

	public float delay;

	private bool expl;

	public float force_k = 1f;

	private void explo()
	{
		expl = true;
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.forward * 200f * force_k * UnityEngine.Random.Range(0.9f, 1.1f));
	}

	private void Update()
	{
		t1 += Time.deltaTime;
		if (t1 >= delay)
		{
			t += Time.deltaTime;
			if (t > 0.2f)
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
		if (t1 >= delay && !expl)
		{
			explo();
		}
	}
}
