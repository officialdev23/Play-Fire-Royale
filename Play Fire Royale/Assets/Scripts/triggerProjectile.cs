// DecompilerFi decompiler from Assembly-CSharp.dll class: triggerProjectile
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

public class triggerProjectile : MonoBehaviour
{
	public GameObject projectile;

	public Transform shootPoint;

	private GameObject magicMissile;

	public float attackLenght;

	public float attackRange;

	public GameObject hitEffect;

	public void shoot()
	{
		magicMissile = UnityEngine.Object.Instantiate(projectile, shootPoint.position, base.transform.rotation);
		StartCoroutine(lerpyLoop(magicMissile));
	}

	public IEnumerator lerpyLoop(GameObject projectileInstance)
	{
		Vector3 victim = base.transform.position + base.transform.forward * attackRange;
		float progress = 0f;
		float timeScale = 1f / attackLenght;
		Vector3 origin = projectileInstance.transform.position;
		while (progress < 1f)
		{
			if ((bool)projectileInstance)
			{
				progress += timeScale * Time.deltaTime;
				float ypos = (progress - Mathf.Pow(progress, 2f)) * 12f;
				float ypos_b = (progress + 0.1f - Mathf.Pow(progress + 0.1f, 2f)) * 12f;
				projectileInstance.transform.position = Vector3.Lerp(origin, victim, progress) + new Vector3(0f, ypos, 0f);
				if (progress < 0.9f)
				{
					projectileInstance.transform.LookAt(Vector3.Lerp(origin, victim, progress + 0.1f) + new Vector3(0f, ypos_b, 0f));
				}
				yield return null;
			}
		}
		UnityEngine.Object.Destroy(projectileInstance);
		if ((bool)hitEffect)
		{
			Object.Instantiate(hitEffect, victim, base.transform.rotation);
		}
		yield return null;
	}

	public void clearProjectiles()
	{
		if ((bool)magicMissile)
		{
			UnityEngine.Object.Destroy(magicMissile);
		}
	}
}
