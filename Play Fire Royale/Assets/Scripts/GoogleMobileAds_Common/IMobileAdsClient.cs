// DecompilerFi decompiler from Assembly-CSharp.dll class: GoogleMobileAds.Common.IMobileAdsClient
// SourcesPostProcessor 
namespace GoogleMobileAds.Common
{
	public interface IMobileAdsClient
	{
		void Initialize(string appId);

		void SetApplicationVolume(float volume);

		void SetApplicationMuted(bool muted);

		void SetiOSAppPauseOnBackground(bool pause);
	}
}
