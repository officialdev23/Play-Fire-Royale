// DecompilerFi decompiler from Assembly-CSharp.dll class: D
// SourcesPostProcessor 
#define UNITY_EDITOR
using System;
using System.Diagnostics;
using UnityEngine;

public class D
{
	private static int cnt;

	[Conditional("DEBUG_LEVEL_LOG")]
	[Conditional("DEBUG_LEVEL_WARN")]
	[Conditional("DEBUG_LEVEL_ERROR")]
	public static void log(string format, params object[] paramList)
	{
		UnityEngine.Debug.Log(string.Format(format, paramList));
	}

	[Conditional("DEBUG_LEVEL_LOG")]
	[Conditional("DEBUG_LEVEL_WARN")]
	[Conditional("DEBUG_LEVEL_ERROR")]
	public static void logx(string format, params object[] paramList)
	{
		string text = cnt + " " + string.Format(format, paramList);
		if (Application.isEditor)
		{
			UnityEngine.Debug.Log(text);
		}
		else
		{
			Console.WriteLine(text);
		}
		cnt++;
	}

	[Conditional("DEBUG_LEVEL_LOG")]
	[Conditional("DEBUG_LEVEL_WARN")]
	[Conditional("DEBUG_LEVEL_ERROR")]
	public static void logxx(string format, params object[] paramList)
	{
		if (cnt % 60 == 0)
		{
			string message = cnt + " " + string.Format(format, paramList);
			UnityEngine.Debug.Log(message);
		}
		cnt++;
	}

	[Conditional("DEBUG_LEVEL_WARN")]
	[Conditional("DEBUG_LEVEL_ERROR")]
	public static void warn(string format, params object[] paramList)
	{
		UnityEngine.Debug.LogWarning(string.Format(format, paramList));
	}

	[Conditional("DEBUG_LEVEL_ERROR")]
	public static void error(string format, params object[] paramList)
	{
		UnityEngine.Debug.LogError(string.Format(format, paramList));
	}

	[Conditional("UNITY_EDITOR")]
	[Conditional("DEBUG_LEVEL_LOG")]
	public static void assert(bool condition)
	{
		assert(condition, string.Empty, pauseOnFail: true);
	}

	[Conditional("UNITY_EDITOR")]
	[Conditional("DEBUG_LEVEL_LOG")]
	public static void assert(bool condition, string assertString)
	{
		assert(condition, assertString, pauseOnFail: false);
	}

	[Conditional("UNITY_EDITOR")]
	[Conditional("DEBUG_LEVEL_LOG")]
	public static void assert(bool condition, string assertString, bool pauseOnFail)
	{
		if (!condition)
		{
			UnityEngine.Debug.LogError("assert failed! " + assertString);
			if (pauseOnFail)
			{
				UnityEngine.Debug.Break();
			}
		}
	}
}
