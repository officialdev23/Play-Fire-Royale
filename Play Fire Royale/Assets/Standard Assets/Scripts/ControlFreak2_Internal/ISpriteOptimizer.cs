// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.Internal.ISpriteOptimizer
// SourcesPostProcessor 
using UnityEngine;

namespace ControlFreak2.Internal
{
	public interface ISpriteOptimizer
	{
		Sprite GetOptimizedSprite(Sprite oldSprite);

		void AddSprite(Sprite sprite);
	}
}
