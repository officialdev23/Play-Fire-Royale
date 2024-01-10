// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.IKTransform
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class IKTransform
	{
		public Quaternion Change = Quaternion.identity;

		public Transform Link;

		public IKTransform Parent;

		public IKTransform Child;

		public Vector3 Position;

		public Quaternion Rotation;

		public Vector3 SavedPosition;

		public Quaternion SavedRotation;

		public Vector3 SavedOffsetedForward;

		public Vector3 SavedLocalPosition;

		public bool HasOffset;

		public Vector3 OffsetPosition;

		public Quaternion OffsetOrientation;

		private Quaternion _storedTotalChange;

		public Vector3 Forward => _storedTotalChange * SavedOffsetedForward;

		public void Reset(Transform link, Transform parent)
		{
			_storedTotalChange = Quaternion.identity;
			Change = Quaternion.identity;
			Link = link;
			SavedPosition = Link.position;
			SavedRotation = Link.rotation;
			SavedOffsetedForward = Link.forward;
			HasOffset = false;
			if (parent != null)
			{
				SavedLocalPosition = Quaternion.Inverse(parent.rotation) * (parent.TransformPoint(link.localPosition) - parent.position);
			}
			Parent = null;
			Child = null;
		}

		public void Reset(Transform link, Transform parent, Vector3 offsetPosition, Quaternion offsetOrientation)
		{
			_storedTotalChange = Quaternion.identity;
			Change = Quaternion.identity;
			Link = link;
			SavedPosition = Link.position;
			SavedRotation = Link.rotation;
			HasOffset = true;
			OffsetPosition = offsetPosition;
			OffsetOrientation = offsetOrientation;
			SavedOffsetedForward = OffsetOrientation * Link.forward;
			if (parent != null)
			{
				SavedLocalPosition = Quaternion.Inverse(parent.rotation) * (parent.TransformPoint(link.localPosition) - parent.position);
			}
			Parent = null;
			Child = null;
		}

		public void Calc()
		{
			if (Parent == null)
			{
				_storedTotalChange = Change;
			}
			else
			{
				_storedTotalChange = Parent._storedTotalChange * Change;
			}
			if (HasOffset)
			{
				Quaternion quaternion = _storedTotalChange * OffsetOrientation;
				Rotation = quaternion * SavedRotation;
				Vector3 b = quaternion * OffsetPosition;
				if (Parent == null)
				{
					Position = SavedPosition + b;
				}
				else
				{
					Position = Parent.Position + Parent.Rotation * SavedLocalPosition + b;
				}
			}
			else
			{
				Rotation = _storedTotalChange * SavedRotation;
				if (Parent == null)
				{
					Position = SavedPosition;
				}
				else
				{
					Position = Parent.Position + Parent.Rotation * SavedLocalPosition;
				}
			}
			if (Child != null)
			{
				Child.Calc();
			}
		}
	}
}
