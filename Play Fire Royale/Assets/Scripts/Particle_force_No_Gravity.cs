// DecompilerFi decompiler from Assembly-CSharp.dll class: Particle_force_No_Gravity
// SourcesPostProcessor 
using UnityEngine;

public class Particle_force_No_Gravity : MonoBehaviour
{
	private float t;

	private void Start()
	{
		base.transform.eulerAngles = new Vector3(UnityEngine.Random.Range(-90f, 90f), UnityEngine.Random.Range(-180f, 180f), 0f);
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.forward * 30f);
	}

	private void Update()
	{
		t += Time.deltaTime;
		if (t > 1f)
		{
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
		if (t > 2.5f)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}
}
