// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.BaseBuff
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public abstract class BaseBuff : MonoBehaviour
	{
		[Tooltip("Duration of the buff.")]
		public float Duration = 1f;

		[Tooltip("Should an outline be displayed during the buff.")]
		public bool Outline;

		[Tooltip("Color displayed on the outline.")]
		public Color OutlineColor = Color.white;

		[Tooltip("Should the buff be auto-launched on awake.")]
		public bool AutoLaunch;

		private CharacterOutline _outline;

		private bool _isRunning;

		private float _timer;

		protected virtual void Update()
		{
			if (_isRunning)
			{
				_timer -= Time.deltaTime;
				if (_timer <= float.Epsilon)
				{
					base.enabled = false;
				}
			}
		}

		public void Launch()
		{
			if (_isRunning)
			{
				return;
			}
			if (Outline)
			{
				if (_outline == null)
				{
					_outline = GetComponent<CharacterOutline>();
					if (_outline == null)
					{
						_outline = base.gameObject.AddComponent<CharacterOutline>();
						_outline.DisplayDefault = false;
					}
				}
				_outline.PushColor(this, OutlineColor);
			}
			Begin();
			_timer = Duration;
			_isRunning = true;
			base.enabled = true;
		}

		private void OnEnable()
		{
			if (AutoLaunch)
			{
				Launch();
			}
		}

		private void OnDisable()
		{
			if (_isRunning)
			{
				_isRunning = false;
				if (_outline != null)
				{
					_outline.PopColor(this);
				}
				End();
			}
		}

		protected abstract void Begin();

		protected abstract void End();
	}
}
