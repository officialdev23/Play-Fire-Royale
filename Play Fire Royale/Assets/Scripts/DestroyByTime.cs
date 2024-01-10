// DecompilerFi decompiler from Assembly-CSharp.dll class: DestroyByTime
// SourcesPostProcessor 
using UnityEngine;

public class DestroyByTime : MonoBehaviour
{
	public float lifetime;

	private void Update()
	{
		lifetime -= Time.deltaTime;
		if (lifetime <= 0f)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}
}
