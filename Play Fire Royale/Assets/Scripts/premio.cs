// DecompilerFi decompiler from Assembly-CSharp.dll class: premio
// SourcesPostProcessor 
using System.Collections;
using UnityEngine;

public class premio : MonoBehaviour
{
	public GameObject[] bonus;

	public int escolha;

	public GameObject hit;

	public int pode;

	public int saude;

	public int score;

	public int star;

	public int elixir;

	private void Start()
	{
		escolha = UnityEngine.Random.Range(0, 7);
		bonus[escolha].SetActive(value: true);
	}

	private IEnumerator desliga()
	{
		yield return new WaitForSeconds(2f);
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag == "Player" && pode == 0)
		{
			hit.SetActive(value: true);
			StartCoroutine(desliga());
			bonus[escolha].SetActive(value: false);
			if (escolha == 0)
			{
				star++;
				PlayerPrefs.SetInt("star", star);
			}
			if (escolha == 1)
			{
				score += 25;
				PlayerPrefs.SetInt("score", score);
			}
			if (escolha == 2)
			{
				score += 25;
				PlayerPrefs.SetInt("score", score);
			}
			if (escolha == 3)
			{
				star++;
				PlayerPrefs.SetInt("star", star);
			}
			if (escolha == 4)
			{
				saude++;
				PlayerPrefs.SetInt("saude", saude);
			}
			if (escolha == 5)
			{
				saude++;
				PlayerPrefs.SetInt("saude", saude);
			}
			if (escolha == 6)
			{
				star++;
				PlayerPrefs.SetInt("star", star);
			}
			if (escolha == 7)
			{
				elixir++;
				PlayerPrefs.SetInt("elixir", elixir);
			}
		}
	}

	private void Update()
	{
		elixir = PlayerPrefs.GetInt("elixir");
		saude = PlayerPrefs.GetInt("saude");
		score = PlayerPrefs.GetInt("score");
		star = PlayerPrefs.GetInt("star");
	}
}
