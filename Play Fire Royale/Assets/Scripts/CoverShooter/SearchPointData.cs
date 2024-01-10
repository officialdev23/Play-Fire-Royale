// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SearchPointData
// SourcesPostProcessor 
using System.Collections.Generic;

namespace CoverShooter
{
	public class SearchPointData
	{
		public List<SearchPoint> Points;

		public SearchPointData()
		{
			Points = new List<SearchPoint>();
		}

		public void WriteTo(SearchPointData other)
		{
			other.Points.Clear();
			for (int i = 0; i < Points.Count; i++)
			{
				other.Points.Add(Points[i]);
			}
		}

		public void LinkLeft(int left, int middle)
		{
			SearchPoint value = Points[left];
			value.Right = middle;
			Points[left] = value;
			value = Points[middle];
			value.Left = left;
			Points[middle] = value;
		}

		public void LinkRight(int middle, int right)
		{
			SearchPoint value = Points[middle];
			value.Right = right;
			Points[middle] = value;
			value = Points[right];
			value.Left = middle;
			Points[right] = value;
		}

		public int Add(SearchPoint point)
		{
			Points.Add(point);
			return Points.Count - 1;
		}

		public void Clear()
		{
			Points.Clear();
		}
	}
}
