// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseGun
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	public abstract class BaseGun : MonoBehaviour
	{
		[Tooltip("Animations and related assets to be used with this weapon.")]
		public WeaponType Type;

		[Tooltip("Name of the gun to be display on the HUD.")]
		public string Name = "Gun";

		[Tooltip("How many degrees should the camera FOV be reduced when using scope on the gun.")]
		public float Zoom = 30f;

		[Tooltip("Sprite that's displayed when zooming in.")]
		public Sprite Scope;

		[Tooltip("Rate of fire in shots per second.")]
		[Range(0f, 1000f)]
		public float Rate = 7f;

		[Tooltip("Bullets fired per single shot.")]
		public int BulletsPerShot = 1;

		[Tooltip("If firing multiple bullets per shot, should only a single bullet be removed from the inventory.")]
		public bool ConsumeSingleBulletPerShot = true;

		[Tooltip("Maximum distance of a bullet hit. Objects further than this value are ignored.")]
		public float Distance = 50f;

		[Tooltip("Damage dealt by a single bullet.")]
		[Range(0f, 1000f)]
		public float Damage = 10f;

		[Tooltip("Maximum degrees of error the gun can make when firing.")]
		public float Error;

		[Tooltip("Should the gun be reloaded automatically when the magazine is empty.")]
		public bool AutoReload;

		[Tooltip("Is the gun reloaded with whole magazines or bullet by bullet.")]
		public bool ReloadWithMagazines = true;

		[Tooltip("If reloading bullet by bullet, can the gun be fired during reload.")]
		public bool CanInterruptBulletLoad = true;

		[Tooltip("After a new magazine or the last bullet is loaded, should the gun be pumped.")]
		public bool PumpAfterFinalLoad;

		[Tooltip("Should the gun be pumped after each bullet load.")]
		public bool PumpAfterBulletLoad;

		[Tooltip("Should the gun be pumped after firing a shot.")]
		public bool PumpAfterFire;

		[Tooltip("Will the character fire by just aiming the mobile controller.")]
		public bool FireOnMobileAim = true;

		[Tooltip("Should the laser be visible only when zooming.")]
		public bool LaserOnlyOnZoom = true;

		[Tooltip("Should a debug ray be displayed.")]
		public bool DebugAim;

		[Tooltip("Link to the object that controls the aiming direction.")]
		public GameObject Aim;

		[Tooltip("Object to be instantiated as a bullet.")]
		public GameObject Bullet;

		[Tooltip("Link to the object that controls the position of character's left hand relative to the weapon.")]
		public Transform LeftHandDefault;

		[Tooltip("Time in seconds between hits that the target character will respond to with hurt animations.")]
		public float DamageResponseWaitTime = 1f;

		[Tooltip("Should the gun's crosshair be used instead of the one set in the Crosshair component.")]
		public bool UseCustomCrosshair;

		[Tooltip("Custom crosshair settings to override the ones set in the Crosshair component. Used only if UseCustomCrosshair is enabled.")]
		public CrosshairSettings CustomCrosshair = CrosshairSettings.Default();

		[Tooltip("Settings that manage gun's recoil behaviour.")]
		public GunRecoilSettings Recoil = GunRecoilSettings.Default();

		[Tooltip("Links to objects that overwrite the value in LeftHand based on the gameplay situation.")]
		public HandOverwrite LeftHandOverwrite;

		[Tooltip("Force the pistol to use this laser instead of finding one on its own.")]
		public Laser LaserOverwrite;

		[HideInInspector]
		public CharacterMotor Character;

		public Action MagazineLoadStarted;

		public Action FullyLoaded;

		public Action BulletLoadStarted;

		public Action BulletLoaded;

		public Action PumpStarted;

		public Action Pumped;

		public Action Fired;

		public Action EmptyFire;

		public Action FireStarted;

		public Action FireStopped;

		public Action<Hit> SuccessfulyHit;

		private Renderer _renderer;

		private bool _hasJustFired;

		private bool _isUsingCustomRaycast;

		private Vector3 _customRaycastOrigin;

		private Vector3 _customRaycastTarget;

		private float _fireWait;

		private bool _isGoingToFire;

		private bool _isFiringOnNextUpdate;

		private bool _isAllowed;

		private bool _wasAllowedAndFiring;

		private float _hitWait;

		private RaycastHit[] _hits = new RaycastHit[16];

		private Laser _laser;

		private bool _isIgnoringSelf = true;

		private bool _hasFireCondition;

		private int _fireConditionSide;

		private float _additionalError;

		private float _errorMultiplier = 1f;

		private bool _hasUpdatedThisFrame;

		private bool _hasManuallyUpdated;

		private IGunListener[] _listeners;

		public Vector3 Origin => (!(Aim == null)) ? Aim.transform.position : base.transform.position;

		public Vector3 Direction => (!(Aim == null)) ? Aim.transform.forward : base.transform.forward;

		public bool CanHit => _hitWait <= 0f;

		public bool HasJustFired => _hasJustFired;

		public bool IsAllowed => _isAllowed;

		public Renderer Renderer => _renderer;

		public Vector3 RaycastOrigin => (!_isUsingCustomRaycast) ? Origin : _customRaycastOrigin;

		public Vector3 RaycastTarget => (!_isUsingCustomRaycast) ? (Origin + Direction * Distance) : _customRaycastTarget;

		public bool HasRaycastSetup => _isUsingCustomRaycast;

		public abstract bool CanLoad
		{
			get;
		}

		public abstract int LoadedBulletsLeft
		{
			get;
		}

		public abstract bool IsFullyLoaded
		{
			get;
		}

		public abstract float LoadPercentage
		{
			get;
		}

		protected IGunListener[] Listeners => _listeners;

		public void ToUse()
		{
			TryFireNow();
		}

		public virtual void OnMagazineLoadStart()
		{
			if (MagazineLoadStarted != null)
			{
				MagazineLoadStarted();
			}
		}

		public virtual void OnBulletLoadStart()
		{
			if (BulletLoadStarted != null)
			{
				BulletLoadStarted();
			}
		}

		public virtual void OnPumpStart()
		{
			if (PumpStarted != null)
			{
				PumpStarted();
			}
		}

		public virtual void OnPumped()
		{
			if (Pumped != null)
			{
				Pumped();
			}
		}

		protected virtual void Start()
		{
			_laser = LaserOverwrite;
			if (_laser == null)
			{
				_laser = GetComponent<Laser>();
			}
			if (_laser == null)
			{
				_laser = GetComponentInChildren<Laser>();
			}
			if (_laser == null && base.transform.parent != null)
			{
				_laser = base.transform.parent.GetComponentInChildren<Laser>();
				if (_laser != null && _laser.GetComponent<BaseGun>() != null)
				{
					_laser = null;
				}
			}
		}

		private void OnValidate()
		{
			Distance = Mathf.Max(0f, Distance);
		}

		protected virtual void Awake()
		{
			_renderer = GetComponent<Renderer>();
			_listeners = Util.GetInterfaces<IGunListener>(base.gameObject);
		}

		private void LateUpdate()
		{
			if (!_hasManuallyUpdated)
			{
				_hasUpdatedThisFrame = true;
				Frame();
			}
			else
			{
				_hasUpdatedThisFrame = false;
				_hasManuallyUpdated = false;
			}
		}

		protected virtual void Frame()
		{
			_hasJustFired = false;
			if (_isGoingToFire)
			{
				_isFiringOnNextUpdate = true;
			}
			if (_hitWait >= 0f)
			{
				_hitWait -= Time.deltaTime;
			}
			if (DebugAim)
			{
				UnityEngine.Debug.DrawLine(Origin, Origin + (RaycastTarget - Origin).normalized * Distance, Color.red);
				if (_isUsingCustomRaycast)
				{
					UnityEngine.Debug.DrawLine(_customRaycastOrigin, _customRaycastTarget, Color.green);
				}
			}
			bool flag = _isGoingToFire && _isAllowed;
			if (Character != null)
			{
				if (flag && !_wasAllowedAndFiring)
				{
					Character.NotifyStartGunFire();
					if (FireStarted != null)
					{
						FireStarted();
					}
				}
				if (!flag && _wasAllowedAndFiring)
				{
					Character.NotifyStopGunFire();
					if (FireStopped != null)
					{
						FireStopped();
					}
				}
			}
			_wasAllowedAndFiring = flag;
			_fireWait -= Time.deltaTime;
			if (_isFiringOnNextUpdate && _isAllowed)
			{
				float num = 1f / Rate;
				float num2 = 0f;
				while (_fireWait < 0f)
				{
					bool flag2 = false;
					for (int i = 0; i < BulletsPerShot; i++)
					{
						if (LoadedBulletsLeft <= 0)
						{
							break;
						}
						if (fire(num2, !ConsumeSingleBulletPerShot))
						{
							flag2 = true;
						}
					}
					if (flag2 && ConsumeSingleBulletPerShot)
					{
						Consume();
					}
					if (flag2)
					{
						for (int j = 0; j < _listeners.Length; j++)
						{
							_listeners[j].OnFire(num2);
						}
						if (Fired != null)
						{
							Fired();
						}
						if (Character != null)
						{
							if (PumpAfterFire)
							{
								Character.InputPump(0.1f);
							}
							Character.InputRecoil(Recoil.Vertical, Recoil.Horizontal);
							ThirdPersonCamera.Shake(Character, Recoil.ShakeIntensity, Recoil.ShakeTime);
						}
					}
					else
					{
						for (int k = 0; k < _listeners.Length; k++)
						{
							_listeners[k].OnEmptyFire();
						}
						if (EmptyFire != null)
						{
							EmptyFire();
						}
					}
					num2 += num;
					_fireWait += num;
					_isGoingToFire = false;
				}
			}
			_isFiringOnNextUpdate = false;
			_isUsingCustomRaycast = false;
			if (_fireWait < 0f)
			{
				_fireWait = 0f;
			}
			if (_laser != null && Character != null)
			{
				_laser.Alpha = (Character.IsZooming ? 1 : 0);
			}
			adjustLaser();
			_additionalError = 0f;
			_errorMultiplier = 1f;
		}

		public void NotifyRechamber()
		{
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnRechamber();
			}
		}

		public void NotifyEject()
		{
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnEject();
			}
		}

		public void NotifyPumpStart()
		{
			OnPumpStart();
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnPumpStart();
			}
		}

		public void NotifyPump()
		{
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnPump();
			}
		}

		public void NotifyMagazineLoadStart()
		{
			OnMagazineLoadStart();
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnMagazineLoadStart();
			}
		}

		public void NotifyBulletLoadStart()
		{
			OnBulletLoadStart();
			for (int i = 0; i < _listeners.Length; i++)
			{
				_listeners[i].OnBulletLoadStart();
			}
		}

		public void IgnoreSelf(bool value = true)
		{
			_isIgnoringSelf = value;
		}

		public void SetFireCondition(int side)
		{
			_hasFireCondition = true;
			_fireConditionSide = side;
		}

		public void CancelFireCondition()
		{
			_hasFireCondition = false;
		}

		public GameObject FindCurrentAimedTarget()
		{
			RaycastHit raycastHit = Raycast();
			if (raycastHit.collider != null)
			{
				return raycastHit.collider.gameObject;
			}
			return null;
		}

		public GameObject FindCurrentAimedHealthTarget()
		{
			return getHealthTarget(FindCurrentAimedTarget());
		}

		public abstract bool LoadMagazine();

		public abstract bool LoadBullet();

		public RaycastHit Raycast()
		{
			bool isFriend;
			return Raycast(RaycastOrigin, (RaycastTarget - RaycastOrigin).normalized, out isFriend, friendCheck: false);
		}

		public RaycastHit Raycast(Vector3 origin, Vector3 direction, out bool isFriend, bool friendCheck)
		{
			RaycastHit result = default(RaycastHit);
			float num = Distance * 10f;
			float num2 = 0f;
			if (_isUsingCustomRaycast)
			{
				num2 = Vector3.Distance(Origin, RaycastOrigin);
			}
			if (num2 > 0.5f)
			{
				num2 -= 0.5f;
			}
			isFriend = false;
			int num3 = Physics.RaycastNonAlloc(origin, direction, _hits, Distance);
			for (int i = 0; i < num3; i++)
			{
				RaycastHit raycastHit = _hits[i];
				if ((Character != null && Util.InHiearchyOf(raycastHit.collider.gameObject, Character.gameObject)) || !(raycastHit.distance < num) || !(raycastHit.distance > num2))
				{
					continue;
				}
				bool flag = true;
				bool flag2 = false;
				if (raycastHit.collider.isTrigger)
				{
					if (BodyPartHealth.Contains(raycastHit.collider.gameObject))
					{
						flag = true;
					}
					else
					{
						BulletShield bulletShield = BulletShield.Get(raycastHit.collider.gameObject);
						if (bulletShield != null)
						{
							if (Vector3.Dot(bulletShield.transform.forward, raycastHit.normal) >= -0.2f)
							{
								flag = true;
								flag2 = true;
							}
							else
							{
								flag = false;
							}
						}
						else
						{
							flag = false;
						}
					}
				}
				else
				{
					CharacterHealth characterHealth = CharacterHealth.Get(raycastHit.collider.gameObject);
					if (characterHealth != null)
					{
						flag = characterHealth.IsRegisteringHits;
					}
				}
				if (!flag)
				{
					continue;
				}
				if (!flag2 && (_isIgnoringSelf || _hasFireCondition) && friendCheck)
				{
					GameObject healthTarget = getHealthTarget(raycastHit.collider.gameObject);
					if (healthTarget != null)
					{
						if (_isIgnoringSelf && Character != null && healthTarget == Character.gameObject)
						{
							isFriend = true;
						}
						else if (_hasFireCondition)
						{
							Actor actor = Actors.Get(healthTarget);
							if (actor != null)
							{
								isFriend = (actor.Side == _fireConditionSide);
							}
							else
							{
								isFriend = false;
							}
						}
						else
						{
							isFriend = false;
						}
					}
					else
					{
						isFriend = false;
					}
				}
				result = raycastHit;
				num = raycastHit.distance;
			}
			return result;
		}

		public void TryFireNow()
		{
			_isFiringOnNextUpdate = true;
		}

		public void FireWhenReady()
		{
			_isGoingToFire = true;
		}

		public void CancelFire()
		{
			_isGoingToFire = false;
		}

		public void Allow(bool value)
		{
			_isAllowed = value;
		}

		public void SetupRaycastThisFrame(Vector3 origin, Vector3 target)
		{
			_isUsingCustomRaycast = true;
			_customRaycastOrigin = origin;
			_customRaycastTarget = target;
		}

		public void AddErrorThisFrame(float degrees)
		{
			_additionalError += degrees;
		}

		public void SetBaseErrorMultiplierThisFrame(float multiplier)
		{
			_errorMultiplier = multiplier;
		}

		public void UpdateManually()
		{
			_hasManuallyUpdated = true;
			if (!_hasUpdatedThisFrame)
			{
				Frame();
			}
		}

		protected abstract void Consume();

		private void adjustLaser()
		{
			if (_laser != null)
			{
				Vector3 origin = Origin;
				Vector3 direction = Direction;
				bool isFriend;
				RaycastHit raycastHit = Raycast(origin, direction, out isFriend, friendCheck: false);
				if (raycastHit.collider == null)
				{
					_laser.Setup(origin, origin + direction * Distance);
				}
				else
				{
					_laser.Setup(origin, raycastHit.point);
				}
			}
		}

		private GameObject getHealthTarget(GameObject target)
		{
			while (target != null)
			{
				CharacterHealth characterHealth = CharacterHealth.Get(target);
				if (characterHealth != null)
				{
					if (characterHealth.Health <= float.Epsilon)
					{
						target = null;
					}
					break;
				}
				Transform parent = target.transform.parent;
				target = ((!(parent != null)) ? null : parent.gameObject);
			}
			return target;
		}

		private Vector3 calculateRaycastDirection()
		{
			Vector3 normalized = (RaycastTarget - RaycastOrigin).normalized;
			float num = (_additionalError + Error * _errorMultiplier) * 0.5f;
			float num2 = UnityEngine.Random.Range(0f - num, num);
			float num3 = UnityEngine.Random.Range(0f - num, num);
			Vector3 vector = Vector3.up;
			if (normalized.y > 0.99f || normalized.y < -0.99f)
			{
				vector = Vector3.forward;
			}
			Vector3 axis = Vector3.Cross(vector, normalized);
			if (num > 0.1f && num2 * num2 + num3 * num3 >= num * num)
			{
				float num4 = Mathf.Sqrt(num2 * num2 + num3 * num3) * num;
				num2 /= num4;
				num3 /= num4;
				num2 *= UnityEngine.Random.Range(-1f, 1f);
				num3 *= UnityEngine.Random.Range(-1f, 1f);
			}
			return Quaternion.AngleAxis(num2, axis) * Quaternion.AngleAxis(num3, vector) * normalized;
		}

		private bool fire(float delay, bool consume)
		{
			Vector3 vector = calculateRaycastDirection();
			bool isFriend;
			RaycastHit raycastHit = Raycast(RaycastOrigin, vector, out isFriend, friendCheck: true);
			if (Character != null)
			{
				Character.KeepAiming();
			}
			if (!isFriend)
			{
				Vector3 vector2 = raycastHit.point;
				if (consume)
				{
					Consume();
				}
				if (raycastHit.collider == null)
				{
					vector2 = RaycastOrigin + Distance * vector;
				}
				float damage = Damage * ((!(Character != null)) ? 1f : Character.DamageMultiplier);
				HitType type;
				switch (Type)
				{
				case WeaponType.Pistol:
					type = HitType.Pistol;
					break;
				case WeaponType.Rifle:
					type = HitType.Rifle;
					break;
				case WeaponType.Shotgun:
					type = HitType.Shotgun;
					break;
				case WeaponType.Sniper:
					type = HitType.Sniper;
					break;
				default:
					type = HitType.Pistol;
					break;
				}
				Hit hit = new Hit(raycastHit.point, -vector, damage, Character.gameObject, (!(raycastHit.collider == null)) ? raycastHit.collider.gameObject : null, type, DamageResponseWaitTime);
				if (Bullet != null)
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(Bullet);
					gameObject.transform.position = Origin;
					gameObject.transform.LookAt(vector2);
					Projectile component = gameObject.GetComponent<Projectile>();
					Vector3 vector3 = vector2 - Origin;
					TrailRenderer trailRenderer = gameObject.GetComponent<TrailRenderer>();
					if (trailRenderer == null)
					{
						trailRenderer = gameObject.GetComponentInChildren<TrailRenderer>();
					}
					if (trailRenderer != null)
					{
						trailRenderer.Clear();
					}
					if (component != null)
					{
						component.Distance = vector3.magnitude;
						component.Direction = vector3.normalized;
						if (raycastHit.collider != null)
						{
							component.Target = raycastHit.collider.gameObject;
							component.Hit = hit;
						}
					}
					else if (raycastHit.collider != null)
					{
						raycastHit.collider.SendMessage("OnHit", hit, SendMessageOptions.DontRequireReceiver);
					}
					gameObject.SetActive(value: true);
				}
				else if (raycastHit.collider != null)
				{
					raycastHit.collider.SendMessage("OnHit", hit, SendMessageOptions.DontRequireReceiver);
				}
				_hasJustFired = true;
				return true;
			}
			_hasJustFired = true;
			return false;
		}
	}
}
