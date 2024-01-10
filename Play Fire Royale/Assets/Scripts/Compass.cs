// DecompilerFi decompiler from Assembly-CSharp.dll class: Compass
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class Compass : MonoBehaviour
{
	public RawImage CompassImage;

	public Transform Player;

	public Text CompassDirectionText;

	public void Update()
	{
		RawImage compassImage = CompassImage;
		Vector3 localEulerAngles = Player.localEulerAngles;
		compassImage.uvRect = new Rect(localEulerAngles.y / 360f, 0f, 1f, 1f);
		Vector3 forward = Player.transform.forward;
		forward.y = 0f;
		Vector3 eulerAngles = Quaternion.LookRotation(forward).eulerAngles;
		float y = eulerAngles.y;
		y = 5 * Mathf.RoundToInt(y / 5f);
		switch (Mathf.RoundToInt(y))
		{
		case 0:
			CompassDirectionText.text = "N";
			break;
		case 360:
			CompassDirectionText.text = "N";
			break;
		case 45:
			CompassDirectionText.text = "NE";
			break;
		case 90:
			CompassDirectionText.text = "E";
			break;
		case 130:
			CompassDirectionText.text = "SE";
			break;
		case 180:
			CompassDirectionText.text = "S";
			break;
		case 225:
			CompassDirectionText.text = "SW";
			break;
		case 270:
			CompassDirectionText.text = "W";
			break;
		default:
			CompassDirectionText.text = y.ToString();
			break;
		}
	}
}
