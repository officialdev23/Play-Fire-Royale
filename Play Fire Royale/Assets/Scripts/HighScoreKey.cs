// DecompilerFi decompiler from Assembly-CSharp.dll class: HighScoreKey
// SourcesPostProcessor 
using UnityEngine;

public class HighScoreKey : MonoBehaviour
{
	private Vector3 StartPos;

	private float uptime;

	private bool hit;

	private void Start()
	{
		StartPos = base.transform.localPosition;
		uptime = Time.time;
		hit = false;
	}

	public void HitKey(Vector3 normal)
	{
		Vector3 startPos = StartPos;
		startPos.y -= 0.015f;
		base.transform.localPosition = startPos;
		uptime = Time.time + 0.1f;
		hit = true;
	}

	private void Update()
	{
		if (hit && Time.time > uptime)
		{
			base.transform.localPosition = StartPos;
		}
	}
}
