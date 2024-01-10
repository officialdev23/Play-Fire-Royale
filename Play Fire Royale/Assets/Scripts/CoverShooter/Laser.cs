// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Laser
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(MeshFilter))]
	[RequireComponent(typeof(Renderer))]
	public class Laser : MonoBehaviour
	{
		[Tooltip("Max length of the laser.")]
		public float MaxLength = 4f;

		[Tooltip("Transparency of the laser, usually managed by the gun.")]
		public float Alpha = 1f;

		[HideInInspector]
		public float Length = 4f;

		private Mesh _mesh;

		private Renderer _renderer;

		private float _generatedLength;

		private float _laserIntensity;

		public void Setup(Vector3 origin, Vector3 target)
		{
			base.transform.position = origin;
			base.transform.LookAt(target);
			Length = Vector3.Distance(origin, target);
			if (Length > MaxLength)
			{
				Length = MaxLength;
			}
		}

		private void Awake()
		{
			_mesh = GetComponent<MeshFilter>().mesh;
			_renderer = GetComponent<Renderer>();
			Material material = (!(_renderer.material == null)) ? UnityEngine.Object.Instantiate(_renderer.material) : null;
			_renderer.material = material;
		}

		private void Update()
		{
			if (Alpha < _laserIntensity)
			{
				_laserIntensity -= Time.deltaTime * 8f;
				_laserIntensity = Mathf.Clamp(_laserIntensity, Alpha, 1f);
			}
			else
			{
				_laserIntensity += Time.deltaTime * 3f;
				_laserIntensity = Mathf.Clamp(_laserIntensity, 0f, Alpha);
			}
			if (_renderer.material != null)
			{
				_renderer.enabled = (Alpha > float.Epsilon);
				if (_renderer.enabled)
				{
					Color color = _renderer.material.color;
					color.a = _laserIntensity;
					_renderer.material.color = color;
				}
			}
			else
			{
				_renderer.enabled = (Alpha > 0.5f);
			}
			if (_generatedLength != Length)
			{
				_generatedLength = Length;
				float magnitude = base.transform.InverseTransformPoint(base.transform.position + base.transform.forward * Length).magnitude;
				Vector3[] array = new Vector3[64];
				Color[] colors = new Color[64];
				Vector2[] array2 = new Vector2[64];
				int[] array3 = new int[186];
				float y = Length / MaxLength;
				for (int i = 0; i < 32; i++)
				{
					float num = (float)i / 31f;
					float f = (float)Math.PI * 2f * num;
					float x = Mathf.Cos(f) * 0.5f + 0.5f;
					float x2 = Mathf.Cos(f);
					float y2 = Mathf.Sin(f);
					Vector3 vector = new Vector3(x2, y2, 0f);
					Vector3 vector2 = new Vector3(x2, y2, magnitude);
					array[i] = vector;
					array[i + 32] = vector2;
					array2[i] = new Vector2(x, 0f);
					array2[i + 32] = new Vector2(x, y);
				}
				int num2 = 0;
				for (int j = 0; j < 31; j++)
				{
					array3[num2++] = j;
					array3[num2++] = j + 1;
					array3[num2++] = 32 + j;
					array3[num2++] = j + 1;
					array3[num2++] = 32 + j + 1;
					array3[num2++] = 32 + j;
				}
				_mesh.Clear();
				_mesh.vertices = array;
				_mesh.colors = colors;
				_mesh.uv = array2;
				_mesh.triangles = array3;
			}
		}
	}
}
