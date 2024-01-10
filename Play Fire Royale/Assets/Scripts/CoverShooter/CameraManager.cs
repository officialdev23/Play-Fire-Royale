// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CameraManager
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public static class CameraManager
	{
		private static Camera _camera;

		public static Camera Main
		{
			get
			{
				if (_camera == null)
				{
					_camera = Camera.main;
				}
				return _camera;
			}
			set
			{
				_camera = value;
			}
		}

		public static void Update()
		{
			_camera = Camera.main;
		}
	}
}
