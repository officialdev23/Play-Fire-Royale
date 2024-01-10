// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIFire
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(Actor))]
	public class AIFire : AIItemBase, ICharacterCoverListener
	{
		[Tooltip("Weapon type to look for, if not present any other weapon will be picked. Used only when AutoFindIndex is enabled.")]
		public WeaponType AutoFindType;

		[Tooltip("Should the AI always be aiming.")]
		public bool AlwaysAim;

		[Tooltip("Settings for bursts of fire when in a cover.")]
		public Bursts Bursts = Bursts.Default();

		[Tooltip("Settings for bursts of fire when in a cover.")]
		public CoverBursts CoverBursts = CoverBursts.Default();

		private Actor _actor;

		private CharacterMotor _motor;

		private bool _isFiring;

		private bool _isAiming;

		private float _fireCycle;

		private bool _isReloading;

		private bool _isFiringABurst;

		private int _burstBulletCount;

		private int _bulletCountAtStart;

		private BaseGun _gunBurstsWereCalculatedFor;

		private bool _isAimingAtAPosition;

		private Vector3 _aim;

		public bool IsFiring => _isFiring;

		public void OnEnterCover(Cover cover)
		{
			_fireCycle = 0f;
		}

		public void OnLeaveCover()
		{
			_fireCycle = 0f;
		}

		public void ToAimAt(Vector3 position)
		{
			_aim = position;
			_isAimingAtAPosition = true;
		}

		public void ToAimTo(Vector3 direction)
		{
			_isAimingAtAPosition = false;
		}

		public void ToTarget(ActorTarget target)
		{
			_aim = target.Position + target.RelativeStandingTopPosition;
			_isAimingAtAPosition = true;
		}

		public void ToOpenFire()
		{
			ToArm();
			_isFiring = true;
			_isAiming = true;
			_fireCycle = 0f;
		}

		public void ToCloseFire()
		{
			_isFiring = false;
		}

		public void ToStartAiming()
		{
			_isAiming = true;
		}

		public void ToStopAiming()
		{
			_isAiming = false;
			_isFiring = false;
		}

		public void ToArm()
		{
			Equip(_motor, AutoFindType);
		}

		public void ToDisarm()
		{
			UnequipWeapon(_motor);
			_isFiring = false;
			_isAiming = false;
		}

		protected override void Awake()
		{
			base.Awake();
			_actor = GetComponent<Actor>();
			_motor = GetComponent<CharacterMotor>();
		}

		private void Update()
		{
			if (!_actor.IsAlive)
			{
				return;
			}
			bool flag = AlwaysAim && _motor.Cover == null;
			if (flag)
			{
				EquipWeapon(_motor);
			}
			BaseGun gun = _motor.EquippedWeapon.Gun;
			if (gun == null)
			{
				return;
			}
			if (_isReloading)
			{
				_isReloading = !_motor.IsGunReady;
			}
			else if (gun != null && gun.LoadedBulletsLeft <= 0)
			{
				_isReloading = true;
				_motor.InputReload();
			}
			bool flag2 = false;
			if (_isFiring && _isAimingAtAPosition)
			{
				Vector3 a = base.transform.position;
				if (_motor.Cover != null && _motor.Cover.IsTall)
				{
					if (_motor.CoverDirection > 0 && _motor.IsNearRightCorner)
					{
						Cover cover = _motor.Cover;
						Vector3 position = base.transform.position;
						a = cover.RightCorner(position.y, _motor.CoverSettings.CornerOffset.x);
					}
					else if (_motor.CoverDirection < 0 && _motor.IsNearLeftCorner)
					{
						Cover cover2 = _motor.Cover;
						Vector3 position2 = base.transform.position;
						a = cover2.LeftCorner(position2.y, _motor.CoverSettings.CornerOffset.x);
					}
				}
				Vector3 vector = a + Vector3.up * 2f;
				float num = Vector3.Distance(vector, _aim);
				if (num > 1.5f)
				{
					flag2 = AIUtil.IsObstructed(vector, _aim);
				}
			}
			if (_motor.Cover == null && (_isAiming || flag) && !_isReloading)
			{
				_motor.InputAim();
			}
			if (_isFiring && !_isReloading && !flag2)
			{
				float num2 = (!(_motor.Cover != null)) ? Bursts.CycleDuration : CoverBursts.CycleDuration;
				if (_fireCycle >= num2)
				{
					if (_isFiringABurst)
					{
						_gunBurstsWereCalculatedFor = gun;
						_burstBulletCount = _bulletCountAtStart - gun.LoadedBulletsLeft;
					}
					_isFiringABurst = false;
					_fireCycle -= num2;
					if (_gunBurstsWereCalculatedFor == gun && gun.LoadedBulletsLeft < _burstBulletCount)
					{
						_isReloading = true;
						_motor.InputReload();
					}
				}
				if (_motor.Cover != null)
				{
					if (_fireCycle >= CoverBursts.Wait)
					{
						_motor.InputAim();
						if (_fireCycle >= CoverBursts.Wait + CoverBursts.IntroDuration && _fireCycle < CoverBursts.CycleDuration - CoverBursts.OutroDuration)
						{
							if (!_isFiringABurst)
							{
								_bulletCountAtStart = gun.LoadedBulletsLeft;
								_isFiringABurst = true;
							}
							if (_motor.IsGunReady)
							{
								_motor.InputFireOnCondition(_actor.Side);
							}
						}
					}
				}
				else
				{
					_motor.InputAim();
					if (_fireCycle >= Bursts.Wait)
					{
						if (!_isFiringABurst)
						{
							_bulletCountAtStart = gun.LoadedBulletsLeft;
							_isFiringABurst = true;
						}
						if (_motor.IsGunReady)
						{
							_motor.InputFireOnCondition(_actor.Side);
						}
					}
				}
				_fireCycle += Time.deltaTime;
			}
			else
			{
				_fireCycle = 0f;
				_isFiringABurst = false;
			}
		}
	}
}
