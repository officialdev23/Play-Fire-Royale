// DecompilerFi decompiler from Assembly-CSharp.dll class: gerenciarpartida
// SourcesPostProcessor 
using ControlFreak2;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class gerenciarpartida : MonoBehaviour
{
	public Text totaltx;

	public int totalalive;

	public GameObject[] inimigos;

	public int escolha;

	public float x;

	public float y;

	public float z;

	public float x1;

	public float z1;

	public int encerra;

	public GameObject telafinal;

	public Text ranktx;

	public int podeanalisar;

	public int modo;

	public int tipo1;

	public GameObject heroeslocal;

	public int colocacao;

	public int pode;

	public int pode2;

	public GameObject telavenceu;

	public float tempo;

	public Text tmpotx;

	public float high;

	public Text hightx;

	public GameObject slotalerta1;

	public GameObject slotalerta2;

	public GameObject slotalerta3;

	public GameObject slotalerta4;

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

	public int hero;

	public int slot;

	public void sair()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("menu");
		CFCursor.lockState = CursorLockMode.None;
		CFCursor.visible = true;
		UnityEngine.SceneManagement.SceneManager.LoadScene("menu");
	}

	private void Awake()
	{
		Time.timeScale = 1f;
		modo = PlayerPrefs.GetInt("modo");
		PlayerPrefs.SetInt("encerra", 0);
		PlayerPrefs.SetInt("totalalive", 15);
		PlayerPrefs.SetInt("nomeinimigo", 0);
		x = UnityEngine.Random.Range(-43f, 83f);
		z = UnityEngine.Random.Range(-70f, 25f);
		x1 = UnityEngine.Random.Range(-43f, 83f);
		z1 = UnityEngine.Random.Range(-70f, 25f);
	}

	private void Start()
	{
		modo = PlayerPrefs.GetInt("modo");
		escolha = UnityEngine.Random.Range(0, 42);
		heroeslocal.transform.localPosition = new Vector3(x1, 15f, z1);
		for (int i = 0; i < 15; i++)
		{
			escolha = UnityEngine.Random.Range(0, 42);
			x = UnityEngine.Random.Range(-43f, 83f);
			z = UnityEngine.Random.Range(-70f, 25f);
			if (modo == 0)
			{
				y = UnityEngine.Random.Range(10f, 25f);
			}
			if (modo == 1)
			{
				if (tipo1 == 0)
				{
					y = UnityEngine.Random.Range(10f, 25f);
				}
				if (tipo1 == 1)
				{
					y = 5f;
				}
			}
			Object.Instantiate(inimigos[escolha], new Vector3(x, y, z), Quaternion.identity);
		}
		podeanalisar = 1;
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

	private IEnumerator chamar()
	{
		yield return new WaitForSeconds(4f);
		UnityEngine.SceneManagement.SceneManager.LoadScene("loadmenu");
	}

	private void Update()
	{
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
		hero = PlayerPrefs.GetInt("hero");
		totalalive = PlayerPrefs.GetInt("totalalive");
		if (podeanalisar == 1)
		{
			if (totalalive == 1)
			{
				if (pode2 == 0)
				{
					Time.timeScale = 0.6f;
					telavenceu.SetActive(value: true);
					colocacao = 1;
					StartCoroutine(chamar());
					pode2 = 1;
					if (high == 0f && tempo > high)
					{
						PlayerPrefs.SetFloat("high", tempo);
					}
					if (high > tempo)
					{
						PlayerPrefs.SetFloat("high", tempo);
					}
				}
			}
			else
			{
				tempo += Time.deltaTime;
				tmpotx.text = tempo.ToString("####");
				high = PlayerPrefs.GetFloat("high");
				hightx.text = high.ToString("####");
			}
		}
		totaltx.text = totalalive.ToString();
		encerra = PlayerPrefs.GetInt("encerra");
		if (encerra == 1)
		{
			ranktx.text = "#" + colocacao.ToString();
			telafinal.SetActive(value: true);
			Time.timeScale = 0.6f;
			if (pode == 0)
			{
				pode = 1;
				StartCoroutine(chamar());
			}
		}
		else
		{
			colocacao = totalalive;
			telafinal.SetActive(value: false);
		}
	}
}
