// DecompilerFi decompiler from Assembly-CSharp.dll class: CFX3_Demo
// SourcesPostProcessor 
using ControlFreak2;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;

public class CFX3_Demo : MonoBehaviour
{
	public bool orderedSpawns = true;

	public float step = 1f;

	public float range = 5f;

	private float order = -5f;

	public Renderer groundRenderer;

	public Collider groundCollider;

	private GameObject[] ParticleExamples;

	private int exampleIndex;

	private string randomSpawnsDelay = "0.5";

	private bool randomSpawns;

	private bool slowMo;

	private List<GameObject> onScreenParticles = new List<GameObject>();

	private void Awake()
	{
		List<GameObject> list = new List<GameObject>();
		int childCount = base.transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			GameObject gameObject = base.transform.GetChild(i).gameObject;
			list.Add(gameObject);
		}
		ParticleExamples = list.ToArray();
		StartCoroutine("CheckForDeletedParticles");
	}

	private void Update()
	{
		if (CF2Input.GetKeyDown(KeyCode.LeftArrow))
		{
			prevParticle();
		}
		else if (CF2Input.GetKeyDown(KeyCode.RightArrow))
		{
			nextParticle();
		}
		else if (CF2Input.GetKeyDown(KeyCode.Delete))
		{
			destroyParticles();
		}
		if (CF2Input.GetMouseButtonDown(0) || CF2Input.GetMouseButtonDown(1) || CF2Input.GetMouseButtonDown(2))
		{
			RaycastHit hitInfo = default(RaycastHit);
			if (groundCollider.Raycast(Camera.main.ScreenPointToRay(CF2Input.mousePosition), out hitInfo, 9999f))
			{
				GameObject gameObject = spawnParticle();
				gameObject.transform.position = hitInfo.point + gameObject.transform.position;
			}
		}
	}

	private void OnGUI()
	{
		GUILayout.BeginArea(new Rect(5f, 20f, Screen.width - 10, 60f));
		GUILayout.BeginHorizontal();
		GUILayout.Label("Effect", GUILayout.Width(50f));
		if (GUILayout.Button("<", GUILayout.Width(25f)))
		{
			prevParticle();
		}
		GUILayout.Label(ParticleExamples[exampleIndex].name, GUILayout.Width(265f));
		if (GUILayout.Button(">", GUILayout.Width(25f)))
		{
			nextParticle();
		}
		GUILayout.Space(80f);
		if (GUILayout.Button((!CFX_Demo_RotateCamera.rotating) ? "Rotate Camera" : "Pause Camera"))
		{
			CFX_Demo_RotateCamera.rotating = !CFX_Demo_RotateCamera.rotating;
		}
		if (GUILayout.Button((!randomSpawns) ? "Start UnityEngine.Random Spawns" : "Stop UnityEngine.Random Spawns", GUILayout.Width(140f)))
		{
			randomSpawns = !randomSpawns;
			if (randomSpawns)
			{
				StartCoroutine("RandomSpawnsCoroutine");
			}
			else
			{
				StopCoroutine("RandomSpawnsCoroutine");
			}
		}
		randomSpawnsDelay = GUILayout.TextField(randomSpawnsDelay, 10, GUILayout.Width(42f));
		randomSpawnsDelay = Regex.Replace(randomSpawnsDelay, "[^0-9.]", string.Empty);
		if (GUILayout.Button((!groundRenderer.enabled) ? "Show Ground" : "Hide Ground", GUILayout.Width(90f)))
		{
			groundRenderer.enabled = !groundRenderer.enabled;
		}
		if (GUILayout.Button((!slowMo) ? "Slow Motion" : "Normal Speed", GUILayout.Width(100f)))
		{
			slowMo = !slowMo;
			if (slowMo)
			{
				Time.timeScale = 0.33f;
			}
			else
			{
				Time.timeScale = 1f;
			}
		}
		GUILayout.EndHorizontal();
		GUILayout.EndArea();
		GUILayout.BeginArea(new Rect(5f, 50f, Screen.width - 10, 60f));
		GUILayout.BeginHorizontal();
		GUILayout.Label("Click on the ground to spawn selected particles");
		GUILayout.FlexibleSpace();
		GUILayout.Label("Use the LEFT and RIGHT keys to switch effects; Press DEL to delete all effects on screen");
		GUILayout.EndHorizontal();
		GUILayout.EndArea();
	}

	private GameObject spawnParticle()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(ParticleExamples[exampleIndex]);
		Transform transform = gameObject.transform;
		Vector3 position = gameObject.transform.position;
		transform.position = new Vector3(0f, position.y, 0f);
		gameObject.SetActive(value: true);
		for (int i = 0; i < gameObject.transform.childCount; i++)
		{
			gameObject.transform.GetChild(i).gameObject.SetActive(value: true);
		}
		ParticleSystem component = gameObject.GetComponent<ParticleSystem>();
		if (component != null && component.loop)
		{
			component.gameObject.AddComponent<CFX3_AutoStopLoopedEffect>();
			component.gameObject.AddComponent<CFX_AutoDestructShuriken>();
		}
		onScreenParticles.Add(gameObject);
		return gameObject;
	}

	private IEnumerator CheckForDeletedParticles()
	{
		while (true)
		{
			yield return new WaitForSeconds(5f);
			for (int num = onScreenParticles.Count - 1; num >= 0; num--)
			{
				if (onScreenParticles[num] == null)
				{
					onScreenParticles.RemoveAt(num);
				}
			}
		}
	}

	private IEnumerator RandomSpawnsCoroutine()
	{
		while (true)
		{
			GameObject particles = spawnParticle();
			if (orderedSpawns)
			{
				Transform transform = particles.transform;
				Vector3 position = base.transform.position;
				float x = order;
				Vector3 position2 = particles.transform.position;
				transform.position = position + new Vector3(x, position2.y, 0f);
				order -= step;
				if (order < 0f - range)
				{
					order = range;
				}
			}
			else
			{
				Transform transform2 = particles.transform;
				Vector3 a = base.transform.position + new Vector3(UnityEngine.Random.Range(0f - range, range), 0f, UnityEngine.Random.Range(0f - range, range));
				Vector3 position3 = particles.transform.position;
				transform2.position = a + new Vector3(0f, position3.y, 0f);
			}
			yield return new WaitForSeconds(float.Parse(randomSpawnsDelay));
		}
	}

	private void prevParticle()
	{
		exampleIndex--;
		if (exampleIndex < 0)
		{
			exampleIndex = ParticleExamples.Length - 1;
		}
	}

	private void nextParticle()
	{
		exampleIndex++;
		if (exampleIndex >= ParticleExamples.Length)
		{
			exampleIndex = 0;
		}
	}

	private void destroyParticles()
	{
		for (int num = onScreenParticles.Count - 1; num >= 0; num--)
		{
			if (onScreenParticles[num] != null)
			{
				UnityEngine.Object.Destroy(onScreenParticles[num]);
			}
			onScreenParticles.RemoveAt(num);
		}
	}
}
