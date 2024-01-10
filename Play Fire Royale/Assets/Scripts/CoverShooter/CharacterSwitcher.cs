// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterSwitcher
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

namespace CoverShooter
{
	public class CharacterSwitcher : MonoBehaviour
	{
		[Tooltip("Characters available for switching.")]
		public Actor[] Characters;

		[Tooltip("HUD that is assigned the current player.")]
		public ActorHUD HUD;

		[Tooltip("How long the character number should be held for the strategy input to activate.")]
		public float StrategyHold = 0.5f;

		[Tooltip("Index of the currently active character.")]
		public int Active;

		private int _active;

		private StrategyInput _strategy;

		private bool _wasPressingStrategy;

		private bool _hadStrategy;

		private AIFormation _previousFormation;

		private float[] _hold = new float[10];

		public Actor GetActive()
		{
			if (Active >= 0 && Active < Characters.Length)
			{
				return Characters[Active];
			}
			return null;
		}

		private void Awake()
		{
			_strategy = GetComponent<StrategyInput>();
			switchTo(Active);
		}

		private void Update()
		{
			int num = -1;
			for (int i = 0; i < _hold.Length; i++)
			{
				KeyCode keyCode = (KeyCode)(49 + i);
				if (i == 9)
				{
					keyCode = KeyCode.Alpha0;
				}
				if (CF2Input.GetKey(keyCode))
				{
					_hold[i] += Time.deltaTime;
					if (_hold[i] >= StrategyHold && _active != i)
					{
						num = i;
						if (_strategy != null && Characters != null && Characters.Length > i)
						{
							_strategy.Target = Characters[i];
						}
					}
				}
				if (CF2Input.GetKeyDown(keyCode))
				{
					_hold[i] = 0f;
				}
				if (CF2Input.GetKeyUp(keyCode) && _hold[i] < StrategyHold)
				{
					Active = i;
				}
			}
			if (_strategy != null && _wasPressingStrategy && _strategy.Target != null && num < 0)
			{
				_strategy.Target = null;
			}
			bool flag = _strategy != null && _strategy.Target != null;
			if (_hadStrategy && !flag)
			{
				switchTo(Active);
			}
			else if (flag && !_hadStrategy)
			{
				setCharacter(Active, controls: false, ai: false);
			}
			if (_strategy != null && _strategy.Target == null)
			{
				switchTo(Active);
			}
			_hadStrategy = flag;
			_wasPressingStrategy = (num >= 0);
		}

		private void setCharacter(int index, bool controls, bool ai)
		{
			if (Characters == null || Characters.Length <= index)
			{
				return;
			}
			Actor actor = Characters[index];
			if (actor == null)
			{
				return;
			}
			ThirdPersonInput component = actor.GetComponent<ThirdPersonInput>();
			TopDownInput component2 = actor.GetComponent<TopDownInput>();
			MobileController component3 = actor.GetComponent<MobileController>();
			ThirdPersonController component4 = actor.GetComponent<ThirdPersonController>();
			AIBase[] components = actor.GetComponents<AIBase>();
			if (Active >= 0 && Active < Characters.Length)
			{
				AIFormation component5 = Characters[Active].GetComponent<AIFormation>();
				if (component5 != null)
				{
					AIFormation component6 = actor.GetComponent<AIFormation>();
					if (component6 != null)
					{
						component6.Leader = component5;
					}
				}
			}
			AIBase[] array = components;
			foreach (AIBase aIBase in array)
			{
				if (aIBase is AIFormation)
				{
					aIBase.enabled = (ai || index == Active);
				}
				else
				{
					aIBase.enabled = ai;
				}
			}
			if (component != null)
			{
				component.enabled = controls;
			}
			if (component2 != null)
			{
				component2.enabled = controls;
			}
			if (component3 != null)
			{
				component3.enabled = controls;
			}
			if (component4 != null)
			{
				component4.enabled = controls;
			}
		}

		private void switchTo(int index)
		{
			if (Characters == null || Characters.Length <= index)
			{
				return;
			}
			for (int i = 0; i < Characters.Length; i++)
			{
				bool flag = i != index;
				if (!flag && Characters[i] != null)
				{
					AIActions component = Characters[i].GetComponent<AIActions>();
					if (component != null && component.IsPerforming)
					{
						flag = true;
					}
				}
				setCharacter(i, !flag, flag);
			}
			_active = index;
			Actor active = GetActive();
			if (active != null)
			{
				if (HUD != null)
				{
					HUD.Player = active;
				}
				AIFormation component2 = active.GetComponent<AIFormation>();
				if (component2 != null && _previousFormation != null)
				{
					component2.Formation = _previousFormation.Formation;
				}
				_previousFormation = component2;
			}
			TopDownCamera component3 = GetComponent<TopDownCamera>();
			StrategyCamera component4 = GetComponent<StrategyCamera>();
			ThirdPersonCamera component5 = GetComponent<ThirdPersonCamera>();
			MobileCamera component6 = GetComponent<MobileCamera>();
			CharacterMotor component7 = Characters[index].GetComponent<CharacterMotor>();
			if (component3 != null)
			{
				component3.Target = component7;
			}
			if (component4 != null)
			{
				component4.Target = component7;
			}
			if (component5 != null)
			{
				component5.Target = component7;
			}
			if (component6 != null)
			{
				component6.Target = component7;
			}
		}
	}
}
