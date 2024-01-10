// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterFace
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CharacterFace : MonoBehaviour, ICharacterGunListener, ICharacterZoomListener, ICharacterHealthListener
	{
		[Tooltip("Link to an object with a SkinnedMeshRenderer to apply faces to.")]
		public GameObject Mesh;

		[Tooltip("Default character face.")]
		public FaceSettings Default;

		[Tooltip("Face settings when the character is zooming but not firing.")]
		public FaceSettings Zoom;

		[Tooltip("Face settings when a gun trigger is pressed.")]
		public FaceSettings Fire;

		[Tooltip("Face settings when the character is dead.")]
		public FaceSettings Dead;

		private FaceSettings _face;

		private FaceSettings _interpolatedFace;

		private bool _isFiring;

		private bool _isZoomed;

		private bool _isAlive = true;

		public void OnStartGunFire()
		{
			_isFiring = true;
		}

		public void OnStopGunFire()
		{
			_isFiring = false;
		}

		public void OnZoom()
		{
			_isZoomed = true;
		}

		public void OnUnzoom()
		{
			_isZoomed = false;
		}

		public void OnScope()
		{
		}

		public void OnUnscope()
		{
		}

		public void OnDead()
		{
			_isAlive = false;
		}

		public void OnResurrect()
		{
			_isAlive = true;
		}

		private void Update()
		{
			if (!_isAlive)
			{
				_face = Dead;
			}
			else if (_isFiring)
			{
				_face = Fire;
			}
			else if (_isZoomed)
			{
				_face = Zoom;
			}
			else
			{
				_face = Default;
			}
			int num = 8;
			Util.Lerp(ref _interpolatedFace.A, _face.A, num);
			Util.Lerp(ref _interpolatedFace.Angry, _face.Angry, num);
			Util.Lerp(ref _interpolatedFace.CloseEyes, _face.CloseEyes, num);
			Util.Lerp(ref _interpolatedFace.E, _face.E, num);
			Util.Lerp(ref _interpolatedFace.M, _face.M, num);
			Util.Lerp(ref _interpolatedFace.Aim, _face.Aim, num);
			Util.Lerp(ref _interpolatedFace.AngryMouth, _face.AngryMouth, num);
			Util.Lerp(ref _interpolatedFace.Happy, _face.Happy, num);
			Util.Lerp(ref _interpolatedFace.HappyEyes, _face.HappyEyes, num);
			Util.Lerp(ref _interpolatedFace.O, _face.O, num);
			if (!(Mesh == null))
			{
				SkinnedMeshRenderer component = Mesh.GetComponent<SkinnedMeshRenderer>();
				if (!(component == null))
				{
					component.SetBlendShapeWeight(0, _interpolatedFace.A);
					component.SetBlendShapeWeight(1, _interpolatedFace.Angry);
					component.SetBlendShapeWeight(2, _interpolatedFace.CloseEyes);
					component.SetBlendShapeWeight(3, _interpolatedFace.E);
					component.SetBlendShapeWeight(4, _interpolatedFace.M);
					component.SetBlendShapeWeight(5, _interpolatedFace.Aim);
					component.SetBlendShapeWeight(6, _interpolatedFace.AngryMouth);
					component.SetBlendShapeWeight(7, _interpolatedFace.Happy);
					component.SetBlendShapeWeight(8, _interpolatedFace.HappyEyes);
					component.SetBlendShapeWeight(9, _interpolatedFace.O);
				}
			}
		}
	}
}
