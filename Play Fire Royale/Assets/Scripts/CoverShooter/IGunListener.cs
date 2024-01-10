// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.IGunListener
// SourcesPostProcessor 
namespace CoverShooter
{
	public interface IGunListener
	{
		void OnEject();

		void OnRechamber();

		void OnPump();

		void OnFire(float delay);

		void OnEmptyFire();

		void OnBulletLoad();

		void OnFullyLoaded();

		void OnBulletLoadStart();

		void OnPumpStart();

		void OnMagazineLoadStart();
	}
}
