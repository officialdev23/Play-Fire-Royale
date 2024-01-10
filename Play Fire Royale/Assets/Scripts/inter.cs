// DecompilerFi decompiler from Assembly-CSharp.dll class: inter
// SourcesPostProcessor 
using GoogleMobileAds.Api;
using UnityEngine;

public class inter : MonoBehaviour
{
	public string adUnitId;

	private InterstitialAd interstitial;

	public int pode;

	private void Start()
	{
		pode = 0;
		RequestInterstitial();
	}

	private void Update()
	{
		if (pode == 0 && interstitial.IsLoaded())
		{
			interstitial.Show();
			pode = 1;
		}
	}

	public void ShowAdmob()
	{
		if (interstitial.IsLoaded())
		{
			interstitial.Show();
		}
	}

	private void RequestInterstitial()
	{
		interstitial = new InterstitialAd(adUnitId);
		AdRequest request = new AdRequest.Builder().Build();
		interstitial.LoadAd(request);
	}
}
