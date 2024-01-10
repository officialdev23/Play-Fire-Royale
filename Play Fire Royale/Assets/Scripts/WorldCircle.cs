// DecompilerFi decompiler from Assembly-CSharp.dll class: WorldCircle
// SourcesPostProcessor 
using System;
using UnityEngine;

internal class WorldCircle : MonoBehaviour
{
	private int _segments;

	private float _xradius;

	private float _yradius;

	private LineRenderer _renderer;

	public float[] radii => new float[2]
	{
		_xradius,
		_yradius
	};

	public WorldCircle(ref LineRenderer renderer, int segments, float xradius, float yradius)
	{
		_renderer = renderer;
		_segments = segments;
		_xradius = xradius;
		_yradius = yradius;
		Draw(segments, _xradius, _yradius);
	}

	public WorldCircle(ref LineRenderer renderer)
		: this(ref renderer, 256, 5f, 5f)
	{
	}

	public WorldCircle(ref LineRenderer renderer, int segments)
		: this(ref renderer, segments, 5f, 5f)
	{
	}

	public WorldCircle(ref LineRenderer renderer, int segments, float[] radii)
		: this(ref renderer, segments, radii[0], radii[1])
	{
	}

	public void Draw(int segments, float[] radii)
	{
		_xradius = radii[0];
		_yradius = radii[1];
		Draw(segments, _xradius, _yradius);
	}

	public void Draw(int segments, float xradius, float yradius)
	{
		_xradius = xradius;
		_yradius = yradius;
		_renderer.SetVertexCount(segments + 1);
		_renderer.useWorldSpace = false;
		CreatePoints();
	}

	private void CreatePoints()
	{
		float num = 20f;
		for (int i = 0; i < _segments + 1; i++)
		{
			float x = Mathf.Sin((float)Math.PI / 180f * num) * _xradius;
			float z = Mathf.Cos((float)Math.PI / 180f * num) * _yradius;
			_renderer.SetPosition(i, new Vector3(x, 0f, z));
			num += 360f / (float)_segments;
		}
	}
}
