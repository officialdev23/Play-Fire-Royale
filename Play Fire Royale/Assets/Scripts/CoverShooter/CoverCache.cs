// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.CoverCache
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public class CoverCache
	{
		public List<CoverItem> Items = new List<CoverItem>();

		public void ResetDistance(Vector3 observer)
		{
			for (int i = 0; i < Items.Count; i++)
			{
				CoverItem value = Items[i];
				value.Distance = Vector3.Distance(observer, value.Position);
				Items[i] = value;
			}
			Items.Sort((CoverItem a, CoverItem b) => a.Distance.CompareTo(b.Distance));
		}

		public void Reset(Vector3 observer, float maxDistance, bool detailedPositions = true)
		{
			Items.Clear();
			int num = Physics.OverlapSphereNonAlloc(observer, maxDistance, Util.Colliders, Layers.Cover, QueryTriggerInteraction.Collide);
			for (int i = 0; i < num; i++)
			{
				Collider collider = Util.Colliders[i];
				if (!collider.isTrigger)
				{
					continue;
				}
				Cover cover = CoverSearch.GetCover(collider.gameObject);
				if (cover == null)
				{
					continue;
				}
				if (cover.IsTall && detailedPositions)
				{
					if (cover.OpenLeft)
					{
						consider(cover, cover.LeftCorner(0f, -0.3f), -1, observer, maxDistance);
					}
					if (cover.OpenRight)
					{
						consider(cover, cover.RightCorner(0f, -0.3f), 1, observer, maxDistance);
					}
				}
				else
				{
					consider(cover, cover.ClosestPointTo(observer, 0.3f, 0.3f), 0, observer, maxDistance);
				}
			}
			Items.Sort((CoverItem a, CoverItem b) => a.Distance.CompareTo(b.Distance));
		}

		private void consider(Cover cover, Vector3 position, int direction, Vector3 observer, float maxDistance)
		{
			if (float.IsNaN(position.x) || float.IsNaN(position.z))
			{
				return;
			}
			CoverItem item = default(CoverItem);
			item.Cover = cover;
			item.Position = position;
			item.Position.y = cover.Bottom;
			item.Distance = Vector3.Distance(observer, item.Position);
			item.Direction = direction;
			float num = Vector3.Distance(observer, item.Position);
			if (num > maxDistance)
			{
				return;
			}
			bool flag = false;
			if (cover.IsTall)
			{
				if (!AIUtil.IsCoverPositionFree(cover, item.Position, 3f, null))
				{
					flag = true;
				}
			}
			else
			{
				bool flag2 = false;
				Vector3 a = (!(Vector3.Dot((item.Position - observer).normalized, cover.Right) > 0f)) ? cover.Left : cover.Right;
				do
				{
					flag2 = false;
					if (!AIUtil.IsCoverPositionFree(cover, item.Position, 3f, null))
					{
						Vector3 vector = item.Position + a * 0.5f;
						if (cover.IsInFront(vector, isOld: false))
						{
							item.Position = vector;
							flag2 = true;
						}
						else
						{
							flag = true;
						}
					}
				}
				while (flag2);
			}
			if (!flag)
			{
				Items.Add(item);
			}
		}
	}
}
