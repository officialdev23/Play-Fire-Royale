// DecompilerFi decompiler from Assembly-CSharp.dll class: GoogleMobileAdsDemoScript
// SourcesPostProcessor 
using GoogleMobileAds.Api;
using System;
using UnityEngine;

public class GoogleMobileAdsDemoScript : MonoBehaviour
{
	private BannerView bannerView;

	private InterstitialAd interstitial;

	private RewardedAd rewardedAd;

	private float deltaTime;

	private static string outputMessage = string.Empty;

	public static string OutputMessage
	{
		set
		{
			outputMessage = value;
		}
	}

	public void Start()
	{
		string appId = "ca-app-pub-4459952263583304~5982679256";
		MobileAds.SetiOSAppPauseOnBackground(pause: true);
		MobileAds.Initialize(appId);
		CreateAndLoadRewardedAd();
	}

	public void Update()
	{
		deltaTime += (Time.deltaTime - deltaTime) * 0.1f;
	}

	public void OnGUI()
	{
		GUIStyle gUIStyle = new GUIStyle();
		Rect position = new Rect(0f, 0f, Screen.width, Screen.height);
		gUIStyle.alignment = TextAnchor.LowerRight;
		gUIStyle.fontSize = (int)((double)Screen.height * 0.06);
		gUIStyle.normal.textColor = new Color(0f, 0f, 0.5f, 1f);
		float num = 1f / deltaTime;
		string text = $"{num:0.} fps";
		GUI.Label(position, text, gUIStyle);
		GUI.skin.button.fontSize = (int)(0.035f * (float)Screen.width);
		float width = 0.35f * (float)Screen.width;
		float height = 0.15f * (float)Screen.height;
		float x = 0.1f * (float)Screen.width;
		float x2 = 0.55f * (float)Screen.width;
		Rect position2 = new Rect(x, 0.05f * (float)Screen.height, width, height);
		if (GUI.Button(position2, "Request\nBanner"))
		{
			RequestBanner();
		}
		Rect position3 = new Rect(x, 0.225f * (float)Screen.height, width, height);
		if (GUI.Button(position3, "Destroy\nBanner"))
		{
			bannerView.Destroy();
		}
		Rect position4 = new Rect(x, 0.4f * (float)Screen.height, width, height);
		if (GUI.Button(position4, "Request\nInterstitial"))
		{
			RequestInterstitial();
		}
		Rect position5 = new Rect(x, 0.575f * (float)Screen.height, width, height);
		if (GUI.Button(position5, "Show\nInterstitial"))
		{
			ShowInterstitial();
		}
		Rect position6 = new Rect(x, 0.75f * (float)Screen.height, width, height);
		if (GUI.Button(position6, "Destroy\nInterstitial"))
		{
			interstitial.Destroy();
		}
		Rect position7 = new Rect(x2, 0.05f * (float)Screen.height, width, height);
		if (GUI.Button(position7, "Request\nRewarded Ad"))
		{
			CreateAndLoadRewardedAd();
		}
		Rect position8 = new Rect(x2, 0.225f * (float)Screen.height, width, height);
		if (GUI.Button(position8, "Show\nRewarded Ad"))
		{
			ShowRewardedAd();
		}
		Rect position9 = new Rect(x2, 0.925f * (float)Screen.height, width, 0.05f * (float)Screen.height);
		GUI.Label(position9, outputMessage);
	}

	private AdRequest CreateAdRequest()
	{
		return new AdRequest.Builder().AddTestDevice("SIMULATOR").AddTestDevice("0123456789ABCDEF0123456789ABCDEF").AddKeyword("game")
			.SetGender(Gender.Male)
			.SetBirthday(new DateTime(1985, 1, 1))
			.TagForChildDirectedTreatment(tagForChildDirectedTreatment: false)
			.AddExtra("color_bg", "9B30FF")
			.Build();
	}

