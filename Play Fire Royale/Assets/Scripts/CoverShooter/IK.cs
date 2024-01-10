// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.IK
// SourcesPostProcessor 
using UnityEngine;

namespace CoverShooter
{
	public class IK
	{
		public Transform TargetParentBone;

		public Vector3 Offset;

		public Quaternion OffsetOrientation = Quaternion.identity;

		public IKBone[] Bones;

		private IKTransform _target;

		private IKTransform[] _transforms = new IKTransform[16];

		private float _updateTime;

		public IK()
		{
			for (int i = 0; i < _transforms.Length; i++)
			{
				_transforms[i] = new IKTransform();
			}
		}

		public Vector3 GetTargetPosition()
		{
			Vector3 point = OffsetOrientation * Offset;
			return TargetParentBone.transform.position + TargetParentBone.rotation * point;
		}

		public void UpdateAim(Vector3 targetPosition, float delay, float weight, int minIterations, int maxIterations)
		{
			if (Time.realtimeSinceStartup - _updateTime >= delay)
			{
				CalcAim(targetPosition, minIterations, maxIterations);
				_updateTime = Time.realtimeSinceStartup;
			}
			AssignTransforms(weight);
		}

		public void UpdateMove(Vector3 targetPosition, float delay, float weight, int minIterations, int maxIterations)
		{
			if (Time.realtimeSinceStartup - _updateTime >= delay)
			{
				CalcMove(targetPosition, minIterations, maxIterations);
				_updateTime = Time.realtimeSinceStartup;
			}
			AssignTransforms(weight);
		}

		public void CalcAim(Vector3 targetPosition, int minIterations, int maxIterations)
		{
			if (!prepareTransforms())
			{
				return;
			}
			for (int i = 0; i < minIterations || (i < maxIterations && Vector3.Dot((targetPosition - _target.Position).normalized, _target.Forward) < 0.9f); i++)
			{
				for (int j = 0; j < Bones.Length - 1; j++)
				{
					solveAimBone(targetPosition, Bones[j], (float)(i + 1) / (float)Bones.Length);
				}
				solveAimBone(targetPosition, Bones[Bones.Length - 1]);
			}
		}

		public void CalcMove(Vector3 targetPosition, int minIterations, int maxIterations)
		{
			if (!prepareTransforms())
			{
				return;
			}
			for (int i = 0; i < minIterations || (i < maxIterations && Vector3.Distance(targetPosition, _target.Position) > 0.01f); i++)
			{
				for (int j = 0; j < Bones.Length - 1; j++)
				{
					solveMoveBone(targetPosition, Bones[j], (float)(i + 1) / (float)Bones.Length);
				}
				solveMoveBone(targetPosition, Bones[Bones.Length - 1]);
			}
		}

		private void solveAimBone(Vector3 targetPosition, IKBone bone, float weightMultiplier = 1f)
		{
			if (bone.Link != null)
			{
				float t = bone.Weight * weightMultiplier;
				Vector3 normalized = (targetPosition - _target.Position).normalized;
				Quaternion lhs = Quaternion.FromToRotation(_target.Forward, normalized);
				bone.Link.Change = Quaternion.Lerp(bone.Link.Change, lhs * bone.Link.Change, t);
				bone.Link.Calc();
			}
		}

		private void solveMoveBone(Vector3 targetPosition, IKBone bone, float weightMultiplier = 1f)
		{
			if (bone.Link != null)
			{
				float t = bone.Weight * weightMultiplier;
				Vector3 position = bone.Link.Position;
				Quaternion lhs = Quaternion.FromToRotation((_target.Position - position).normalized, (targetPosition - position).normalized);
				bone.Link.Change = Quaternion.Lerp(bone.Link.Change, lhs * bone.Link.Change, t);
				bone.Link.Calc();
			}
		}

		private void AssignTransforms(float weight)
		{
			for (int num = Bones.Length - 1; num >= 0; num--)
			{
				IKBone iKBone = Bones[num];
				if (iKBone.Transform != null && iKBone.Link != null)
				{
					iKBone.Transform.rotation = Quaternion.Lerp(iKBone.Transform.rotation, iKBone.Link.Change * iKBone.Transform.rotation, weight);
				}
				if (iKBone.Sibling != null && iKBone.Link != null)
				{
					iKBone.Sibling.rotation = Quaternion.Lerp(iKBone.Sibling.rotation, iKBone.Link.Change * iKBone.Sibling.rotation, weight);
				}
			}
		}

		private bool prepareTransforms()
		{
			if (Bones.Length == 0 || TargetParentBone == null)
			{
				return false;
			}
			for (int i = 0; i < Bones.Length; i++)
			{
				Bones[i].Link = null;
			}
			int num = 0;
			_target = _transforms[num++];
			_target.Reset(TargetParentBone, TargetParentBone.parent, Offset, OffsetOrientation);
			int last = Bones.Length;
			findBone(_target, ref last);
			Transform transform = TargetParentBone.parent;
			IKTransform iKTransform = _target;
			while (transform != null && last > 0)
			{
				IKTransform iKTransform2 = _transforms[num++];
				Transform parent = transform.parent;
				iKTransform2.Reset(transform, parent);
				findBone(iKTransform2, ref last);
				iKTransform.Parent = iKTransform2;
				iKTransform2.Child = iKTransform;
				transform = parent;
				iKTransform = iKTransform2;
			}
			iKTransform.Calc();
			return true;
		}

		private void findBone(IKTransform transform, ref int last)
		{
			int num = last - 1;
			while (true)
			{
				if (num >= 0)
				{
					if (transform.Link == Bones[num].Transform)
					{
						break;
					}
					num--;
					continue;
				}
				return;
			}
			Bones[num].Link = transform;
			last = num;
		}
	}
}
