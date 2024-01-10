// DecompilerFi decompiler from Assembly-CSharp.dll class: demo_scene_control
// SourcesPostProcessor 
using UnityEngine;

public class demo_scene_control : MonoBehaviour
{
	public GameObject gr_explosion;

	public GameObject mass_gr_explosion;

	public GameObject d_gr_explosion;

	public GameObject short_gr_explosion;

	public GameObject space_explosion;

	public GameObject short_space_explosion;

	public GameObject circle_explosion;

	public GameObject nuke_explosion;

	public GameObject flash_explosion;

	public GameObject huge_explosion;

	public GameObject smoke_explosion;

	private Transform spawn;

	private Transform n_spawn;

	private Transform dir_spawn;

	private Transform space_spawn;

	private Transform mass_spawn;

	private Transform spawn_smoke;

	private void Start()
	{
		spawn = GameObject.Find("spawn").transform;
		dir_spawn = GameObject.Find("dir_spawn").transform;
		space_spawn = GameObject.Find("space_spawn").transform;
		mass_spawn = GameObject.Find("mass_spawn").transform;
		spawn_smoke = GameObject.Find("spawn_smoke").transform;
		n_spawn = GameObject.Find("spawn_nuke").transform;
	}

	private void Update()
	{
	}

	private void OnGUI()
	{
		if (GUI.Button(new Rect(20f, 20f, 200f, 20f), "Ground Explosion"))
		{
			Object.Instantiate(gr_explosion, spawn.position, spawn.rotation);
			PanWM.shake_value = 1f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 50f, 200f, 20f), "Flash Explosion"))
		{
			Object.Instantiate(flash_explosion, spawn.position, spawn.rotation);
			PanWM.shake_value = 1f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 80f, 200f, 20f), "Massive Ground Explosion"))
		{
			Object.Instantiate(mass_gr_explosion, mass_spawn.position, mass_spawn.rotation);
			PanWM.shake_value = 1.5f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 110f, 200f, 20f), "Directed Ground Explosion"))
		{
			Object.Instantiate(d_gr_explosion, dir_spawn.position, dir_spawn.rotation);
			PanWM.shake_value = 0.7f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 140f, 200f, 20f), "Ground Short Explosion"))
		{
			Object.Instantiate(short_gr_explosion, spawn.position, spawn.rotation);
			PanWM.shake_value = 0.7f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 170f, 200f, 20f), "Space (No Gravity) Explosion"))
		{
			Object.Instantiate(space_explosion, space_spawn.position, space_spawn.rotation);
			PanWM.shake_value = 1f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 200f, 200f, 20f), "Space Short Explosion"))
		{
			Object.Instantiate(short_space_explosion, space_spawn.position, space_spawn.rotation);
			PanWM.shake_value = 0.7f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 230f, 200f, 20f), "Circle Explosion"))
		{
			Object.Instantiate(circle_explosion, spawn.position, spawn.rotation);
			PanWM.shake_value = 0.5f;
			PanWM.shake_speed = 10f;
		}
		if (GUI.Button(new Rect(20f, 260f, 200f, 20f), "Huge Explosion"))
		{
			Object.Instantiate(huge_explosion, n_spawn.position, n_spawn.rotation);
			PanWM.shake_value = 2f;
			PanWM.shake_speed = 5f;
		}
		if (GUI.Button(new Rect(20f, 290f, 200f, 20f), "Smoke Explosion"))
		{
			Object.Instantiate(smoke_explosion, spawn_smoke.position, spawn_smoke.rotation);
			PanWM.shake_value = 2f;
			PanWM.shake_speed = 5f;
		}
		if (GUI.Button(new Rect(20f, 320f, 200f, 20f), "NUKE"))
		{
			Object.Instantiate(nuke_explosion, n_spawn.position, n_spawn.rotation);
			PanWM.shake_value = 2f;
			PanWM.shake_speed = 5f;
		}
	}
}
