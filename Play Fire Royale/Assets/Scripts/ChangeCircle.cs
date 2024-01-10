// DecompilerFi decompiler from Assembly-CSharp.dll class: ChangeCircle
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

[RequireComponent(typeof(LineRenderer))]
public class ChangeCircle : MonoBehaviour
{
	[Range(0f, 360f)]
	public int Segments;

	[Range(0f, 5000f)]
	public float XRadius;

	[Range(0f, 5000f)]
	public float YRadius;

	public GameObject ZoneWall;

	public bool Shrinking;

	private WorldCircle circle;

	private LineRenderer renderer;

	private float[] radii = new float[2];

	private void Start()
	{
		renderer = base.gameObject.GetComponent<LineRenderer>();
		radii[0] = XRadius;
		radii[1] = YRadius;
		circle = new WorldCircle(ref renderer, Segments, radii);
		ZoneWall = GameObject.FindGameObjectWithTag("ZoneWall");
	}

	private void Update()
	{
		if (CF2Input.GetMouseButtonDown(0))
		{
			Shrinking = true;
		}
		if (Shrinking)
		{
			XRadius = Mathf.Lerp(XRadius, ShrinkCircle(XRadius)[0], Time.deltaTime * 0.5f);
			circle.Draw(Segments, XRadius, XRadius);
		}
		ZoneWall.transform.localScale = new Vector3(XRadius * 0.01f, 1f, XRadius * 0.01f);
		UnityEngine.Debug.Log(XRadius);
	}

	private float[] ShrinkCircle(float amount)
	{
		float num = circle.radii[0] - amount;
		float num2 = circle.radii[1] - amount;
		return new float[2]
		{
			num,
			num2
		};
	}
}
