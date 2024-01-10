// DecompilerFi decompiler from Assembly-CSharp.dll class: SearchBlock
// SourcesPostProcessor 
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public struct SearchBlock
	{
		public SearchPointData Data;

		public List<int> Indices;

		public List<int> InvestigatedIndices;

		public Vector3 Center;

		public Vector3 Sum;

		public int Index;

		public bool Empty => Indices.Count == 0;

		public int Count => Indices.Count;

		public SearchBlock(SearchPointData data)
		{
			Data = data;
			Indices = new List<int>();
			InvestigatedIndices = new List<int>();
			Center = Vector3.zero;
			Sum = Vector3.zero;
			Index = 0;
		}

		public void WriteTo(ref SearchBlock other)
		{
			other.Index = Index;
			other.Sum = Sum;
			other.Center = Center;
			other.Indices.Clear();
			other.InvestigatedIndices.Clear();
			for (int i = 0; i < Indices.Count; i++)
			{
				other.Indices.Add(Indices[i]);
			}
			for (int j = 0; j < InvestigatedIndices.Count; j++)
			{
				other.InvestigatedIndices.Add(InvestigatedIndices[j]);
			}
		}

		public void Investigate(int index)
		{
			InvestigatedIndices.Add(Indices[index]);
			Indices.RemoveAt(index);
		}

		public SearchPoint Get(int index)
		{
			return Data.Points[Indices[index]];
		}

		public void Add(int index)
		{
			Indices.Add(index);
			Vector3 sum = Sum;
			SearchPoint searchPoint = Data.Points[index];
			Sum = sum + searchPoint.Position;
			Center = Sum / Indices.Count;
		}

		public bool IsClose(SearchPoint point, float threshold, float middleThreshold)
		{
			if (Vector3.Distance(Center, point.Position) < threshold)
			{
				return true;
			}
			foreach (int index in Indices)
			{
				SearchPoint searchPoint = Data.Points[index];
				if (Vector3.Distance(searchPoint.Position, point.Position) < threshold)
				{
					return true;
				}
			}
			return false;
		}

		public void Clear()
		{
			Indices.Clear();
			InvestigatedIndices.Clear();
			Center = Vector3.zero;
			Sum = Vector3.zero;
		}
	}
}
