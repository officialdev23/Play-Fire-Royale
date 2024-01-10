// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.SearchBlockCache
// SourcesPostProcessor 
using System.Collections.Generic;

namespace CoverShooter
{
	public class SearchBlockCache
	{
		private List<SearchBlock> _cache = new List<SearchBlock>();

		private SearchPointData _points;

		public SearchBlockCache(SearchPointData points)
		{
			_points = points;
		}

		public void Give(SearchBlock block)
		{
			_cache.Add(block);
		}

		public SearchBlock Take()
		{
			if (_cache.Count == 0)
			{
				return new SearchBlock(_points);
			}
			SearchBlock result = _cache[_cache.Count - 1];
			_cache.RemoveAt(_cache.Count - 1);
			result.Clear();
			return result;
		}
	}
}
