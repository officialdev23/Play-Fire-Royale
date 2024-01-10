// DecompilerFi decompiler from Assembly-CSharp.dll class: waves
// SourcesPostProcessor 
using ControlFreak2;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class waves : MonoBehaviour
{
	public float x;

	public float y;

	public float z;

	public int modo;

	public GameObject inimigos;

	public int zombies;

	public Text wavetx;

	public int onda;

	public Text zombiestx;

	public GameObject hero1;

	public GameObject hero2;

	public GameObject hero3;

	public GameObject hero4;

	public GameObject hero5;

	public GameObject hero6;

	public GameObject hero7;

	public GameObject hero1u;

	public GameObject hero2u;

	public GameObject hero3u;

	public GameObject hero4u;

	public GameObject hero5u;

	public GameObject hero6u;

	public GameObject hero7u;

	public GameObject hero1u1;

	public GameObject hero2u1;

	public GameObject hero3u1;

	public GameObject hero4u1;

	public GameObject hero5u1;

	public GameObject hero6u1;

	public GameObject hero7u1;

	public GameObject cura1;

	public GameObject cura2;

	public GameObject cura3;

	public GameObject cura4;

	public GameObject cura5;

	public GameObject cura6;

	public GameObject cura7;

	public Text nexttx;

	public float tempo;

	public int hero;

	public int slot;

	public AudioSource chega;

	public int totalbonus;

	public GameObject bonus;

	public int score;

	public Text scoretx;

	public GameObject meta;

	public GameObject meta2;

	public int star;

	public Text startx;

	public int monstros;

	public GameObject musicaintro;

	public GameObject musicaaction;

	public GameObject musicaboss;

	public GameObject casa;

	public GameObject casa2;

	public GameObject casa3;

	public int podecasa1;

	public int podecasa2;

	public int podecasa3;

	public int hero11;

	public int podemeta;

	public GameObject slotalerta1;

	public GameObject slotalerta2;

	public GameObject slotalerta3;

	public GameObject slotalerta4;

	public GameObject novacam;

	public GameObject todascam;

	public GameObject final;

	public GameObject alerta1;

	public GameObject alerta2;

	public GameObject alerta3;

	public int morretodos;

	public GameObject coletar;

	public float tempo2;

	public Text tempo2tx;

	public GameObject presente;

	public int elixir;

	public int saude;

	public Text elixirtx;

	public Text saudetx;

	public int highscore;

	public int podecurar;

	public GameObject avisonapode;

	public GameObject avisopracurar;

	private IEnumerator gerarbonus()
	{
		yield return new WaitForSeconds(1f);
		totalbonus = UnityEngine.Random.Range(0, 6);
		for (int i = 0; i < totalbonus; i++)
		{
			x = UnityEngine.Random.Range(12, 24);
			z = UnityEngine.Random.Range(16, 32);
			y = UnityEngine.Random.Range(1f, 10f);
			Object.Instantiate(bonus, new Vector3(x, y, z), Quaternion.identity);
		}
	}

	private void Start()
	{
		PlayerPrefs.SetInt("morretodos", 0);
		PlayerPrefs.SetInt("saude", 1);
		PlayerPrefs.SetInt("elixir", 0);
		PlayerPrefs.SetInt("score", 0);
		PlayerPrefs.SetInt("###score", 0);
		PlayerPrefs.SetInt("onda", 0);
		Time.timeScale = 1f;
		monstros = UnityEngine.Random.Range(4, 13);
		PlayerPrefs.SetInt("zombies", 4);
		y = 2f;
		tempo = 30f;
		StartCoroutine(onda1());
		StartCoroutine(camerasok());
		hero = PlayerPrefs.GetInt("hero");
		if (hero == 1)
		{
			hero1.SetActive(value: true);
			hero1u.SetActive(value: true);
			hero1u1.SetActive(value: true);
		}
		else
		{
			hero1.SetActive(value: false);
			hero1u.SetActive(value: false);
			hero1u1.SetActive(value: false);
		}
		if (hero == 2)
		{
			hero2.SetActive(value: true);
			hero2u.SetActive(value: true);
			hero2u1.SetActive(value: true);
		}
		else
		{
			hero2.SetActive(value: false);
			hero2u.SetActive(value: false);
			hero2u1.SetActive(value: false);
		}
		if (hero == 3)
		{
			hero3.SetActive(value: true);
			hero3u.SetActive(value: true);
			hero3u1.SetActive(value: true);
		}
		else
		{
			hero3.SetActive(value: false);
			hero3u.SetActive(value: false);
			hero3u1.SetActive(value: false);
		}
		if (hero == 4)
		{
			hero4.SetActive(value: true);
			hero4u.SetActive(value: true);
			hero4u1.SetActive(value: true);
		}
		else
		{
			hero4.SetActive(value: false);
			hero4u.SetActive(value: false);
			hero4u1.SetActive(value: false);
		}
		if (hero == 5)
		{
			hero5.SetActive(value: true);
			hero5u.SetActive(value: true);
			hero5u1.SetActive(value: true);
		}
		else
		{
			hero5.SetActive(value: false);
			hero5u.SetActive(value: false);
			hero5u1.SetActive(value: false);
		}
		if (hero == 6)
		{
			hero6.SetActive(value: true);
			hero6u.SetActive(value: true);
			hero6u1.SetActive(value: true);
		}
		else
		{
			hero6.SetActive(value: false);
			hero6u.SetActive(value: false);
			hero6u1.SetActive(value: false);
		}
		if (hero == 7)
		{
			hero7.SetActive(value: true);
			hero7u.SetActive(value: true);
			hero7u1.SetActive(value: true);
		}
		else
		{
			hero7.SetActive(value: false);
			hero7u.SetActive(value: false);
			hero7u1.SetActive(value: false);
		}
	}

	private IEnumerator onda1()
	{
		yield return new WaitForSeconds(30f);
		podemeta = 1;
		onda++;
		PlayerPrefs.SetInt("onda", onda);
		StartCoroutine(onda2());
		musicaintro.SetActive(value: false);
		musicaaction.SetActive(value: true);
		chega.GetComponent<AudioSource>().Play();
		for (int i = 0; i < monstros; i++)
		{
			zombies++;
			PlayerPrefs.SetInt("zombies", zombies);
			modo = UnityEngine.Random.Range(0, 7);
			if (modo == 0)
			{
				x = UnityEngine.Random.Range(-8f, 38f);
				z = -28f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 1)
			{
				z = UnityEngine.Random.Range(-21f, 57f);
				x = 50f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 2)
			{
				x = UnityEngine.Random.Range(-13f, 48f);
				z = 57f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 3)
			{
				z = UnityEngine.Random.Range(-31f, 57f);
				x = -13f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 4)
			{
				x = UnityEngine.Random.Range(-8f, 38f);
				z = -28f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 5)
			{
				z = UnityEngine.Random.Range(-21f, 57f);
				x = 50f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 6)
			{
				x = UnityEngine.Random.Range(-13f, 48f);
				z = 57f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 7)
			{
				z = UnityEngine.Random.Range(-31f, 57f);
				x = -13f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
		}
	}

	private IEnumerator Desligar()
	{
		yield return new WaitForSeconds(4f);
		meta.SetActive(value: false);
		meta2.SetActive(value: false);
	}

	private IEnumerator desligar2()
	{
		yield return new WaitForSeconds(3f);
		alerta1.SetActive(value: false);
		alerta2.SetActive(value: false);
		alerta3.SetActive(value: false);
	}

	public void sair111()
	{
		PlayerPrefs.SetInt("CurrentScore", score);
		PlayerPrefs.SetInt("CurrentScore2", hero11);
		UnityEngine.SceneManagement.SceneManager.LoadScene("rank");
	}

	private IEnumerator saindo()
	{
		yield return new WaitForSeconds(4f);
		PlayerPrefs.SetInt("CurrentScore", score);
		PlayerPrefs.SetInt("CurrentScore2", hero11);
		UnityEngine.SceneManagement.SceneManager.LoadScene("rank");
	}

	private IEnumerator camerasok()
	{
		yield return new WaitForSeconds(6f);
		todascam.SetActive(value: true);
		novacam.SetActive(value: false);
	}

	private IEnumerator onda2()
	{
		yield return new WaitForSeconds(tempo);
		podecurar = 0;
		monstros = onda + UnityEngine.Random.Range(4, 16);
		podemeta = 1;
		tempo = 60f + (float)onda;
		if (zombies > 0)
		{
			meta2.SetActive(value: true);
			StartCoroutine(Desligar());
		}
		onda++;
		PlayerPrefs.SetInt("onda", onda);
		if (onda % 5 == 0)
		{
			musicaaction.SetActive(value: false);
			musicaboss.SetActive(value: true);
			musicaintro.SetActive(value: false);
		}
		else
		{
			musicaaction.SetActive(value: true);
			musicaboss.SetActive(value: false);
			musicaintro.SetActive(value: false);
		}
		StartCoroutine(onda2());
		chega.GetComponent<AudioSource>().Play();
		for (int i = 0; i < monstros; i++)
		{
			zombies++;
			PlayerPrefs.SetInt("zombies", zombies);
			modo = UnityEngine.Random.Range(0, 7);
			if (modo == 0)
			{
				x = UnityEngine.Random.Range(-8f, 38f);
				z = -28f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 1)
			{
				z = UnityEngine.Random.Range(-21f, 57f);
				x = 50f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 2)
			{
				x = UnityEngine.Random.Range(-13f, 48f);
				z = 57f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 3)
			{
				z = UnityEngine.Random.Range(-31f, 57f);
				x = -13f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 4)
			{
				x = UnityEngine.Random.Range(-8f, 38f);
				z = -28f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 5)
			{
				z = UnityEngine.Random.Range(-21f, 57f);
				x = 50f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 6)
			{
				x = UnityEngine.Random.Range(-13f, 48f);
				z = 57f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
			if (modo == 7)
			{
				z = UnityEngine.Random.Range(-31f, 57f);
				x = -13f;
				Object.Instantiate(inimigos, new Vector3(x, y, z), Quaternion.identity);
			}
		}
	}

	private IEnumerator coletando()
	{
		yield return new WaitForSeconds(5f);
		coletar.SetActive(value: true);
		StartCoroutine(coletando2());
		StartCoroutine(gerarbonus());
	}

	private IEnumerator fechar()
	{
		yield return new WaitForSeconds(2f);
		avisonapode.SetActive(value: false);
	}

	private IEnumerator coletando2()
	{
		yield return new WaitForSeconds(4f);
		coletar.SetActive(value: false);
	}

	private IEnumerator desligacura()
	{
		yield return new WaitForSeconds(4f);
		avisopracurar.SetActive(value: false);
	}

	public void SAIR()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("loadmenu");
	}

	public void chamarCura()
	{
		if (saude < 1)
		{
			return;
		}
		if (podecurar == 0)
		{
			avisopracurar.SetActive(value: true);
			StartCoroutine(desligacura());
			if (hero == 1)
			{
				cura1.SetActive(value: true);
			}
			if (hero == 2)
			{
				cura2.SetActive(value: true);
			}
			if (hero == 3)
			{
				cura3.SetActive(value: true);
			}
			if (hero == 4)
			{
				cura4.SetActive(value: true);
			}
			if (hero == 5)
			{
				cura5.SetActive(value: true);
			}
			if (hero == 6)
			{
				cura6.SetActive(value: true);
			}
			if (hero == 7)
			{
				cura7.SetActive(value: true);
			}
			podecurar = 1;
			saude--;
			PlayerPrefs.SetInt("saude", saude);
		}
		else
		{
			avisonapode.SetActive(value: true);
			StartCoroutine(fechar());
		}
	}

	private void Update()
	{
		hero11 = PlayerPrefs.GetInt("hero");
		if (CF2Input.GetKeyUp(KeyCode.H) && saude >= 1)
		{
			if (podecurar == 0)
			{
				avisopracurar.SetActive(value: true);
				StartCoroutine(desligacura());
				if (hero == 1)
				{
					cura1.SetActive(value: true);
				}
				if (hero == 2)
				{
					cura2.SetActive(value: true);
				}
				if (hero == 3)
				{
					cura3.SetActive(value: true);
				}
				if (hero == 4)
				{
					cura4.SetActive(value: true);
				}
				if (hero == 5)
				{
					cura5.SetActive(value: true);
				}
				if (hero == 6)
				{
					cura6.SetActive(value: true);
				}
				if (hero == 7)
				{
					cura7.SetActive(value: true);
				}
				podecurar = 1;
				saude--;
				PlayerPrefs.SetInt("saude", saude);
			}
			else
			{
				avisonapode.SetActive(value: true);
				StartCoroutine(fechar());
			}
		}
		onda = PlayerPrefs.GetInt("onda");
		score = PlayerPrefs.GetInt("score");
		PlayerPrefs.SetInt("CurrentScore", score);
		PlayerPrefs.SetInt("CurrentScore2", hero11);
		highscore = PlayerPrefs.GetInt("highscore");
		if (score > highscore)
		{
			PlayerPrefs.SetInt("highscore", score);
		}
		scoretx.text = score.ToString();
		elixir = PlayerPrefs.GetInt("elixir");
		saude = PlayerPrefs.GetInt("saude");
		saudetx.text = saude.ToString();
		elixirtx.text = elixir.ToString();
		tempo2tx.text = tempo2.ToString("##");
		if (podemeta == 1 && zombies <= 0)
		{
			tempo2 = 30f;
			meta.SetActive(value: true);
			StartCoroutine(Desligar());
			star += 5;
			PlayerPrefs.SetInt("star", star);
			podemeta = 0;
			StartCoroutine(coletando());
			presente.gameObject.SetActive(value: true);
		}
		if (tempo2 > 0f)
		{
			tempo2 -= Time.deltaTime;
		}
		else
		{
			presente.gameObject.SetActive(value: false);
		}
		morretodos = PlayerPrefs.GetInt("morretodos");
		if (morretodos == 1)
		{
			StartCoroutine(saindo());
			PlayerPrefs.SetInt("morretodos", 0);
		}
		if (casa.gameObject == null && casa2.gameObject == null && casa3.gameObject == null)
		{
			final.SetActive(value: true);
			PlayerPrefs.SetInt("morretodos", 1);
			Time.timeScale = 0.5f;
		}
		if (casa.gameObject == null && podecasa1 == 0)
		{
			podecasa1 = 1;
			alerta1.SetActive(value: true);
			StartCoroutine(desligar2());
		}
		if (casa2.gameObject == null && podecasa2 == 0)
		{
			podecasa2 = 1;
			alerta2.SetActive(value: true);
			StartCoroutine(desligar2());
		}
		if (casa3.gameObject == null && podecasa3 == 0)
		{
			podecasa3 = 1;
			alerta3.SetActive(value: true);
			StartCoroutine(desligar2());
		}
		if (zombies <= 0)
		{
			musicaaction.SetActive(value: false);
			musicaintro.SetActive(value: true);
		}
		star = PlayerPrefs.GetInt("star");
		startx.text = star.ToString();
		nexttx.text = "Next Wave in " + tempo.ToString("##") + " seconds";
		if (tempo >= 0f)
		{
			tempo -= Time.deltaTime;
		}
		else
		{
			tempo = 60f + (float)(onda * 2);
		}
		zombies = PlayerPrefs.GetInt("zombies");
		wavetx.text = onda.ToString();
		zombiestx.text = zombies.ToString();
		slot = PlayerPrefs.GetInt("slot");
		if (slot == 0)
		{
			slotalerta1.SetActive(value: true);
		}
		else
		{
			slotalerta1.SetActive(value: false);
		}
		if (slot == 1)
		{
			slotalerta2.SetActive(value: true);
		}
		else
		{
			slotalerta2.SetActive(value: false);
		}
		if (slot == 2)
		{
			slotalerta3.SetActive(value: true);
		}
		else
		{
			slotalerta3.SetActive(value: false);
		}
		if (slot == 3)
		{
			slotalerta4.SetActive(value: true);
		}
		else
		{
			slotalerta4.SetActive(value: false);
		}
	}
}
