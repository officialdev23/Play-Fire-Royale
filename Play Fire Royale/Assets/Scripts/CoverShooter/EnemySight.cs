// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.EnemySight
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(MeshFilter))]
	public class EnemySight : MonoBehaviour
	{
		[Tooltip("Speed of the field showing up or hiding.")]
		public float FadeSpeed = 2f;

		[Tooltip("Number of vertices on the edge.")]
		public int Detail = 32;

		[Tooltip("AI whose sight is displayed. The component automatically tries to pick one from the parent object.")]
		public AISight TargetOverride;

		[Tooltip("Should the sight be renderer when away from the camera")]
		public bool DisplayWhenAway;

		private Mesh _mesh;

		private float _alpha;

		private bool _hasSetAtLeastOnce;

		private Vector3[] _positions;

		private Color[] _colors;

		private Vector2[] _uv;

		private int[] _indices;

		private Transform _cachedTransform;

		private AISight _cachedSight;

		private CharacterMotor _cachedMotor;

		private void Awake()
		{
			_mesh = GetComponent<MeshFilter>().mesh;
		}

		private void Update()
		{
			Transform transform = (!(TargetOverride == null)) ? TargetOverride.transform : base.transform.parent;
			if (transform == null)
			{
				return;
			}
			if (_cachedTransform != transform)
			{
				_cachedTransform = transform;
				_cachedSight = _cachedTransform.GetComponent<AISight>();
				_cachedMotor = _cachedTransform.GetComponent<CharacterMotor>();
			}
			if (_cachedSight == null)
			{
				return;
			}
			Character character = Characters.Get(_cachedSight.gameObject);
			if (character.Motor.IsAlive && (DisplayWhenAway || character.IsAnyInSight(0f)))
			{
				_alpha += Time.deltaTime * FadeSpeed;
			}
			else
			{
				_alpha -= Time.deltaTime * FadeSpeed;
			}
			if (_cachedMotor != null)
			{
				Vector3 aimTarget = _cachedMotor.AimTarget;
				Vector3 position = base.transform.position;
				aimTarget.y = position.y;
				base.transform.LookAt(aimTarget);
			}
			_alpha = Mathf.Clamp01(_alpha);
			_mesh.Clear();
			int num = Detail * 3;
			int num2 = Detail * 3;
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
			bool flag = false;
			if (_alpha >= 0.003921569f)
			{
				flag = true;
				float num3 = _cachedSight.FieldOfView * _alpha;
				float distance = _cachedSight.Distance;
				for (int i = 0; i < Detail; i++)
				{
					float num4 = num3 * ((float)i / (float)Detail - 0.5f) + 90f;
					float num5 = num3 * ((float)(i + 1) / (float)Detail - 0.5f) + 90f;
					_positions[i * 3] = Vector3.zero;
					_positions[i * 3 + 1] = new Vector3(Mathf.Cos(num5 * ((float)Math.PI / 180f)), 0f, Mathf.Sin(num5 * ((float)Math.PI / 180f))) * distance;
					_positions[i * 3 + 2] = new Vector3(Mathf.Cos(num4 * ((float)Math.PI / 180f)), 0f, Mathf.Sin(num4 * ((float)Math.PI / 180f))) * distance;
				}
				for (int j = 0; j < _colors.Length; j++)
				{
					_colors[j] = new Color(1f, 1f, 1f, _alpha);
				}
				for (int k = 0; k < _uv.Length; k++)
				{
					_uv[k] = new Vector2(_positions[k].x / distance * 0.5f + 0.5f, _positions[k].z / distance * 0.5f + 0.5f);
				}
				if (_indices == null || _indices.Length != num2)
				{
					_indices = new int[num2];
					for (int l = 0; l < _indices.Length; l++)
					{
						_indices[l] = l;
					}
				}
			}
			if (flag || !_hasSetAtLeastOnce)
			{
				_hasSetAtLeastOnce = true;
				_mesh.vertices = _positions;
				_mesh.colors = _colors;
				_mesh.uv = _uv;
				_mesh.triangles = _indices;
			}
		}
	}
}
