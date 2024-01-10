// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Projectile
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Projectile : MonoBehaviour
	{
		[Tooltip("Speed of the projectile in meters per second.")]
		public float Speed = 10f;

		[HideInInspector]
		public float Distance = 1f;

		[HideInInspector]
		public Vector3 Direction;

		[HideInInspector]
		public GameObject Target;

		[HideInInspector]
		public Hit Hit;

		private float _path;

		private void OnEnable()
		{
			_path = 0f;
		}

		private void Update()
		{
			base.transform.position += Direction * Speed * Time.deltaTime;
			_path += Speed * Time.deltaTime;
			if (_path >= Distance)
			{
				if (Target != null)
				{
					Target.SendMessage("OnHit", Hit, SendMessageOptions.DontRequireReceiver);
				}
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}
	}
}
