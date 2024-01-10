// DecompilerFi decompiler from Assembly-CSharp.dll class: GlobalSearchCache
// SourcesPostProcessor 
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct GlobalSearchCache
	{
		public static List<SearchBlock> GeneratedBlocks = new List<SearchBlock>();

		public static SearchPointData GeneratedPoints = new SearchPointData();

		private static List<SearchBlock> _blocks = new List<SearchBlock>();

		private static SearchPointData _points = new SearchPointData();

		private static CoverCache _coverCache = new CoverCache();

		private static SearchZoneCache _zoneCache = new SearchZoneCache();

		private static SearchBlockCache _blockCache = new SearchBlockCache(_points);

		private static HashSet<Cover> _usedCovers = new HashSet<Cover>();

		private static bool _isGenerating;

		private static int _currentMergedGeneratedBlockId;

		private static float _currentTime = -1000f;

		private static float _timeAtGenerationStart = -1000f;

		private static bool _hasJustRestarted;

		public static void Restart()
		{
			if (!_hasJustRestarted)
			{
				_hasJustRestarted = true;
				Rebuild();
			}
		}

		public static void Update()
		{
			if (!(Time.timeSinceLevelLoad - _currentTime < 0.0166666675f))
			{
				_currentTime = Time.timeSinceLevelLoad;
				_hasJustRestarted = false;
				if (_isGenerating)
				{
					mergeBlocks();
				}
				else if (_currentTime > _timeAtGenerationStart + 300f)
				{
					Rebuild();
				}
			}
		}

		public static void Rebuild()
		{
			_isGenerating = true;
			_currentMergedGeneratedBlockId = 0;
			_timeAtGenerationStart = Time.timeSinceLevelLoad;
			for (int i = 0; i < _blocks.Count; i++)
			{
				_blockCache.Give(_blocks[i]);
			}
			_blocks.Clear();
			_usedCovers.Clear();
			_points.Clear();
			_coverCache.Items.Clear();
			_coverCache.Reset(Vector3.zero, 1000f, detailedPositions: false);
			for (int j = 0; j < _coverCache.Items.Count; j++)
			{
				CoverItem coverItem = _coverCache.Items[j];
				if (_usedCovers.Contains(coverItem.Cover))
				{
					continue;
				}
				Cover cover = coverItem.Cover;
				Cover cover2 = coverItem.Cover;
				while (cover.LeftAdjacent != null && !_usedCovers.Contains(cover.LeftAdjacent) && !(cover.LeftAdjacent == cover2))
				{
					cover = cover.LeftAdjacent;
				}
				int index = -1;
				while (cover != null)
				{
					_usedCovers.Add(cover);
					Vector3 vector = cover.LeftCorner(cover.Bottom) - cover.Forward * 0.25f;
					Vector3 vector2 = cover.RightCorner(cover.Bottom) - cover.Forward * 0.25f;
					Vector3 a = vector2 - vector;
					float magnitude = a.magnitude;
					Vector3 vector3 = vector;
					Vector3 vector4 = vector2;
					Vector3 vector5 = vector + cover.Left * AISearch.CoverOffset;
                    NavMeshHit _;

                    vector3 = ((!NavMesh.Raycast(vector, vector5, out  _, 1)) ? vector5 : vector);
					Vector3 vector6 = vector2 + cover.Right * AISearch.CoverOffset;

					vector4 = ((!NavMesh.Raycast(vector2, vector6, out  _, 1)) ? vector6 : vector2);
					if (cover.LeftAdjacent != null && cover.RightAdjacent != null)
					{
						vector3 = vector;
						vector4 = vector2;
					}
					else if (cover.LeftAdjacent != null)
					{
						vector3 = vector4;
					}
					else if (cover.RightAdjacent != null)
					{
						vector4 = vector3;
					}
					possiblyAddRightPoint(ref index, new SearchPoint(vector, vector3, -cover.Forward, requiresReaching: false));
					if (magnitude > AISearch.BlockThreshold * 2f)
					{
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.2f, vector3, -cover.Forward, requiresReaching: false));
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.4f, vector3, -cover.Forward, requiresReaching: false));
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.6f, vector4, -cover.Forward, requiresReaching: false));
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.8f, vector4, -cover.Forward, requiresReaching: false));
					}
					else if (magnitude > AISearch.BlockThreshold)
					{
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.33f, vector3, -cover.Forward, requiresReaching: false));
						possiblyAddRightPoint(ref index, new SearchPoint(vector + a * 0.66f, vector4, -cover.Forward, requiresReaching: false));
					}
					possiblyAddRightPoint(ref index, new SearchPoint(vector2, vector4, -cover.Forward, requiresReaching: false));
					cover = ((!(cover.RightAdjacent != null) || _usedCovers.Contains(cover.RightAdjacent)) ? null : cover.RightAdjacent);
				}
			}
			_zoneCache.Reset(Vector3.zero, 1000f);
			for (int k = 0; k < _zoneCache.Items.Count; k++)
			{
				SearchZone searchZone = _zoneCache.Items[k];
				foreach (Vector3 item in searchZone.Points(AISearch.BlockThreshold))
				{
					addPoint(new SearchPoint(item, requiresReaching: false));
				}
			}
		}

		private static void possiblyAddRightPoint(ref int index, SearchPoint point)
		{
            NavMeshHit hit;

            if (NavMesh.SamplePosition(point.Position, out  hit, 0.2f, 1))
			{
				point.Position = hit.position;
				int num = addPoint(point);
				if (index >= 0)
				{
					_points.LinkRight(index, num);
				}
				index = num;
			}
		}

		private static int addPoint(SearchPoint point)
		{
			point.CalcVisibility(AISearch.VerifyDistance, isAlerted: false);
			int num = _points.Add(point);
			for (int i = 0; i < _blocks.Count; i++)
			{
				if (_blocks[i].IsClose(point, AISearch.BlockThreshold, AISearch.BlockCenterThreshold))
				{
					_blocks[i].Add(num);
					return num;
				}
			}
			SearchBlock item = _blockCache.Take();
			item.Add(num);
			_blocks.Add(item);
			return num;
		}

		private static void mergeBlocks()
		{
			int num = 0;
			for (int i = _currentMergedGeneratedBlockId; i < _blocks.Count - 1; i++)
			{
				while (num <= 0)
				{
					num++;
					int num2;
					for (num2 = _blocks.Count - 1; num2 > i; num2--)
					{
						int num3 = 0;
						while (true)
						{
							int num4 = num3;
							SearchBlock searchBlock = _blocks[i];
							if (num4 < searchBlock.Indices.Count)
							{
								SearchBlock searchBlock2 = _blocks[i];
								int index = searchBlock2.Indices[num3];
								if (_blocks[num2].IsClose(_points.Points[index], AISearch.BlockThreshold, AISearch.BlockCenterThreshold))
								{
									goto IL_00b9;
								}
								num3++;
								continue;
							}
							break;
						}
					}
					goto IL_0146;
					IL_00b9:
					int num5 = 0;
					while (true)
					{
						int num6 = num5;
						SearchBlock searchBlock3 = _blocks[num2];
						if (num6 >= searchBlock3.Indices.Count)
						{
							break;
						}
						SearchBlock searchBlock4 = _blocks[i];
						SearchBlock searchBlock5 = _blocks[num2];
						searchBlock4.Add(searchBlock5.Indices[num5]);
						num5++;
					}
					_blockCache.Give(_blocks[num2]);
					_blocks.RemoveAt(num2);
				}
				_currentMergedGeneratedBlockId = i;
				break;
				IL_0146:;
			}
			for (int j = 0; j < _blocks.Count; j++)
			{
				SearchBlock value = _blocks[j];
				value.Index = j;
				_blocks[j] = value;
			}
			GeneratedPoints.Clear();
			_points.WriteTo(GeneratedPoints);
			for (int k = 0; k < _blocks.Count; k++)
			{
				SearchBlock other = _blockCache.Take();
				_blocks[k].WriteTo(ref other);
				GeneratedBlocks.Add(other);
			}
			_isGenerating = false;
		}
	}
}
