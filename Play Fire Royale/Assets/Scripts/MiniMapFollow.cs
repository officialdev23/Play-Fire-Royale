// DecompilerFi decompiler from Assembly-CSharp.dll class: MiniMapFollow
// SourcesPostProcessor 
using UnityEngine;

public class MiniMapFollow : MonoBehaviour
{
	private GameObject player;

	public bool RotateWithPlayer;

	public float MiniMapHeight;

	private Transform origParent;

	private Transform PlayerParent;

	private void Start()
	{
		player = GameObject.FindGameObjectWithTag("Player");
		Transform transform = base.transform;
		Vector3 position = player.transform.position;
		float x = position.x;
		float miniMapHeight = MiniMapHeight;
		Vector3 position2 = player.transform.position;
		transform.position = new Vector3(x, miniMapHeight, position2.z);
		origParent = base.transform.parent;
		PlayerParent = player.transform;
	}

	private void LateUpdate()
	{
		if (RotateWithPlayer)
		{
			base.transform.SetParent(PlayerParent);
			Transform transform = base.transform;
			Vector3 position = base.transform.position;
			float x = position.x;
			float miniMapHeight = MiniMapHeight;
			Vector3 position2 = base.transform.position;
			transform.position = new Vector3(x, miniMapHeight, position2.z);
		}
		else
		{
			base.transform.SetParent(origParent);
			Transform transform2 = base.transform;
			Vector3 position3 = player.transform.position;
			float x2 = position3.x;
			float miniMapHeight2 = MiniMapHeight;
			Vector3 position4 = player.transform.position;
			transform2.position = new Vector3(x2, miniMapHeight2, position4.z);
		}
	}
}
