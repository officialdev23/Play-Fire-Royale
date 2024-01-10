// DecompilerFi decompiler from Assembly-CSharp.dll class: key_struct
// SourcesPostProcessor 
using UnityEngine;

public struct key_struct
{
	public int Index;

	public GameObject game_object;

	public string name_txt;

	public char character;

	public Vector3 Startpos;

	public key_struct(int index, GameObject go, string name, char ch)
	{
		Index = index;
		game_object = go;
		name_txt = name;
		character = ch;
		Startpos = Vector3.zero;
	}
}
