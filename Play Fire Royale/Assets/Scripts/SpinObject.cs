// DecompilerFi decompiler from Assembly-CSharp.dll class: SpinObject
// SourcesPostProcessor 
using UnityEngine;

public class SpinObject : MonoBehaviour
{
	public Vector3 SpinSpeed;

	private float _timeAtLastFrame;

	private float _timeAtCurrentFrame;

	private float deltaTime;

	private void Update()
	{
		_timeAtCurrentFrame = Time.realtimeSinceStartup;
		deltaTime = _timeAtCurrentFrame - _timeAtLastFrame;
		_timeAtLastFrame = _timeAtCurrentFrame;
		base.transform.Rotate(SpinSpeed * deltaTime, Space.Self);
	}
}
