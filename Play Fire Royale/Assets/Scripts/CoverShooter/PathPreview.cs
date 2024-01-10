// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.PathPreview
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(MeshFilter))]
	public class PathPreview : MonoBehaviour
	{
		[Tooltip("Width of the line.")]
		public float Width = 0.1f;

		[Tooltip("Distance to fade out starting from the origin.")]
		public float Fade = 2f;

		[HideInInspector]
		public Vector3[] Points;

		[HideInInspector]
		public int PointCount;

		private Mesh _mesh;

		private Vector3[] _positions;

		private Color[] _colors;

		private Vector2[] _uv;

		private int[] _indices;

		private void Awake()
		{
			_mesh = GetComponent<MeshFilter>().mesh;
		}

		private void Update()
		{
			int num = PointCount * 2;
			int num2 = (PointCount - 1) * 6;
			if (_positions == null || _positions.Length != num)
			{
				_positions = new Vector3[num];
			}
			if (_colors == null || _colors.Length != num)
			{
				_colors = new Color[num];
			}
			if (_uv == null || _uv.Length != num)
			{
				_uv = new Vector2[num];
			}
			Vector3 a = (!(CameraManager.Main == null)) ? CameraManager.Main.transform.right : Vector3.right;
			float num3 = 0f;
			for (int i = 0; i < PointCount; i++)
			{
				if (i > 0)
				{
					num3 += Vector3.Distance(Points[i - 1], Points[i]);
				}
				Vector3 a2 = Points[i];
				_positions[i * 2] = base.transform.InverseTransformPoint(a2 - a * Width * 0.5f);
				_positions[i * 2 + 1] = base.transform.InverseTransformPoint(a2 + a * Width * 0.5f);
				_uv[i * 2] = new Vector2(0f, (float)i / (float)(PointCount - 1));
				_uv[i * 2 + 1] = new Vector2(1f, (float)i / (float)(PointCount - 1));
				float a3 = 1f;
				if (num3 < Fade - float.Epsilon)
				{
					a3 = num3 / Fade;
				}
				_colors[i * 2] = new Color(1f, 1f, 1f, a3);
				_colors[i * 2 + 1] = new Color(1f, 1f, 1f, a3);
			}
			if (_indices == null || _indices.Length != num2)
			{
				_indices = new int[num2];
				for (int j = 0; j < PointCount - 1; j++)
				{
					_indices[j * 6] = j * 2;
					_indices[j * 6 + 1] = j * 2 + 1;
					_indices[j * 6 + 2] = (j + 1) * 2 + 1;
					_indices[j * 6 + 3] = (j + 1) * 2 + 1;
					_indices[j * 6 + 4] = (j + 1) * 2;
					_indices[j * 6 + 5] = j * 2;
				}
			}
			_mesh.Clear();
			_mesh.vertices = _positions;
			_mesh.colors = _colors;
			_mesh.uv = _uv;
			_mesh.triangles = _indices;
		}
	}
}
