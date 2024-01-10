// DecompilerFi decompiler from Assembly-CSharp.dll class: GoogleMobileAds.Common.IRewardedAdClient
// SourcesPostProcessor 
using GoogleMobileAds.Api;
using System;

namespace GoogleMobileAds.Common
{
	public interface IRewardedAdClient
	{
		event EventHandler<EventArgs> OnAdLoaded;

		event EventHandler<AdErrorEventArgs> OnAdFailedToLoad;

		event EventHandler<AdErrorEventArgs> OnAdFailedToShow;

		event EventHandler<EventArgs> OnAdOpening;

		event EventHandler<Reward> OnUserEarnedReward;

		event EventHandler<EventArgs> OnAdClosed;

		void CreateRewardedAd(string adUnitId);

		void LoadAd(AdRequest request);

		bool IsLoaded();

		string MediationAdapterClassName();

		void Show();

		void SetServerSideVerificationOptions(ServerSideVerificationOptions serverSideVerificationOptions);
	}
}
