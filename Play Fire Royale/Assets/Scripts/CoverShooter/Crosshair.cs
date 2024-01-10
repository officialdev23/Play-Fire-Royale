// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Crosshair
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(ThirdPersonCamera))]
	public class Crosshair : MonoBehaviour
	{
		[Tooltip("Settings to use when aiming a weapon of a type not covered by other properties.")]
		public CrosshairSettings Default = CrosshairSettings.Default();

		[Tooltip("Settings to use when aiming a pistol.")]
		public CrosshairSettings Pistol = CrosshairSettings.Default();

		[Tooltip("Settings to use when aiming a rifle.")]
		public CrosshairSettings Rifle = CrosshairSettings.Default();

		[Tooltip("Settings to use when aiming a shotgun.")]
		public CrosshairSettings Shotgun = CrosshairSettings.Default();

		[Tooltip("Settings to use when aiming a sniper.")]
		public CrosshairSettings Sniper = CrosshairSettings.Default();

		private ThirdPersonCamera _thirdPersonCamera;

		private Camera _camera;

		private float _recoil;

		private float _fov;

		private CrosshairSettings _settings = CrosshairSettings.Default();

		private float _previousAlpha;

		private void Awake()
		{
			_thirdPersonCamera = GetComponent<ThirdPersonCamera>();
			_camera = GetComponent<Camera>();
		}

		private void OnGUI()
		{
			CrosshairSettings crosshairSettings = _settings;
			if (_thirdPersonCamera.Target != null)
			{
				WeaponDescription activeWeapon = _thirdPersonCamera.Target.ActiveWeapon;
				if (!_thirdPersonCamera.Target.IsChangingWeapon || _thirdPersonCamera.CrosshairAlpha > _previousAlpha)
				{
					crosshairSettings = ((activeWeapon.Gun != null && activeWeapon.Gun.UseCustomCrosshair) ? activeWeapon.Gun.CustomCrosshair : ((activeWeapon.Gun != null && activeWeapon.Gun.Type == WeaponType.Pistol) ? Pistol : ((!(activeWeapon.Gun != null) || activeWeapon.Gun.Type != WeaponType.Rifle) ? Default : Rifle)));
				}
			}
			else
			{
				crosshairSettings = Default;
			}
			_previousAlpha = _thirdPersonCamera.CrosshairAlpha;
			if (crosshairSettings.Sprites == null || crosshairSettings.Sprites.Length == 0)
			{
				return;
			}
			float num = _thirdPersonCamera.ShakeOffset * crosshairSettings.ShakeMultiplier;
			float num2 = Mathf.Abs(_thirdPersonCamera.VerticalRecoil);
			float num3 = Mathf.Abs(_thirdPersonCamera.HorizontalRecoil);
			float num4 = (!(num2 > num3)) ? num3 : num2;
			float recoil = Util.Lerp(_recoil, num4, 0.5f);
			num += Mathf.Max(0f, num4 - _recoil) * crosshairSettings.RecoilMultiplier;
			_recoil = recoil;
			if (_thirdPersonCamera.Target != null)
			{
				BaseGun gun = _thirdPersonCamera.Target.ActiveWeapon.Gun;
				if (gun != null)
				{
					num = ((!_thirdPersonCamera.Target.IsZooming) ? (num + gun.Error) : (num + gun.Error * _thirdPersonCamera.Target.ZoomErrorMultiplier));
				}
			}
			if (_thirdPersonCamera.Target != null)
			{
				num += _thirdPersonCamera.Target.MovementError;
			}
			Util.Lerp(ref _fov, num, crosshairSettings.Adaptation);
			if (!(_thirdPersonCamera.Target != null) || !_thirdPersonCamera.Target.IsScoping)
			{
				float num5 = (!(crosshairSettings.LowAngle < crosshairSettings.HighAngle)) ? 0f : Mathf.Clamp01((_fov - crosshairSettings.LowAngle) / (crosshairSettings.HighAngle - crosshairSettings.LowAngle));
				Sprite sprite = crosshairSettings.Sprites[(int)(num5 * (float)(crosshairSettings.Sprites.Length - 1))];
				if (!(sprite == null))
				{
					float num6 = Mathf.Lerp(crosshairSettings.LowAngle, crosshairSettings.HighAngle, num5);
					float num7 = crosshairSettings.Scale * (float)Screen.height * num6 / _camera.fieldOfView;
					Vector3 vector = new Vector3((float)Screen.width * 0.5f, (float)Screen.height * 0.5f, 0f);
					Texture2D texture = sprite.texture;
					Rect textureRect = sprite.textureRect;
					Vector2 textureRectOffset = sprite.textureRectOffset;
					Vector2 pivot = sprite.pivot;
					Rect texCoords = new Rect(textureRect.x / (float)texture.width, textureRect.y / (float)texture.height, textureRect.width / (float)texture.width, textureRect.height / (float)texture.height);
					float num8 = textureRect.width / textureRect.height;
					Vector2 vector2 = default(Vector2);
					vector2.x = (pivot.x - textureRectOffset.x) / textureRect.width;
					vector2.y = (textureRect.height - pivot.y + textureRectOffset.y) / textureRect.height;
					Rect position = new Rect(vector.x - num7 * vector2.x * num8, vector.y - num7 * vector2.y, num7 * num8, num7);
					Color color = GUI.color;
					GUI.color = new Color(1f, 1f, 1f, _thirdPersonCamera.CrosshairAlpha);
					GUI.DrawTextureWithTexCoords(position, texture, texCoords, alphaBlend: true);
					GUI.color = color;
				}
			}
		}
	}
}
