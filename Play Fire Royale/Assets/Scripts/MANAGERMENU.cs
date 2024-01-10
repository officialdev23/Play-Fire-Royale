// DecompilerFi decompiler from Assembly-CSharp.dll class: MANAGERMENU
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;
using UnityEngine.UI;

public class MANAGERMENU : MonoBehaviour
{
	public GameObject hero1;

	public GameObject hero2;

	public GameObject hero3;

	public GameObject hero4;

	public GameObject hero5;

	public GameObject hero6;

	public GameObject hero7;

	public Text nametx;

	public Text spedtx;

	public Text attackmeleetx;

	public Text weapontx;

	public Text haealthtx;

	public Text regetx;

	public Text tipotx;

	public Text distanciatx;

	public int hero;

	public GameObject modojogo1;

	public GameObject modojogo2;

	public GameObject modoescolha;

	public GameObject modoatual;

	public int modo;

	public GameObject camera1;

	public GameObject camera2;

	public GameObject uihero;

	public GameObject uimanin;

	public Animation telaanima;

	public Slider sliderlevel;

	public int xp;

	public Text xptx;

	public GameObject PODEUSAR;

	public GameObject NOPODEUSAR;

	public int block;

	public int highscore;

	public Text scoretx;

	public int star;

	public Text startx;

	public GameObject telarank;

	public GameObject bonecorank;

	public GameObject bonecomenu;

	public GameObject telamenu;

	public int modoloja;

	public int preco;

	public Text precotx;

	public GameObject aviso;

	public AudioSource click;

	public AudioSource buy;

	public GameObject telainfo;

	public GameObject telaequipar;

	public GameObject seleciona1;

	public GameObject seleciona2;

	public GameObject seleciona3;

	public int block1;

	public int block2;

	public int block3;

	public int block4;

	public int block5;

	public int block6;

	public int block7;

	public GameObject heroipodeusar1;

	public GameObject heroipodeusar2;

	public GameObject heroipodeusar3;

	public GameObject heroipodeusar4;

	public GameObject heroipodeusar5;

	public GameObject heroipodeusar6;

	public GameObject heroipodeusar7;

	public int suportehero0;

	public int suportehero1;

	public int suportehero2;

	public int area;

	public GameObject brilho;

	public GameObject nobrilho;

	public int level;

	public Text leveltx;

