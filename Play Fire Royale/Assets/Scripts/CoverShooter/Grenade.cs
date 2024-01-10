// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Grenade
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Grenade : MonoBehaviour
	{
		[Tooltip("Explosion prefab to instantiate on detonation.")]
		public GameObject Explosion;

		[Tooltip("Distance from the explosion center where damage reaches 0.")]
		public float ExplosionRadius = 4.5f;

		[Tooltip("Damage done at the center of explosion.")]
		public float CenterDamage = 150f;

		[Tooltip("Fraction of velocity retained when bouncing from a surface.")]
		public float Bounciness = 0.3f;

		[Tooltip("Explosion timer in seconds counted from activation.")]
		public float Timer = 3f;

		[Tooltip("Camera shake duration when exploded.")]
		public float ShakeDuration = 0.5f;

		[Tooltip("Camera shake intensity when close to the camera.")]
		public float ShakeIntensity = 100f;

		[Tooltip("Prefab to instantiate to display grenade explosion preview.")]
		public GameObject ExplosionPreview;

		[Tooltip("Time in seconds since the activation to display the explosion preview.")]
		public float PreviewTime;

		private bool _hasExploded;

		private bool _isActivated;

		private bool _isActivating;

		private float _activateTimer;

		private Actor _attacker;

		private float _timer;

		private bool _isFlying;

		private Vector3 _velocity;

		private Vector3 _offset;

		private float _gravity;

		private GameObject _preview;

		public Actor Attacker => _attacker;

		private void OnEnable()
		{
			if (_isActivated)
			{
				GrenadeList.Register(this);
			}
		}

		private void OnDisable()
		{
			if (_preview != null)
			{
				UnityEngine.Object.Destroy(_preview);
				_preview = null;
			}
			GrenadeList.Unregister(this);
		}

		public void Fly(Vector3 origin, Vector3 velocity, float gravity)
		{
			_isFlying = true;
			_offset = base.transform.position - origin;
			if (_offset.magnitude > 0.5f)
			{
				_offset = _offset.normalized * 0.5f;
			}
			_velocity = velocity;
			_gravity = gravity;
		}

		public void Activate(Actor attacker, float delay = 0f)
		{
			if (delay <= float.Epsilon)
			{
				_isActivated = true;
				_isActivating = false;
				_timer = Timer;
				GrenadeList.Register(this);
			}
			else
			{
				_isActivating = true;
				_activateTimer = delay;
			}
			_attacker = attacker;
		}

		private void Update()
		{
			if (_isActivating)
			{
				_activateTimer -= Time.deltaTime;
				if (_activateTimer < float.Epsilon)
				{
					_isActivating = false;
					_isActivated = true;
					GrenadeList.Register(this);
					_timer = Timer;
				}
			}
			if (_isActivated)
			{
				if (_timer < float.Epsilon)
				{
					explode();
				}
				else
				{
					_timer -= Time.deltaTime;
					if (_timer < Timer - PreviewTime)
					{
						if (_preview == null && ExplosionPreview != null)
						{
							_preview = UnityEngine.Object.Instantiate(ExplosionPreview);
							_preview.transform.SetParent(null);
							_preview.SetActive(value: true);
						}
						if (_preview != null)
						{
							_preview.transform.localScale = Vector3.one * ExplosionRadius * 2f;
							_preview.transform.position = base.transform.position;
						}
					}
					else if (_preview != null)
					{
						UnityEngine.Object.Destroy(_preview);
						_preview = null;
					}
				}
			}
			if (_isFlying)
			{
				Vector3 position = base.transform.position;
				Vector3 offset = _offset;
				_offset = Util.Lerp(_offset, Vector3.zero, 2f);
				position += _offset - offset;
				GrenadePath.Step(ref position, ref _velocity, Time.deltaTime, _gravity, Bounciness);
				base.transform.position = position;
			}
		}

		private void explode()
		{
			if (_hasExploded || !_isActivated)
			{
				return;
			}
			ThirdPersonCamera.Shake(base.transform.position, ShakeIntensity, ShakeDuration);
			_hasExploded = true;
			if (Explosion != null)
			{
				Alert component = Explosion.GetComponent<Alert>();
				if (component != null)
				{
					component.Generator = _attacker;
				}
				GameObject gameObject = UnityEngine.Object.Instantiate(Explosion, base.transform.position, Quaternion.identity, null);
				gameObject.SetActive(value: true);
			}
			Collider[] array = Physics.OverlapSphere(base.transform.position, ExplosionRadius);
			int num = Physics.OverlapSphereNonAlloc(base.transform.position, ExplosionRadius, Util.Colliders);
			for (int i = 0; i < num; i++)
			{
				Collider collider = Util.Colliders[i];
				if (collider.isTrigger)
				{
					continue;
				}
				BodyPartHealth component2 = collider.GetComponent<BodyPartHealth>();
				if (component2 == null)
				{
					Vector3 vector = collider.transform.position;
					if (collider.GetType() == typeof(MeshCollider) && ((MeshCollider)collider).convex)
					{
						vector = collider.ClosestPoint(base.transform.position);
					}
					Vector3 a = base.transform.position - vector;
					float magnitude = a.magnitude;
					if (magnitude < ExplosionRadius)
					{
						Apply(normal: (!(magnitude > float.Epsilon)) ? (vector - collider.transform.position).normalized : (a / magnitude), target: collider.gameObject, position: vector, fraction: 1f - magnitude / ExplosionRadius);
					}
				}
			}
			UnityEngine.Object.Destroy(base.gameObject);
		}

		protected virtual void Apply(GameObject target, Vector3 position, Vector3 normal, float fraction)
		{
			float num = CenterDamage * fraction;
			if (num > float.Epsilon)
			{
				Hit hit = new Hit(position, normal, num, null, target, HitType.Explosion, 0f);
				target.SendMessage("OnHit", hit, SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
