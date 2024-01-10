// DecompilerFi decompiler from Assembly-CSharp.dll class: HighScores
// SourcesPostProcessor 
using System;
using System.Collections;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.SocialPlatforms;
using Range = UnityEngine.SocialPlatforms.Range;

public class HighScores : MonoBehaviour
{
	public enum State
	{
		IDLE,
		SHOWKEYBOARD,
		SHOWINGKEYBOARD
	}

	public enum Server
	{
		NONE,
		GAMECENTRE,
		OURSERVER,
		MISSING
	}

	private string secretKey = "123456";

	private string PostScoreUrl = "https://unitflix.com/playfire2/PHP/postScore.php?";

	private string GetHighscoreUrl = "https://unitflix.com/playfire2/PHP/getHighscore.php";

	public bool DebugServer;

	public Server DefaultUseServer;

	public Server EditorUseServer;

	public Server IOSUseServer;

	public Server OSXUseServer;

	public Server AndroidUseServer;

	public bool AutoCalculateNumRows;

	public int NumRows = 10;

	public float RowHeight;

	public AudioClip Sfx_keyclick;

	public AudioClip Sfx_keyboardon;

	public AudioClip Sfx_keyboardoff;

	public AudioClip SFX_PressedMenu;

	public GameObject EarthObject;

	[HideInInspector]
	public State state;

	[HideInInspector]
	public bool ShowingLocal;

	[HideInInspector]
	public Server ServerWanted;

	[HideInInspector]
	public Server ServerFound;

	[HideInInspector]
	public string ServerScoreString = string.Empty;

	[HideInInspector]
	public const int MAXKEYS = 40;

	[HideInInspector]
	public const int MAXNAME = 10;

	[HideInInspector]
	public const int MAXENTRIES = 100;

	[HideInInspector]
	public Highscores_struct[] LScores = new Highscores_struct[101];

	[HideInInspector]
	public Highscores_struct[] GScores = new Highscores_struct[101];

	[HideInInspector]
	public Highscores_struct Player;

	[HideInInspector]
	public ILeaderboard Leaderboard;

	[HideInInspector]
	public string[] userIDs = new string[101];

	[HideInInspector]
	public int NumScores;

	[HideInInspector]
	public int currentscore;

	[HideInInspector]
	public int currentscore2;

	[HideInInspector]
	public int Ghighlightidx;

	[HideInInspector]
	public int Lhighlightidx;

	[HideInInspector]
	public int page;

	[HideInInspector]
	public int Lpage;

	[HideInInspector]
	public int Gpage;

	public float KeyboardAnimSpeed;

	private Vector3 KBDownPosition;

	private Quaternion KBDownRotation;

	private Vector3 KBUpPosition;

	private Quaternion KBUpRotation;

	private Quaternion StartRot;

	private Quaternion TargetRot;

	private Vector3 StartPos;

	private Vector3 TargetPos;

	private float Dir;

	private float TimePassed;

	private bool UsingMouse;

	private GameObject keyboard;

	[HideInInspector]
	public AudioSource audiosource;

	[HideInInspector]
	public bool InPleaseWait;

	[HideInInspector]
	public bool InGameCentre;

