// DecompilerFi decompiler from Assembly-CSharp.dll class: TestSceneuGUI
// SourcesPostProcessor 
using UnityEngine;

public class TestSceneuGUI : MonoBehaviour
{
	public float NaturalHorizontalRes = 1024f;

	public float NaturalVerticalRes = 768f;

	public int Score;

	public int Extra;

	private void Update()
	{
		Score = PlayerPrefs.GetInt("score###");
		Extra = PlayerPrefs.GetInt("hero");
	}

	public void OnShowHighScores()
	{
		PlayerPrefs.SetInt("CurrentScore", 0);
		PlayerPrefs.SetInt("CurrentScore2", 0);
		UnityEngine.SceneManagement.SceneManager.LoadScene("rank");
	}

	public void OnSubmitScore()
	{
		PlayerPrefs.SetInt("CurrentScore", Score);
		PlayerPrefs.SetInt("CurrentScore2", Extra);
		UnityEngine.SceneManagement.SceneManager.LoadScene("rank");
	}
}
