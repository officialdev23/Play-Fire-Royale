// DecompilerFi decompiler from Assembly-CSharp.dll class: Highscores_struct
// SourcesPostProcessor 
public struct Highscores_struct
{
	public string UserName;

	public int Score;

	public int Score2;

	public string ScoreTxt;

	public string ScoreTxt2;

	public Highscores_struct(int dummy)
	{
		UserName = "- EMPTY -";
		Score = 0;
		Score2 = 0;
		ScoreTxt = $"{Score:00000000}";
		ScoreTxt2 = $"{Score2:00000000}";
	}

	public void SetScore(int value)
	{
		Score = value;
		ScoreTxt = $"{Score:00000000}";
	}

	public void SetScore2(int value)
	{
		Score2 = value;
		ScoreTxt2 = $"{Score2:00000000}";
	}
}
