// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.ParticleCameraMotionBlur
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(ParticleSystem))]
	public class ParticleCameraMotionBlur : MonoBehaviour
	{
		private void OnEnable()
		{
			ParticleSystemRenderer component = GetComponent<ParticleSystemRenderer>();
			component.motionVectorGenerationMode = MotionVectorGenerationMode.Camera;
		}
	}
}
