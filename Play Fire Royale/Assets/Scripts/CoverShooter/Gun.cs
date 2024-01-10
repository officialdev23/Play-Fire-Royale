// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Gun
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class Gun : BaseGun
	{
		[Tooltip("Number of bullets stored at max in the weapon.")]
		public int MagazineSize = 10;

		[Tooltip("Current number of loaded bullets.")]
		public int LoadedBullets = 10;

		[Tooltip("Number of bullets that are available to be loaded, not counting the already loaded ones.")]
		public int BulletInventory = 10000;

		public override bool CanLoad => BulletInventory > 0 && !IsFullyLoaded;

		public override int LoadedBulletsLeft => LoadedBullets;

		public override bool IsFullyLoaded => LoadedBullets >= MagazineSize;

		public override float LoadPercentage => (float)LoadedBullets / (float)MagazineSize;

		protected override void Consume()
		{
			LoadedBullets--;
		}

		public override bool LoadBullet()
		{
			if (BulletInventory > 0 && LoadedBullets < MagazineSize)
			{
				LoadedBullets++;
				for (int i = 0; i < base.Listeners.Length; i++)
				{
					base.Listeners[i].OnBulletLoad();
				}
				if (BulletLoaded != null)
				{
					BulletLoaded();
				}
				if (LoadedBullets >= MagazineSize)
				{
					for (int j = 0; j < base.Listeners.Length; j++)
					{
						base.Listeners[j].OnFullyLoaded();
					}
					if (FullyLoaded != null)
					{
						FullyLoaded();
					}
				}
				return true;
			}
			return false;
		}

		public override bool LoadMagazine()
		{
			if (BulletInventory > 0 && LoadedBullets < MagazineSize)
			{
				LoadedBullets = 0;
				int num = BulletInventory;
				if (num > MagazineSize)
				{
					num = MagazineSize;
				}
				BulletInventory -= num;
				LoadedBullets += num;
				for (int i = 0; i < base.Listeners.Length; i++)
				{
					base.Listeners[i].OnFullyLoaded();
				}
				if (FullyLoaded != null)
				{
					FullyLoaded();
				}
				return true;
			}
			return false;
		}
	}
}
