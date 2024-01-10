// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ExplosionPreview
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[ExecuteInEditMode]
	[RequireComponent(typeof(Renderer))]
	public class ExplosionPreview : MonoBehaviour
	{
		private Renderer _renderer;

		private Material _material;

		private void Awake()
		{
			_renderer = GetComponent<Renderer>();
			_material = UnityEngine.Object.Instantiate(_renderer.material);
			_renderer.material = _material;
		}

		private void OnRenderObject()
		{
			if (_material != null)
			{
				_material.SetVector("_Center", base.transform.position);
				Material material = _material;
				Vector3 localScale = base.transform.localScale;
				material.SetFloat("_Radius", localScale.x);
			}
		}
	}
}
