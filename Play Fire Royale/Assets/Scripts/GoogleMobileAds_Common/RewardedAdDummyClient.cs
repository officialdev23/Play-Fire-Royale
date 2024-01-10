// DecompilerFi decompiler from Assembly-CSharp.dll class: GoogleMobileAds.Common.RewardedAdDummyClient
// SourcesPostProcessor 
using GoogleMobileAds.Api;
using System;
using System.Reflection;
using UnityEngine;

namespace GoogleMobileAds.Common
{
	public class RewardedAdDummyClient : IRewardedAdClient
	{
		public event EventHandler<EventArgs> OnAdLoaded;

		public event EventHandler<AdErrorEventArgs> OnAdFailedToLoad;

		public event EventHandler<AdErrorEventArgs> OnAdFailedToShow;

		public event EventHandler<EventArgs> OnAdOpening;

		public event EventHandler<EventArgs> OnAdClosed;

		public event EventHandler<Reward> OnUserEarnedReward;

		public RewardedAdDummyClient()
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
		}

		public void CreateRewardedAd(string adUnitId)
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
		}

		public void LoadAd(AdRequest request)
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
		}

		public bool IsLoaded()
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
			return true;
		}

		public void Show()
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
		}

		public string MediationAdapterClassName()
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
			return null;
		}

		public void SetServerSideVerificationOptions(ServerSideVerificationOptions serverSideVerificationOptions)
		{
			UnityEngine.Debug.Log("Dummy " + MethodBase.GetCurrentMethod().Name);
		}
	}
}
