// DecompilerFi decompiler from Assembly-CSharp.dll class: WalkingOrc
// SourcesPostProcessor 
using ControlFreak2;
using System.Collections;
using UnityEngine;

public class WalkingOrc : MonoBehaviour
{
	private Animator animator;

	public float walkspeed = 5f;

	private float horizontal;

	private float vertical;

	private float rotationDegreePerSecond = 1000f;

	private bool isAttacking;

	public GameObject gamecam;

	public Vector2 camPosition;

	private bool dead;

	public GameObject[] characters;

	public int currentChar;

	private void Start()
	{
		setCharacter(0);
	}

	private void FixedUpdate()
	{
		if ((bool)animator && !dead)
		{
			horizontal = CF2Input.GetAxis("Horizontal");
			vertical = CF2Input.GetAxis("Vertical");
			Vector3 vector = new Vector3(horizontal, 0f, vertical);
			if (vector.sqrMagnitude > 1f)
			{
				vector.Normalize();
			}
			float num = isAttacking ? 0f : vector.sqrMagnitude;
			if (vector != Vector3.zero && !isAttacking)
			{
				base.transform.rotation = Quaternion.RotateTowards(base.transform.rotation, Quaternion.LookRotation(vector, Vector3.up), rotationDegreePerSecond * Time.deltaTime);
			}
			Rigidbody component = GetComponent<Rigidbody>();
			Vector3 a = base.transform.forward * num * walkspeed;
			Vector3 velocity = GetComponent<Rigidbody>().velocity;
			component.velocity = a + new Vector3(0f, velocity.y, 0f);
			animator.SetFloat("Speed", num);
		}
	}

	private void Update()
	{
		if (!dead)
		{
			if ((bool)gamecam)
			{
				gamecam.transform.position = base.transform.position + new Vector3(0f, camPosition.x, 0f - camPosition.y);
			}
			if (CF2Input.GetButtonDown("Fire1") || (CF2Input.GetButtonDown("Jump") && !isAttacking))
			{
				isAttacking = true;
				animator.SetTrigger("Attack");
				StartCoroutine(stopAttack(1f));
				activateTrails( true);
			}
			animator.SetBool("isAttacking", isAttacking);
			if (CF2Input.GetKeyDown(KeyCode.LeftArrow))
			{
				setCharacter(-1);
				isAttacking = true;
				StartCoroutine(stopAttack(1f));
			}
			if (CF2Input.GetKeyDown(KeyCode.RightArrow))
			{
				setCharacter(1);
				isAttacking = true;
				StartCoroutine(stopAttack(1f));
			}
			if (CF2Input.GetKeyDown(KeyCode.M))
			{
				StartCoroutine(selfdestruct());
			}
		}
	}

	public IEnumerator stopAttack(float lenght)
	{
		yield return new WaitForSeconds(lenght);
		isAttacking = false;
		activateTrails( false);
	}

	public IEnumerator selfdestruct()
	{
		animator.SetTrigger("isDead");
		GetComponent<Rigidbody>().velocity = Vector3.zero;
		dead = true;
		yield return new WaitForSeconds(1.3f);
		GameObject.FindWithTag("GameController").GetComponent<gameContoller>().resetLevel();
	}

	public void setCharacter(int i)
	{
		currentChar += i;
		if (currentChar > characters.Length - 1)
		{
			currentChar = 0;
		}
		if (currentChar < 0)
		{
			currentChar = characters.Length - 1;
		}
		GameObject[] array = characters;
		foreach (GameObject gameObject in array)
		{
			if (gameObject == characters[currentChar])
			{
				gameObject.SetActive(value: true);
				continue;
			}
			gameObject.SetActive(value: false);
			if ((bool)gameObject.GetComponent<triggerProjectile>())
			{
				gameObject.GetComponent<triggerProjectile>().clearProjectiles();
			}
		}
		animator = GetComponentInChildren<Animator>();
	}

	public void activateTrails(bool state)
	{
		TrailRenderer[] componentsInChildren = GetComponentsInChildren<TrailRenderer>();
		TrailRenderer[] array = componentsInChildren;
		foreach (TrailRenderer trailRenderer in array)
		{
			trailRenderer.enabled = state;
		}
	}
}
