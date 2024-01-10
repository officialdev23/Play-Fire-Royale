// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SearchZone
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	[RequireComponent(typeof(BoxCollider))]
	public class SearchZone : Zone<SearchZone>
	{
		public IEnumerable<Vector3> Points(float threshold)
		{
			float width = base.Width / threshold;
			float depth = base.Depth / threshold;
			int wcount = (width <= 0.5f) ? 1 : ((int)(width + 0.5f) + 1);
			int dcount = (depth <= 0.5f) ? 1 : ((int)(depth + 0.5f) + 1);
			Vector3 position = default(Vector3);
			position.y = (0f - base.Height) * 0.5f;
			float w = base.Width * 0.5f;
			float d = base.Depth * 0.5f;
			float xstep = base.Width / (float)(wcount - 1);
			float zstep = base.Depth / (float)(dcount - 1);
			for (int x = 0; x < wcount; x++)
			{
				if (wcount == 0)
				{
					position.x = w;
				}
				else
				{
					position.x = (float)x * xstep - w;
				}
				for (int z = 0; z < dcount; z++)
				{
					if (dcount == 0)
					{
						position.z = d;
					}
					else
					{
						position.z = (float)z * zstep - d;
					}
					yield return base.transform.TransformPoint(position);
				}
			}
		}
	}
}
