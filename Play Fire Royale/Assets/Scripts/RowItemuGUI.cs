// DecompilerFi decompiler from Assembly-CSharp.dll class: RowItemuGUI
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class RowItemuGUI : MonoBehaviour
{
	public Text PositionLabel;

	public Text NameLabel;

	public Text ScoreLabel;

	public Image PositionSprite;

	public Image NameSprite;

	public Image ScoreSprite;

	public void SetData(Color col, Sprite BackgroundSprite)
	{
		PositionLabel.color = col;
		NameLabel.color = col;
		ScoreLabel.color = col;
		PositionSprite.sprite = BackgroundSprite;
		NameSprite.sprite = BackgroundSprite;
		ScoreSprite.sprite = BackgroundSprite;
	}

	private void Update()
	{
		PlayerPrefs.SetString("nomeglobal" + PositionLabel.text, NameLabel.text);
		PlayerPrefs.SetString("scoreglobal" + PositionLabel.text, ScoreLabel.text);
	}
}