	[HideInInspector]
	public key_struct[] keys = new key_struct[40]
	{
		new key_struct(0, null, "Key 0", '0'),
		new key_struct(1, null, "Key 1", '1'),
		new key_struct(2, null, "Key 2", '2'),
		new key_struct(3, null, "Key 3", '3'),
		new key_struct(4, null, "Key 4", '4'),
		new key_struct(5, null, "Key 5", '5'),
		new key_struct(6, null, "Key 6", '6'),
		new key_struct(7, null, "Key 7", '7'),
		new key_struct(8, null, "Key 8", '8'),
		new key_struct(9, null, "Key 9", '9'),
		new key_struct(10, null, "Key q", 'Q'),
		new key_struct(11, null, "Key w", 'W'),
		new key_struct(12, null, "Key e", 'E'),
		new key_struct(13, null, "Key r", 'R'),
		new key_struct(14, null, "Key t", 'T'),
		new key_struct(15, null, "Key y", 'Y'),
		new key_struct(16, null, "Key u", 'U'),
		new key_struct(17, null, "Key i", 'I'),
		new key_struct(18, null, "Key o", 'O'),
		new key_struct(19, null, "Key p", 'P'),
		new key_struct(20, null, "Key a", 'A'),
		new key_struct(21, null, "Key s", 'S'),
		new key_struct(22, null, "Key d", 'D'),
		new key_struct(23, null, "Key f", 'F'),
		new key_struct(24, null, "Key g", 'G'),
		new key_struct(25, null, "Key h", 'H'),
		new key_struct(26, null, "Key j", 'J'),
		new key_struct(27, null, "Key k", 'K'),
		new key_struct(28, null, "Key l", 'L'),
		new key_struct(29, null, "Key z", 'Z'),
		new key_struct(30, null, "Key x", 'X'),
		new key_struct(31, null, "Key c", 'C'),
		new key_struct(32, null, "Key v", 'V'),
		new key_struct(33, null, "Key b", 'B'),
		new key_struct(34, null, "Key n", 'N'),
		new key_struct(35, null, "Key m", 'M'),
		new key_struct(36, null, "Key space", ' '),
		new key_struct(36, null, "Key del", ' '),
		new key_struct(36, null, "Key done", ' '),
		new key_struct(99, null, "xxx", 'x')
	};

	public string nomeuser;

	public int automatico;

	public int Score1;

	public int Extra1;

	public GameObject teclado;

	private void Start()
	{
		if (automatico == 1)
		{
			Score1 = PlayerPrefs.GetInt("score###");
			Extra1 = PlayerPrefs.GetInt("hero");
			PlayerPrefs.SetInt("CurrentScore", Score1);
			PlayerPrefs.SetInt("CurrentScore2", Extra1);
		}
		state = State.IDLE;
		currentscore = PlayerPrefs.GetInt("CurrentScore", 0);
		currentscore2 = PlayerPrefs.GetInt("CurrentScore2", 0);
		PlayerPrefs.SetInt("CurrentScore", 0);
		PlayerPrefs.SetInt("CurrentScore2", 0);
		PlayerPrefs.Save();
		Player.UserName = string.Empty;
		Player.SetScore(currentscore);
		Player.SetScore2(currentscore2);
		Ghighlightidx = 0;
		Lhighlightidx = 0;
		page = 0;
		Lpage = 0;
		Gpage = 0;
		ShowingLocal = false;
		keyboard = GameObject.Find("keyboard");
		float num = 1f;
		float num2 = 2f * num * Mathf.Tan(Camera.main.fieldOfView * 0.5f * ((float)Math.PI / 180f));
		float num3 = num2 * Camera.main.aspect;
		float num4 = num3 / 1.45f;
		SetPleaseWait( true);
		SetGameCentre( false);
		LoadLocalScores();
		ServerFound = Server.NONE;
		ServerWanted = DefaultUseServer;
		ServerWanted = AndroidUseServer;
		switch (ServerWanted)
		{
		case Server.NONE:
			if (currentscore > 0)
			{
				state = State.SHOWKEYBOARD;
				teclado.SetActive(value: true);
			}
			else
			{
				state = State.IDLE;
			}
			SetPleaseWait( false);
			break;
		case Server.OURSERVER:
			StartCoroutine("GetScoreFromServer");
			if (currentscore > 0)
			{
				ShowScores( false);
				state = State.SHOWKEYBOARD;
				teclado.SetActive(value: true);
			}
			else
			{
				ShowScores( true);
				teclado.SetActive(value: false);
				state = State.IDLE;
			}
			break;
		case Server.GAMECENTRE:
			state = State.IDLE;
			Social.localUser.Authenticate(ProcessAuthentication);
			break;
		}
		UsingMouse = false;
		GetComponent<AudioSource>().PlayOneShot(Sfx_keyboardoff);
		Dir = 0f - KeyboardAnimSpeed;
		Player.UserName = PlayerPrefs.GetString("nomeuser");
		AddHighScore(Player);
		teclado.SetActive(value: false);
	}

