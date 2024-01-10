// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Characters
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public static class Characters
	{
		public static Character MainPlayer;

		private static List<Character> _list = new List<Character>();

		private static Dictionary<GameObject, Character> _dictionary = new Dictionary<GameObject, Character>();

		public static IEnumerable<Character> AllAlive
		{
			get
			{
				foreach (Character item in _list)
				{
					Character character = item;
					if (character.IsValid && character.Motor.IsAlive)
					{
						yield return character;
					}
				}
			}
		}

		public static int Count => _list.Count;

		public static Character Get(int index)
		{
			return _list[index];
		}

		public static void Register(CharacterMotor motor)
		{
			if (motor == null)
			{
				return;
			}
			Character character = Build(motor);
			_dictionary[motor.gameObject] = character;
			if (MainPlayer.Object == null && ((bool)motor.GetComponent<ThirdPersonController>() || (bool)motor.GetComponent<MobileController>()))
			{
				MainPlayer = character;
			}
			bool flag = false;
			for (int i = 0; i < _list.Count; i++)
			{
				Character character2 = _list[i];
				if (character2.Motor == motor)
				{
					_list[i] = Build(motor);
					flag = true;
				}
			}
			if (!flag)
			{
				_list.Add(character);
			}
		}

		public static void Unregister(CharacterMotor motor)
		{
			if (motor != null && _dictionary.ContainsKey(motor.gameObject))
			{
				_dictionary.Remove(motor.gameObject);
			}
			int num = 0;
			while (true)
			{
				if (num < _list.Count)
				{
					Character character = _list[num];
					if (character.Motor == motor)
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			_list.RemoveAt(num);
		}

		public static Character Get(GameObject gameObject)
		{
			if (!_dictionary.ContainsKey(gameObject))
			{
				_dictionary[gameObject] = Build(gameObject.GetComponent<CharacterMotor>());
			}
			return _dictionary[gameObject];
		}

		public static Character Build(CharacterMotor motor)
		{
			Character result = default(Character);
			if (motor != null)
			{
				result.IsValid = true;
				result.Object = motor.gameObject;
				result.Motor = motor;
				result.Actor = motor.GetComponent<Actor>();
			}
			else
			{
				result.IsValid = false;
				result.Object = null;
				result.Motor = null;
				result.Actor = null;
			}
			return result;
		}
	}
}
