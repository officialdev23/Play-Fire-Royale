// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CharacterName
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class CharacterName : MonoBehaviour
	{
		public int user;

		public int nomeinimigo;

		public int modo;

		[Tooltip("Name of the character to be display in the UI.")]
		public string Name;

		private void Awake()
		{
			modo = PlayerPrefs.GetInt("modo");
		}

		private void Start()
		{
			if (modo == 0)
			{
				user = UnityEngine.Random.Range(101, 999);
				Name = "User" + user.ToString();
			}
			if (modo == 1)
			{
				user = UnityEngine.Random.Range(101, 999);
				Name = "Zombie" + user.ToString();
			}
		}
	}
}