	public virtual void SetPleaseWait(bool state)
	{
	}

	public virtual void SetGameCentre(bool state)
	{
	}

	public virtual void UpdateScores()
	{
	}

	public virtual void SetKeyboardNameLabel(string str)
	{
	}

	public virtual void ShowScores(bool show)
	{
	}

	private void ProcessAuthentication(bool success)
	{
		if (success)
		{
			ServerFound = Server.GAMECENTRE;
			state = State.IDLE;
			DoLeaderboard();
		}
		else
		{
			SetPleaseWait( false);
			ServerFound = Server.MISSING;
			ServerWanted = Server.OURSERVER;
			ServerFound = Server.NONE;
			StartCoroutine("GetScoreFromServer");
			if (currentscore > 0)
			{
				state = State.SHOWKEYBOARD;
			}
			else
			{
				state = State.IDLE;
				UpdateScores();
			}
		}
		if (ServerWanted == Server.NONE)
		{
		}
	}

	private void DoLeaderboard()
	{
		Leaderboard = Social.CreateLeaderboard();
		Leaderboard.id = "Test2_L";
		Leaderboard.range = new Range(1, 100);
		Leaderboard.LoadScores(delegate(bool result)
		{
			DidLoadScores(result);
		});
	}

	private void DidLoadScores(bool result)
	{
		int num = 0;
		NumScores = Leaderboard.scores.Length;
		userIDs = new string[NumScores];
		IScore[] scores = Leaderboard.scores;
		foreach (IScore score in scores)
		{
			userIDs[num] = score.userID;
			GScores[num].SetScore((int)score.value);
			num++;
			if (num >= 100)
			{
				break;
			}
		}
		Social.LoadUsers(userIDs, DidLoadProfiles);
	}

	private void DidLoadProfiles(IUserProfile[] result)
	{
		int num = 0;
		foreach (IUserProfile userProfile in result)
		{
			GScores[num].UserName = userProfile.userName;
			num++;
			if (num >= 100 || num >= NumScores)
			{
				break;
			}
		}
		SetPleaseWait( false);
		if (ServerFound == Server.GAMECENTRE)
		{
			SetGameCentre( true);
		}
		if (currentscore > 0)
		{
			Player.UserName = Social.localUser.userName;
			AddHighScore(Player);
		}
		SaveLocalScores();
		ShowingLocal = false;
		UpdateScores();
	}

	private void Update()
	{
		switch (state)
		{
		case State.SHOWKEYBOARD:
			TimePassed = 0f;
			teclado.SetActive(value: true);
			state = State.SHOWINGKEYBOARD;
			break;
		case State.SHOWINGKEYBOARD:
			if (Dir < 0f && TimePassed == 0f)
			{
				state = State.IDLE;
				ShowScores( true);
			}
			if (UsingMouse)
			{
				if (Input.GetMouseButtonDown(0))
				{
					Vector3 mousePosition = UnityEngine.Input.mousePosition;
					Vector2 v = default(Vector2);
					v.x = mousePosition.x;
					Vector3 mousePosition2 = UnityEngine.Input.mousePosition;
					v.y = mousePosition2.y;
					Ray ray = Camera.main.ScreenPointToRay(v);
                        RaycastHit hitInfo;

                    if (Physics.Raycast(ray, out  hitInfo, 50f))
					{
						do_keyhit(hitInfo);
					}
				}
			}
			else if (UnityEngine.Input.touchCount > 0 && Input.touches[0].phase == TouchPhase.Began)
			{
				Vector2 position = Input.touches[0].position;
				Vector2 v2 = default(Vector2);
				v2.x = position.x;
				Vector2 position2 = Input.touches[0].position;
				v2.y = position2.y;
				Ray ray2 = Camera.main.ScreenPointToRay(v2);
                    RaycastHit hitInfo2;

                if (Physics.Raycast(ray2, out  hitInfo2, 50f))
				{
					do_keyhit(hitInfo2);
				}
			}
			break;
		}
	}

