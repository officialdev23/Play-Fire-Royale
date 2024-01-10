// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Flashlight
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Light))]
	public class Flashlight : Tool
	{
		private bool _isOn;

		private Light _light;

		public bool IsTurnedOn => _isOn || _light.enabled;

		private void Awake()
		{
			_light = GetComponent<Light>();
		}

		public override void ContinuousUse(CharacterMotor character, bool isAlternate)
		{
			_isOn = true;
		}

		private void Update()
		{
			_light.enabled = _isOn;
			_isOn = false;
		}
	}
}
