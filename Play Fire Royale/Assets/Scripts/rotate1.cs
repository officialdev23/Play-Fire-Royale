// DecompilerFi decompiler from Assembly-CSharp.dll class: rotate1
// SourcesPostProcessor 
using ControlFreak2;
using System;
using UnityEngine;

public class rotate1 : MonoBehaviour
{
	private float rotSpeed = 20f;

	private void OnMouseDrag()
	{
		float num = CF2Input.GetAxis("Mouse X") * rotSpeed * ((float)Math.PI / 180f);
		base.transform.RotateAround(Vector3.up, 0f - num);
	}
}
