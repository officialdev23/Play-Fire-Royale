// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.LayerManager
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class LayerManager : MonoBehaviour
	{
		public int Geometry = Layers.Geometry;

		public int Cover = Layers.Cover;

		public int Scope = Layers.Scope;

		public int Character = Layers.Character;

		public int Zones = Layers.Zones;

		private void Awake()
		{
			SetValues();
		}

		public void SetValues()
		{
			Layers.Geometry = Geometry;
			Layers.Cover = Cover;
			Layers.Scope = Scope;
			Layers.Character = Character;
			Layers.Zones = Zones;
		}
	}
}