	private void do_keyhit(RaycastHit hit)
	{
		int num = 0;
		while (true)
		{
			if (keys[num].Index == 99)
			{
				return;
			}
			if (keys[num].name_txt == hit.transform.name)
			{
				hit.transform.gameObject.BroadcastMessage("HitKey", hit.normal);
				if (hit.transform.name == "Key done")
				{
					GetComponent<AudioSource>().PlayOneShot(Sfx_keyboardoff);
					Dir = 0f - KeyboardAnimSpeed;
					AddHighScore(Player);
					teclado.SetActive(value: false);
					return;
				}
				if (hit.transform.name == "Key del" && Player.UserName.Length > 0)
				{
					Player.UserName = Player.UserName.Remove(Player.UserName.Length - 1);
					SetKeyboardNameLabel(Player.UserName);
					return;
				}
				if (Player.UserName.Length < 10)
				{
					break;
				}
			}
			num++;
		}
		Player.UserName += keys[num].character;
		SetKeyboardNameLabel(Player.UserName);
	}

	public IEnumerator LoadScene(string scene, float delay)
	{
		audiosource.PlayOneShot(SFX_PressedMenu);
		yield return new WaitForSeconds(delay);
		SceneManager.LoadScene(scene);
	}

	public void AddHighScore(Highscores_struct player)
	{
		int @int = PlayerPrefs.GetInt("Highest");
		if (player.Score > @int)
		{
			PlayerPrefs.SetInt("Highest", player.Score);
		}
		if (ServerFound == Server.GAMECENTRE)
		{
			Social.ReportScore(player.Score, Leaderboard.id, delegate(bool success)
			{
				UnityEngine.Debug.Log((!success) ? "Failed to report score" : "Reported score successfully");
			});
		}
		else
		{
			StartCoroutine(PostScoreToServer(player.UserName, player.Score, player.Score2));
		}
		for (int i = 0; i < 100; i++)
		{
			if (player.Score >= GScores[i].Score)
			{
				for (int num = 99; num > i; num--)
				{
					GScores[num] = GScores[num - 1];
				}
				GScores[i] = player;
				Ghighlightidx = i;
				Gpage = Ghighlightidx / NumRows;
				page = Gpage;
				break;
			}
		}
		for (int i = 0; i < 100; i++)
		{
			if (player.Score >= LScores[i].Score)
			{
				for (int num = 99; num > i; num--)
				{
					LScores[num] = LScores[num - 1];
				}
				LScores[i] = player;
				Lhighlightidx = i;
				Lpage = Lhighlightidx / NumRows;
				break;
			}
		}
		SaveLocalScores();
	}

	private void SaveLocalScores()
	{
		for (int i = 0; i < 100; i++)
		{
			PlayerPrefs.SetInt(i + "LScore", LScores[i].Score);
			PlayerPrefs.SetString(i + "LScoreName", LScores[i].UserName);
			PlayerPrefs.SetInt(i + "extraa", LScores[i].Score2);
		}
		for (int i = 0; i < 100; i++)
		{
			PlayerPrefs.SetInt(i + "GScore", GScores[i].Score);
			PlayerPrefs.SetString(i + "GScoreName", GScores[i].UserName);
			PlayerPrefs.SetInt(i + 1 + "extra", GScores[i].Score2);
		}
	}

