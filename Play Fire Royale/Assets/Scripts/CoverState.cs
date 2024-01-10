// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverState
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public struct CoverState
	{
		public const float TallThreshold = 1.1f;

		public Cover Main;

		public Cover LeftAdjacent;

		public Cover RightAdjacent;

		public Vector3 Observer;

		public int Direction;

		public bool In => Main != null;

		public bool IsTall => Main != null && Main.CheckTall(Observer.y);

		public float LeftAdjacentAngle
		{
			get
			{
				if (Main == null || LeftAdjacent == null)
				{
					return 0f;
				}
				return Mathf.DeltaAngle(LeftAdjacent.Angle, Main.Angle);
			}
		}

		public float RightAngleDiff
		{
			get
			{
				if (Main == null || RightAdjacent == null)
				{
					return 0f;
				}
				return Mathf.DeltaAngle(Main.Angle, RightAdjacent.Angle);
			}
		}

		public bool IsStandingLeft => Mathf.DeltaAngle(MovementAngle, ForwardAngle) > 0f;

		public bool IsStandingRight => Mathf.DeltaAngle(MovementAngle, ForwardAngle) < 0f;

		public float Width
		{
			get
			{
				if (Main == null)
				{
					return 0f;
				}
				return Main.Width;
			}
		}

		public float ForwardAngle
		{
			get
			{
				if (Main == null)
				{
					return 0f;
				}
				return Main.Angle;
			}
		}

		public float MovementAngle => ForwardAngle + (float)(90 * Direction);

		public Vector3 ForwardDirection
		{
			get
			{
				if (Main == null)
				{
					return Vector3.zero;
				}
				return Main.Forward;
			}
		}

		public bool HasLeftAdjacent => LeftAdjacent != null;

		public bool HasRightAdjacent => RightAdjacent != null;

		public bool IsLeftAdjacentTall
		{
			get
			{
				if (LeftAdjacent == null)
				{
					return false;
				}
				return LeftAdjacent.Top - Observer.y >= 1.1f;
			}
		}

		public bool IsRightAdjacentTall
		{
			get
			{
				if (RightAdjacent == null)
				{
					return false;
				}
				return RightAdjacent.Top - Observer.y >= 1.1f;
			}
		}

		public bool HasLeftCorner
		{
			get
			{
				if (Main == null || !Main.OpenLeft)
				{
					return false;
				}
				return LeftAdjacent == null || (IsTall && !IsLeftAdjacentTall);
			}
		}

		public bool HasRightCorner
		{
			get
			{
				if (Main == null || !Main.OpenRight)
				{
					return false;
				}
				return RightAdjacent == null || (IsTall && !IsRightAdjacentTall);
			}
		}

		public float FaceAngle(bool isCrouching)
		{
			if (IsTall && !isCrouching)
			{
				return ForwardAngle + Mathf.DeltaAngle(ForwardAngle, ForwardAngle + 180f);
			}
			return ForwardAngle + (float)(90 * Direction);
		}

		public bool Take(CoverSearch search, Vector3 observer)
		{
			Observer = observer;
			bool @in = In;
			Cover cover = search.FindClosest();
			Cover main = Main;
			if (Main == null && cover != null)
			{
				Main = cover;
				LeftAdjacent = Main.LeftAdjacent;
				RightAdjacent = Main.RightAdjacent;
			}
			else
			{
				Clear();
			}
			if (In && !@in)
			{
				return true;
			}
			return false;
		}

		public void Maintain(CoverSearch search, Vector3 observer)
		{
			Observer = observer;
			Cover cover = search.FindClosest();
			Cover main = Main;
			if (Main != null && Main != cover && (cover == null || (!Main.IsLeftAdjacent(cover, observer) && !Main.IsRightAdjacent(cover, observer))))
			{
				Main = null;
			}
			if (Main != null)
			{
				LeftAdjacent = Main.LeftAdjacent;
				RightAdjacent = Main.RightAdjacent;
			}
			else
			{
				LeftAdjacent = null;
				RightAdjacent = null;
			}
		}

		public void Clear()
		{
			Main = null;
			LeftAdjacent = null;
			RightAdjacent = null;
		}

		public void StandRight()
		{
			Direction = 1;
		}

		public void StandLeft()
		{
			Direction = -1;
		}

		public void MoveToLeftAdjacent()
		{
			RightAdjacent = Main;
			Main = LeftAdjacent;
			LeftAdjacent = null;
		}

		public void MoveToRightAdjacent()
		{
			LeftAdjacent = Main;
			Main = RightAdjacent;
			RightAdjacent = null;
		}
	}
}
