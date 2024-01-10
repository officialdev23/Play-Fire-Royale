// DecompilerFi decompiler from Assembly-CSharp.dll class: PanWM
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;

public class PanWM : MonoBehaviour
{
	public Vector2 degrees = new Vector2(5f, 3f);

	private Vector2 shake = new Vector2(5f, 3f);

	public static float shake_value;

	public static float shake_speed = 10f;

	public float range = 1f;

	private float t;

	private Transform mTrans;

	private Quaternion mStart;

	private Vector2 mRot = Vector2.zero;

	private void Start()
	{
		mTrans = base.transform;
		mStart = mTrans.localRotation;
	}

	private void Update()
	{
		shake_value += (0f - shake_value) / 50f;
		t += shake_speed * Time.deltaTime;
		shake = new Vector2(Mathf.Sin(t * 5f) * shake_value, Mathf.Sin(t * 3f) * shake_value);
		float deltaTime = Time.deltaTime;
		Vector3 mousePosition = CF2Input.mousePosition;
		float num = (float)Screen.width * 0.5f;
		float num2 = (float)Screen.height * 0.5f;
		if (range < 0.1f)
		{
			range = 0.1f;
		}
		float x = Mathf.Clamp((mousePosition.x - num) / num / range, -1f, 1f);
		float y = Mathf.Clamp((mousePosition.y - num2) / num2 / range, -1f, 1f);
		mRot = Vector2.Lerp(mRot, new Vector2(x, y), deltaTime * 5f);
		mTrans.localRotation = mStart * Quaternion.Euler((0f - mRot.y) * degrees.y + shake.y, mRot.x * degrees.x + shake.x, 0f);
		Transform transform = base.transform;
		Vector3 eulerAngles = base.transform.eulerAngles;
		float x2 = eulerAngles.x;
		Vector3 eulerAngles2 = base.transform.eulerAngles;
		transform.eulerAngles = new Vector3(x2, eulerAngles2.y, 0f);
	}
}
