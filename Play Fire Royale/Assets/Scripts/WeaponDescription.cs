// DecompilerFi decompiler from Assembly-CSharp.dll class: WeaponDescription
// SourcesPostProcessor 
using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace CoverShooter
{
	[Serializable]
	public struct WeaponDescription
	{
		[Tooltip("Link to the right hand weapon.")]
		[FormerlySerializedAs("Item")]
		public GameObject RightItem;

		[Tooltip("Link to the left hand weapon.")]
		public GameObject LeftItem;

		[Tooltip("Link to the holstered right hand weapon object which is made visible when the weapon is not used.")]
		[FormerlySerializedAs("Holster")]
		public GameObject RightHolster;

		[Tooltip("Link to the holstered left hand weapon object which is made visible when the weapon is not used.")]
		public GameObject LeftHolster;

		[Tooltip("Shield that is enabled when the weapon is equipped.")]
		public GameObject Shield;

		[Tooltip("Should the right and left weapons be swapped when mirroring.")]
		public bool PreferSwapping;

		[Tooltip("Should the character equip both hands if possible.")]
		public bool IsDualWielding;

		[Tooltip("Will the character be prevented from running, rolling, or jumping while the weapon is equipped.")]
		public bool IsHeavy;

		[Tooltip("Will the character be prevented from using covers while the weapon is equipped.")]
		public bool PreventCovers;

		[Tooltip("Will the character be prevented from climbing while the weapon is equipped.")]
		public bool PreventClimbing;

		[Tooltip("Is the character prevented from lowering arms when standing too close to a wall.")]
		public bool PreventArmLowering;

		[Tooltip("Is the character always aiming while the weapon is equipped.")]
		public WeaponAiming Aiming;

		private BaseGun _cachedGun;

		private BaseMelee _cachedRightMelee;

		private BaseMelee _cachedLeftMelee;

		private MonoBehaviour _cachedComponent;

		private Phone _cachedPhone;

		private Radio _cachedRadio;

		private Flashlight _cachedFlashlight;

		private Tool _cachedTool;

		private ToolType _cachedToolType;

		private GameObject _cacheItem;

		public bool IsNull => RightItem == null;

		public Flashlight Flashlight
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedFlashlight;
				}
				cache();
				return _cachedFlashlight;
			}
		}

		public BaseGun Gun
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedGun;
				}
				cache();
				return _cachedGun;
			}
		}

		public BaseMelee RightMelee
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedRightMelee;
				}
				cache();
				return _cachedRightMelee;
			}
		}

		public BaseMelee LeftMelee
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedLeftMelee;
				}
				cache();
				return _cachedLeftMelee;
			}
		}

		public bool HasMelee
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedRightMelee != null || _cachedLeftMelee != null;
				}
				cache();
				return _cachedRightMelee != null || _cachedLeftMelee != null;
			}
		}

		public Phone Phone
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedPhone;
				}
				cache();
				return _cachedPhone;
			}
		}

		public Radio Radio
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedRadio;
				}
				cache();
				return _cachedRadio;
			}
		}

		public ToolType ToolType
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedToolType;
				}
				cache();
				return _cachedToolType;
			}
		}

		public Tool Tool
		{
			get
			{
				if (_cacheItem == RightItem)
				{
					return _cachedTool;
				}
				cache();
				return _cachedTool;
			}
		}

		public T Component<T>() where T : MonoBehaviour
		{
			if (_cacheItem != RightItem)
			{
				cache();
			}
			if (RightItem == null)
			{
				return (T)null;
			}
			if (_cachedComponent == null || !(_cachedComponent is T))
			{
				_cachedComponent = RightItem.GetComponent<T>();
			}
			return _cachedComponent as T;
		}

		private void cache()
		{
			_cacheItem = RightItem;
			_cachedComponent = null;
			_cachedGun = ((!(RightItem == null)) ? RightItem.GetComponent<BaseGun>() : null);
			_cachedRightMelee = ((!(RightItem == null)) ? RightItem.GetComponent<BaseMelee>() : null);
			_cachedLeftMelee = ((!(LeftItem == null)) ? LeftItem.GetComponent<BaseMelee>() : null);
			_cachedTool = ((!(RightItem == null)) ? RightItem.GetComponent<Tool>() : null);
			_cachedPhone = ((!(RightItem == null)) ? RightItem.GetComponent<Phone>() : null);
			_cachedRadio = ((!(RightItem == null)) ? RightItem.GetComponent<Radio>() : null);
			_cachedFlashlight = ((!(RightItem == null)) ? RightItem.GetComponent<Flashlight>() : null);
			if (_cachedFlashlight == null && RightItem != null)
			{
				_cachedFlashlight = RightItem.GetComponentInChildren<Flashlight>();
			}
			if (_cachedPhone != null)
			{
				_cachedToolType = ToolType.phone;
			}
			else if (_cachedRadio != null)
			{
				_cachedToolType = ToolType.radio;
			}
			else if (_cachedFlashlight != null)
			{
				_cachedToolType = ToolType.flashlight;
			}
			else
			{
				_cachedToolType = ToolType.none;
			}
		}

		public bool IsTheSame(ref WeaponDescription other)
		{
			return other.RightItem == RightItem && other.RightHolster == RightHolster && other.Shield == Shield && other.LeftItem == LeftItem && other.LeftHolster == LeftHolster;
		}

		public static WeaponDescription Default()
		{
			WeaponDescription result = default(WeaponDescription);
			result.IsDualWielding = true;
			result.PreferSwapping = true;
			return result;
		}
	}
}
