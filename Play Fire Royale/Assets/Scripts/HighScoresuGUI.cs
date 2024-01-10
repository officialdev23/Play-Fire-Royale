// DecompilerFi decompiler from Assembly-CSharp.dll class: HighScoresuGUI
// SourcesPostProcessor 
using UnityEngine;

public class HighScoresuGUI : HighScores
{
	public Sprite HighlightPleaseWaitSprite;

	public Sprite HighlightHighestSprite;

	public Sprite ScoreBoxSprite;

	public string OnMenuPressedScene;

	public GameObject RowTemplate;

	public GameObject Frame;

	public GameObject FrameContents;

	private GameObject[] RowItems;

	private RowItemuGUI[] RowItemsItem;

	private TextMesh name_textmesh;

	public GameObject GameCenterButtons;

	private Vector3 position;

	public string cena;

	private void Awake()
	{
		if (AutoCalculateNumRows)
		{
		}
		RowItems = new GameObject[NumRows];
		RowItemsItem = new RowItemuGUI[NumRows];
		GameObject gameObject = GameObject.Find("PlayerName");
		name_textmesh = (gameObject.GetComponentInChildren(typeof(TextMesh)) as TextMesh);
		SetKeyboardNameLabel(Player.UserName);
		Vector3 localPosition = RowTemplate.transform.localPosition;
		RowTemplate.SetActive(value: false);
		for (int i = 0; i < NumRows; i++)
		{
			RowItems[i] = Object.Instantiate(RowTemplate);
			RowItems[i].transform.SetParent(FrameContents.transform);
			RowItems[i].transform.localPosition = localPosition;
			RowItems[i].transform.localScale = Vector3.one;
			RowItems[i].name = "Row" + i.ToString();
			RowItemsItem[i] = RowItems[i].GetComponent<RowItemuGUI>();
			RowItems[i].SetActive(value: true);
			localPosition.y -= RowHeight;
		}
		SetGameCentre( false);
		EarthObject.SetActive(value: true);
	}

	public override void SetPleaseWait(bool state)
	{
		InPleaseWait = state;
		if (state)
		{
			RowItemsItem[0].NameLabel.text = "Loading, Please Wait...";
			RowItemsItem[0].SetData(new Color(1f, 1f, 1f), HighlightPleaseWaitSprite);
		}
		else
		{
			UpdateScores();
		}
	}

	public void chamarUrl()
	{
		Application.OpenURL("https://play.google.com/store/apps/dev?id=6361396019019131256");
	}

	public void chamarJogo()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene(cena);
	}

	public override void SetGameCentre(bool state)
	{
		InGameCentre = state;
		GameCenterButtons.SetActive(state);
	}

	public override void ShowScores(bool show)
	{
		FrameContents.SetActive(show);
	}

	public override void UpdateScores()
	{
		int num = page * NumRows;
		int num2 = 0;
		while (num2 < NumRows)
		{
			if (num >= 100)
			{
				RowItems[num2].SetActive(value: false);
			}
			else
			{
				RowItems[num2].SetActive(value: true);
				if (ShowingLocal)
				{
					RowItemsItem[num2].PositionLabel.text = (num + 1).ToString();
					RowItemsItem[num2].NameLabel.text = LScores[num].UserName;
					RowItemsItem[num2].ScoreLabel.text = LScores[num].ScoreTxt;
					if (num == Lhighlightidx)
					{
						RowItemsItem[num2].SetData(new Color(1f, 1f, 1f), HighlightHighestSprite);
					}
					else
					{
						RowItemsItem[num2].SetData(new Color(0.8f, 0.8f, 0.8f), ScoreBoxSprite);
					}
				}
				else
				{
					RowItemsItem[num2].PositionLabel.text = (num + 1).ToString();
					RowItemsItem[num2].NameLabel.text = GScores[num].UserName;
					RowItemsItem[num2].ScoreLabel.text = GScores[num].ScoreTxt;
					if (num == Ghighlightidx)
					{
						RowItemsItem[num2].SetData(new Color(1f, 1f, 1f), HighlightHighestSprite);
					}
					else
					{
						RowItemsItem[num2].SetData(new Color(0.8f, 0.8f, 0f), ScoreBoxSprite);
					}
				}
			}
			num2++;
			num++;
		}
	}

	public override void SetKeyboardNameLabel(string str)
	{
		name_textmesh.text = str;
	}

	private void DelayedFrame()
	{
		FrameContents.SetActive(value: true);
	}

	public void OnButtonMenu()
	{
		StartCoroutine(LoadScene(OnMenuPressedScene, 1.5f));
	}

	public void OnGameCenterPressed()
	{
		if (ServerFound == Server.GAMECENTRE)
		{
			Social.ShowLeaderboardUI();
		}
	}

	public void OnRankPressed()
	{
		if (ServerFound == Server.GAMECENTRE)
		{
			Social.ShowAchievementsUI();
		}
	}

	public void OnNextPressed()
	{
		if (page < 9)
		{
			page++;
		}
		else
		{
			page = 0;
		}
		UpdateScores();
	}
}