	private void LoadLocalScores()
	{
		for (int i = 0; i < 100; i++)
		{
			if (PlayerPrefs.HasKey(i + "LScore"))
			{
				LScores[i].SetScore(PlayerPrefs.GetInt(i + "LScore"));
				LScores[i].UserName = PlayerPrefs.GetString(i + "LScoreName");
				continue;
			}
			PlayerPrefs.SetInt(i + "LScore", 0);
			PlayerPrefs.SetString(i + "LScoreName", "- Empty -");
			LScores[i].SetScore(PlayerPrefs.GetInt(i + "LScore"));
			LScores[i].UserName = PlayerPrefs.GetString(i + "LScoreName");
		}
		for (int i = 0; i < 100; i++)
		{
			if (PlayerPrefs.HasKey(i + "GScore"))
			{
				GScores[i].SetScore(PlayerPrefs.GetInt(i + "GScore"));
				GScores[i].UserName = PlayerPrefs.GetString(i + "GScoreName");
				continue;
			}
			PlayerPrefs.SetInt(i + "GScore", 0);
			PlayerPrefs.SetString(i + "GScoreName", "- Empty -");
			GScores[i].SetScore(PlayerPrefs.GetInt(i + "GScore"));
			GScores[i].UserName = PlayerPrefs.GetString(i + "GScoreName");
		}
		UpdateScores();
	}

	public void ClearLocalScores()
	{
		for (int i = 0; i < 100; i++)
		{
			PlayerPrefs.SetInt(i + "LScore", 0);
			PlayerPrefs.SetString(i + "LScoreName", "- Empty -");
			PlayerPrefs.SetInt(i + "GScore", 0);
			PlayerPrefs.SetString(i + "GScoreName", "- Empty -");
		}
		PlayerPrefs.Save();
	}

	public void OnGlobalPressed()
	{
		ShowingLocal = false;
		EarthObject.SetActive(value: true);
		page = Gpage;
		UpdateScores();
	}

	public void OnLocalPressed()
	{
		ShowingLocal = true;
		EarthObject.SetActive(value: false);
		page = Lpage;
		UpdateScores();
	}

	private IEnumerator GetScoreFromServer()
	{
		ServerScoreString = string.Empty;
		SetPleaseWait( true);
		WWWForm form = new WWWForm();
		form.AddField("limit", 100);
		WWW www = new WWW(GetHighscoreUrl, form);
		yield return www;
		if (www.text == string.Empty)
		{
			ServerFound = Server.MISSING;
		}
		else
		{
			ServerFound = Server.OURSERVER;
			SetPleaseWait( false);
			ServerScoreString = www.text;
			if (DebugServer)
			{
			}
			if (ServerScoreString.Length > 0)
			{
				string[] array = Regex.Split(ServerScoreString, "\\t|\\n");
				int num = 0;
				int num2 = 0;
				do
				{
					GScores[num2].UserName = array[num];
					GScores[num2].SetScore(int.Parse(array[num + 1]));
					GScores[num2].SetScore2(int.Parse(array[num + 2]));
					PlayerPrefs.SetInt(num2 + "extra", GScores[num2].Score2);
					if (GScores[num2].UserName.Length <= 0)
					{
						GScores[num2].UserName = "Unknown";
					}
					num += 3;
					num2++;
				}
				while (num2 < 100 && num < array.Length - 1);
				if (num2 < 100)
				{
					do
					{
						GScores[num2].UserName = "- Empty -";
						GScores[num2].SetScore(0);
						GScores[num2].SetScore2(0);
						num2++;
					}
					while (num2 < 100);
				}
			}
		}
		SaveLocalScores();
	}

	private IEnumerator PostScoreToServer(string name, int score, int score2)
	{
		string hash = CreateHash(name + score + score2 + secretKey).ToLower();
		WWWForm form = new WWWForm();
		form.AddField("name", name);
		form.AddField("score", score);
		form.AddField("score2", score2);
		form.AddField("hash", hash);
		WWW www = new WWW(PostScoreUrl, form);
		SetPleaseWait( true);
		yield return www;
		if (www.text == "done")
		{
			StartCoroutine("GetScoreFromServer");
		}
	}

	public string CreateHash(string input)
	{
		MD5 mD = MD5.Create();
		byte[] bytes = Encoding.UTF8.GetBytes(input);
		byte[] array = mD.ComputeHash(bytes);
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < array.Length; i++)
		{
			stringBuilder.Append(array[i].ToString("X2"));
		}
		return stringBuilder.ToString();
	}
}