	public void chamrran()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene("rank");
	}

	public void abrirank()
	{
		telarank.SetActive(value: true);
		bonecorank.SetActive(value: true);
		telamenu.SetActive(value: false);
		bonecomenu.SetActive(value: false);
	}

	public void fecharrank()
	{
		telarank.SetActive(value: false);
		bonecorank.SetActive(value: false);
		telamenu.SetActive(value: true);
		bonecomenu.SetActive(value: true);
	}

	public void playnow()
	{
		if (modo == 1)
		{
			if (suportehero0 == 0 || suportehero1 == 0 || suportehero2 == 0)
			{
				telaequipar.SetActive(value: true);
			}
			else
			{
				UnityEngine.SceneManagement.SceneManager.LoadScene("loadgame1");
			}
		}
		else
		{
			UnityEngine.SceneManagement.SceneManager.LoadScene("loadgame0");
		}
	}

	public void sair()
	{
		PlayerPrefs.SetInt("hero", suportehero0);
	}

	public void chamarheros()
	{
		camera1.SetActive(value: false);
		camera2.SetActive(value: true);
		uihero.SetActive(value: true);
		uimanin.SetActive(value: false);
		telaanima.GetComponent<Animation>().Play("grande1");
	}

	public void chamarmenu()
	{
		camera2.SetActive(value: false);
		camera1.SetActive(value: true);
		uihero.SetActive(value: false);
		uimanin.SetActive(value: true);
		telaanima.GetComponent<Animation>().Play("grande2");
		hero = PlayerPrefs.GetInt("hero");
	}

	public void passar1()
	{
		hero++;
		if (hero > 7)
		{
			hero = 1;
		}
		if (hero < 1)
		{
			hero = 7;
		}
	}

	public void passar12()
	{
		hero--;
		if (hero > 7)
		{
			hero = 1;
		}
		if (hero < 1)
		{
			hero = 7;
		}
	}

	private void Start()
	{
		hero = PlayerPrefs.GetInt("hero");
		Time.timeScale = 1f;
		CFCursor.lockState = CursorLockMode.None;
		CFCursor.visible = true;
		PlayerPrefs.SetInt("tutorial", 1);
		PlayerPrefs.SetInt("morretodos", 0);
	}

	public void escoolha0()
	{
		PlayerPrefs.SetInt("modojogo", 0);
	}

	public void escoolha1()
	{
		PlayerPrefs.SetInt("modojogo", 1);
	}

	public void botaopode()
	{
		PlayerPrefs.SetInt("hero", hero);
		click.GetComponent<AudioSource>().Play();
	}

	public void chamarinfo()
	{
		telaanima.GetComponent<Animation>().Play("grande1");
	}

	public void chamar_telaequipar()
	{
		telaequipar.SetActive(value: true);
	}

	public void area0()
	{
		area = 0;
		PlayerPrefs.SetInt("area", 0);
		click.GetComponent<AudioSource>().Play();
	}

	public void area1()
	{
		area = 1;
		PlayerPrefs.SetInt("area", 1);
		click.GetComponent<AudioSource>().Play();
	}

	public void area2()
	{
		area = 2;
		PlayerPrefs.SetInt("area", 2);
		click.GetComponent<AudioSource>().Play();
	}

	public void nopodepode()
	{
		if (star >= preco)
		{
			star -= preco;
			PlayerPrefs.SetInt("star", star);
			PlayerPrefs.SetInt("block" + hero, 2);
			buy.GetComponent<AudioSource>().Play();
		}
		else
		{
			aviso.SetActive(value: true);
			telainfo.SetActive(value: false);
			uihero.SetActive(value: false);
		}
	}

	public void slothero1()
	{
		if (block1 == 2)
		{
			if (suportehero0 != 1 || suportehero1 != 1 || suportehero2 != 1)
			{
				PlayerPrefs.SetInt("suportehero" + area, 1);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 1);
			}
		}
	}

	public void slothero2()
	{
		if (block2 == 2)
		{
			if (suportehero0 != 2 || suportehero1 != 2 || suportehero2 != 2)
			{
				PlayerPrefs.SetInt("suportehero" + area, 2);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 2);
			}
		}
	}

	public void slothero3()
	{
		if (block3 == 2)
		{
			if (suportehero0 != 3 || suportehero1 != 3 || suportehero2 != 3)
			{
				PlayerPrefs.SetInt("suportehero" + area, 3);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 3);
			}
		}
	}

	public void slothero4()
	{
		if (block4 == 2)
		{
			if (suportehero0 != 4 || suportehero1 != 4 || suportehero2 != 4)
			{
				PlayerPrefs.SetInt("suportehero" + area, 4);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 4);
			}
		}
	}

	public void slothero5()
	{
		if (block5 == 2)
		{
			if (suportehero0 != 5 || suportehero1 != 5 || suportehero2 != 5)
			{
				PlayerPrefs.SetInt("suportehero" + area, 5);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 5);
			}
		}
	}

	public void slothero6()
	{
		if (block6 == 2)
		{
			if (suportehero0 != 6 || suportehero1 != 6 || suportehero2 != 6)
			{
				PlayerPrefs.SetInt("suportehero" + area, 6);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 6);
			}
		}
	}

	public void slothero7()
	{
		if (block7 == 2)
		{
			if (suportehero0 != 7 || suportehero1 != 7 || suportehero2 != 7)
			{
				PlayerPrefs.SetInt("suportehero" + area, 7);
			}
			if (area == 0)
			{
				PlayerPrefs.SetInt("hero", 7);
			}
		}
	}

	private void Update()
	{
		xp = PlayerPrefs.GetInt("xp");
		xptx.text = xp.ToString() + "/100";
		sliderlevel.value = xp;
		sliderlevel.maxValue = 100f;
		leveltx.text = level.ToString();
		if (xp >= 100)
		{
			PlayerPrefs.SetInt("xp", 0);
			level++;
			PlayerPrefs.SetInt("level", level);
		}
		star = PlayerPrefs.GetInt("star");
		startx.text = star.ToString();
		highscore = PlayerPrefs.GetInt("highscore");
		scoretx.text = highscore.ToString();
		if (!uihero.gameObject.active)
		{
			hero = PlayerPrefs.GetInt("hero");
		}
		if (modo == 0)
		{
			brilho.SetActive(value: true);
			nobrilho.SetActive(value: false);
		}
		else
		{
			brilho.SetActive(value: false);
			nobrilho.SetActive(value: true);
		}
		block1 = PlayerPrefs.GetInt("block1");
		block2 = PlayerPrefs.GetInt("block2");
		block3 = PlayerPrefs.GetInt("block3");
		block4 = PlayerPrefs.GetInt("block4");
		block5 = PlayerPrefs.GetInt("block5");
		block6 = PlayerPrefs.GetInt("block6");
		block7 = PlayerPrefs.GetInt("block7");
		suportehero0 = PlayerPrefs.GetInt("suportehero0");
		suportehero1 = PlayerPrefs.GetInt("suportehero1");
		suportehero2 = PlayerPrefs.GetInt("suportehero2");
		if (block1 == 2)
		{
			heroipodeusar1.SetActive(value: true);
		}
		else
		{
			heroipodeusar1.SetActive(value: false);
		}
		if (block2 == 2)
		{
			heroipodeusar2.SetActive(value: true);
		}
		else
		{
			heroipodeusar2.SetActive(value: false);
		}
		if (block3 == 2)
		{
			heroipodeusar3.SetActive(value: true);
		}
		else
		{
			heroipodeusar3.SetActive(value: false);
		}
		if (block4 == 2)
		{
			heroipodeusar4.SetActive(value: true);
		}
		else
		{
			heroipodeusar4.SetActive(value: false);
		}
		if (block5 == 2)
		{
			heroipodeusar5.SetActive(value: true);
		}
		else
		{
			heroipodeusar5.SetActive(value: false);
		}
		if (block6 == 2)
		{
			heroipodeusar6.SetActive(value: true);
		}
		else
		{
			heroipodeusar6.SetActive(value: false);
		}
		if (block7 == 2)
		{
			heroipodeusar7.SetActive(value: true);
		}
		else
		{
			heroipodeusar7.SetActive(value: false);
		}
		if (area == 0)
		{
			seleciona1.SetActive(value: true);
		}
		else
		{
			seleciona1.SetActive(value: false);
		}
		if (area == 1)
		{
			seleciona2.SetActive(value: true);
		}
		else
		{
			seleciona2.SetActive(value: false);
		}
		if (area == 2)
		{
			seleciona3.SetActive(value: true);
		}
		else
		{
			seleciona3.SetActive(value: false);
		}
		precotx.text = preco.ToString();
		modo = PlayerPrefs.GetInt("modojogo");
		block = PlayerPrefs.GetInt("block" + hero);
		if (block == 2)
		{
			PODEUSAR.SetActive(value: true);
			NOPODEUSAR.SetActive(value: false);
		}
		else
		{
			PODEUSAR.SetActive(value: false);
			NOPODEUSAR.SetActive(value: true);
		}
		if (modo == 0)
		{
			modojogo1.SetActive(value: true);
		}
		else
		{
			modojogo1.SetActive(value: false);
		}
		if (modo == 1)
		{
			modojogo2.SetActive(value: true);
		}
		else
		{
			modojogo2.SetActive(value: false);
		}
		if (hero == 1)
		{
			nametx.text = "Ranger";
			spedtx.text = "Speed: 1.2  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 50";
			weapontx.text = "Attack Fire Damage: 35";
			distanciatx.text = "Distance fire : 40 m";
			haealthtx.text = "Health: 700 HP";
			regetx.text = "Regeneration: 5 life/sec";
			tipotx.text = "Shooter";
			hero1.SetActive(value: true);
			preco = 0;
		}
		else
		{
			hero1.SetActive(value: false);
		}
		if (hero == 2)
		{
			nametx.text = "Jimmy";
			spedtx.text = "Speed: 1.2  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 20";
			weapontx.text = "Attack Fire Damage: 25";
			distanciatx.text = "Distance fire : 50 m";
			haealthtx.text = "Health: 700 HP";
			regetx.text = "Regeneration: 4 life/sec";
			tipotx.text = "Shooter";
			hero2.SetActive(value: true);
			preco = 0;
		}
		else
		{
			hero2.SetActive(value: false);
		}
		if (hero == 3)
		{
			nametx.text = "Khatani";
			spedtx.text = "Speed: 1.3  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 70";
			weapontx.text = "Attack Fire Damage: 140";
			distanciatx.text = "Distance fire : 1000 m";
			haealthtx.text = "Health: 450 HP";
			regetx.text = "Regeneration: 2 life/sec";
			tipotx.text = "Sniper";
			hero3.SetActive(value: true);
			preco = 0;
		}
		else
		{
			hero3.SetActive(value: false);
		}
		if (hero == 4)
		{
			nametx.text = "Metalbird";
			spedtx.text = "Speed: 1.0  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 35";
			weapontx.text = "Attack Fire Damage: 35";
			distanciatx.text = "Distance fire : 200 m";
			haealthtx.text = "Health: 1000 HP";
			regetx.text = "Regeneration: 1 life/sec";
			tipotx.text = "Tank";
			hero4.SetActive(value: true);
			preco = 3000;
		}
		else
		{
			hero4.SetActive(value: false);
		}
		if (hero == 5)
		{
			nametx.text = "Vulture";
			spedtx.text = "Speed: 1.2  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 50";
			weapontx.text = "Attack Fire Damage: 15";
			distanciatx.text = "Distance fire : 200 m";
			haealthtx.text = "Health: 600 HP";
			regetx.text = "Regeneration: 3 life/sec";
			tipotx.text = "Assassin";
			hero5.SetActive(value: true);
			preco = 1900;
		}
		else
		{
			hero5.SetActive(value: false);
		}
		if (hero == 6)
		{
			nametx.text = "Spider";
			spedtx.text = "Speed: 1.3  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 35";
			weapontx.text = "Attack Fire Damage: 70";
			distanciatx.text = "Distance fire : 120 m";
			haealthtx.text = "Health: 800 HP";
			regetx.text = "Regeneration: 6 life/sec";
			tipotx.text = "Shooter";
			hero6.SetActive(value: true);
			preco = 2900;
		}
		else
		{
			hero6.SetActive(value: false);
		}
		if (hero == 7)
		{
			nametx.text = "Shynna";
			spedtx.text = "Speed: 1.5  m/sec";
			attackmeleetx.text = "Attack Melee Damage: 100";
			weapontx.text = "Attack Fire Damage: 35";
			distanciatx.text = "Distance fire : 170 m";
			haealthtx.text = "Health: 700 HP";
			regetx.text = "Regeneration: 3 life/sec";
			tipotx.text = "Assassin";
			hero7.SetActive(value: true);
			preco = 3200;
		}
		else
		{
			hero7.SetActive(value: false);
		}
	}
}
