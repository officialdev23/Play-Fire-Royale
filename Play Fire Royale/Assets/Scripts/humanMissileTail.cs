// DecompilerFi decompiler from Assembly-CSharp.dll class: humanMissileTail
// SourcesPostProcessor 
using UnityEngine;

public class humanMissileTail : MonoBehaviour
{
	public TrailRenderer tail;

	public float scrollSpeed = 0.5f;

	private void Update()
	{
		float x = Time.time * scrollSpeed;
		tail.material.SetTextureOffset("_MainTex", new Vector2(x, 0f));
	}
}