	private void RequestBanner()
	{
		string adUnitId = "ca-app-pub-3940256099942544/6300978111";
		if (bannerView != null)
		{
			bannerView.Destroy();
		}
		bannerView = new BannerView(adUnitId, AdSize.SmartBanner, AdPosition.Top);
		bannerView.OnAdLoaded += HandleAdLoaded;
		bannerView.OnAdFailedToLoad += HandleAdFailedToLoad;
		bannerView.OnAdOpening += HandleAdOpened;
		bannerView.OnAdClosed += HandleAdClosed;
		bannerView.OnAdLeavingApplication += HandleAdLeftApplication;
		bannerView.LoadAd(CreateAdRequest());
	}

	private void RequestInterstitial()
	{
		string adUnitId = "ca-app-pub-4459952263583304/6776886176";
		if (interstitial != null)
		{
			interstitial.Destroy();
		}
		interstitial = new InterstitialAd(adUnitId);
		interstitial.OnAdLoaded += HandleInterstitialLoaded;
		interstitial.OnAdFailedToLoad += HandleInterstitialFailedToLoad;
		interstitial.OnAdOpening += HandleInterstitialOpened;
		interstitial.OnAdClosed += HandleInterstitialClosed;
		interstitial.OnAdLeavingApplication += HandleInterstitialLeftApplication;
		interstitial.LoadAd(CreateAdRequest());
	}

	public void CreateAndLoadRewardedAd()
	{
		string adUnitId = "ca-app-pub-3940256099942544/5224354917";
		rewardedAd = new RewardedAd(adUnitId);
		rewardedAd.OnAdLoaded += HandleRewardedAdLoaded;
		rewardedAd.OnAdFailedToLoad += HandleRewardedAdFailedToLoad;
		rewardedAd.OnAdOpening += HandleRewardedAdOpening;
		rewardedAd.OnAdFailedToShow += HandleRewardedAdFailedToShow;
		rewardedAd.OnUserEarnedReward += HandleUserEarnedReward;
		rewardedAd.OnAdClosed += HandleRewardedAdClosed;
		AdRequest request = CreateAdRequest();
		rewardedAd.LoadAd(request);
	}

	private void ShowInterstitial()
	{
		if (interstitial.IsLoaded())
		{
			interstitial.Show();
		}
		else
		{
			MonoBehaviour.print("Interstitial is not ready yet");
		}
	}

	private void ShowRewardedAd()
	{
		if (rewardedAd.IsLoaded())
		{
			rewardedAd.Show();
		}
		else
		{
			MonoBehaviour.print("Rewarded ad is not ready yet");
		}
	}

	public void HandleAdLoaded(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdLoaded event received");
	}

	public void HandleAdFailedToLoad(object sender, AdFailedToLoadEventArgs args)
	{
		MonoBehaviour.print("HandleFailedToReceiveAd event received with message: " + args.Message);
	}

	public void HandleAdOpened(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdOpened event received");
	}

	public void HandleAdClosed(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdClosed event received");
	}

	public void HandleAdLeftApplication(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdLeftApplication event received");
	}

	public void HandleInterstitialLoaded(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleInterstitialLoaded event received");
	}

	public void HandleInterstitialFailedToLoad(object sender, AdFailedToLoadEventArgs args)
	{
		MonoBehaviour.print("HandleInterstitialFailedToLoad event received with message: " + args.Message);
	}

	public void HandleInterstitialOpened(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleInterstitialOpened event received");
	}

	public void HandleInterstitialClosed(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleInterstitialClosed event received");
	}

	public void HandleInterstitialLeftApplication(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleInterstitialLeftApplication event received");
	}

	public void HandleRewardedAdLoaded(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdLoaded event received");
	}

	public void HandleRewardedAdFailedToLoad(object sender, AdErrorEventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdFailedToLoad event received with message: " + args.Message);
	}

	public void HandleRewardedAdOpening(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdOpening event received");
	}

	public void HandleRewardedAdFailedToShow(object sender, AdErrorEventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdFailedToShow event received with message: " + args.Message);
	}

	public void HandleRewardedAdClosed(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdClosed event received");
	}

	public void HandleUserEarnedReward(object sender, Reward args)
	{
		string type = args.Type;
		MonoBehaviour.print("HandleRewardedAdRewarded event received for " + args.Amount.ToString() + " " + type);
	}
}
