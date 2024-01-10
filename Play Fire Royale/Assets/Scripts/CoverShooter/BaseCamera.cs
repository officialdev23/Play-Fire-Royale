// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseCamera
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(Camera))]
	public class BaseCamera : CharacterCamera
	{
		[Tooltip("Target character motor.")]
		public CharacterMotor Target;

		public Action TargetChanged;

		private CharacterMotor _cachedTarget;

		private MonoBehaviour _targetComponent;

		public T TargetComponent<T>() where T : MonoBehaviour
		{
			if (_cachedTarget != Target)
			{
				updateTarget();
			}
			if (Target == null)
			{
				return (T)null;
			}
			if (_targetComponent == null || !(_targetComponent is T))
			{
				_targetComponent = ((!(Target != null)) ? ((T)null) : Target.GetComponent<T>());
			}
			return _targetComponent as T;
		}

		protected virtual void Update()
		{
			if (Target != _cachedTarget)
			{
				updateTarget();
			}
		}

		private void updateTarget()
		{
			_cachedTarget = Target;
			_targetComponent = null;
			SendMessage("OnTargetChange", SendMessageOptions.DontRequireReceiver);
			if (TargetChanged != null)
			{
				TargetChanged();
			}
		}

		public override void DeferUpdate(ICharacterController controller)
		{
		}

		public override void UpdateForCharacterMotor()
		{
		}
	}
}
