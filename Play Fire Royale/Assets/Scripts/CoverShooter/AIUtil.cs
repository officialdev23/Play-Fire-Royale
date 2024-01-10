// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.AIUtil
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.AI;

namespace CoverShooter
{
	public static class AIUtil
	{
		public static Actor[] Actors = new Actor[128];

		private static Collider[] _colliders = new Collider[512];

		public static int FindActorsIncludingDead(Vector3 position, float radius, Actor ignore = null)
		{
			return FindActors(position, radius, false, ignore);
		}

		public static int FindActors(Vector3 position, float radius, Actor ignore = null)
		{
			return FindActors(position, radius, true, ignore);
		}

		public static int FindActors(Vector3 position, float radius, bool ignoreDead, Actor ignore = null)
		{
			int num = 0;
			int num2 = Physics.OverlapSphereNonAlloc(position, radius, _colliders, Layers.Character);
			for (int i = 0; i < num2; i++)
			{
				if (ignore != null && _colliders[i].gameObject == ignore.gameObject)
				{
					continue;
				}
				Actor actor = CoverShooter.Actors.Get(_colliders[i].gameObject);
				if (actor != null && (!ignoreDead || actor.IsAlive))
				{
					if (num >= Actors.Length)
					{
						return num;
					}
					Actors[num++] = actor;
				}
			}
			return num;
		}

		public static Actor FindClosestActorIncludingDead(Vector3 position, float radius, Actor ignore = null)
		{
			return FindClosestActor(position, radius, false, ignore);
		}

		public static Actor FindClosestActor(Vector3 position, float radius, Actor ignore = null)
		{
			return FindClosestActor(position, radius, true, ignore);
		}

		public static Actor FindClosestActor(Vector3 position, float radius, bool ignoreDead, Actor ignore = null)
		{
			Actor actor = null;
			float num = 0f;
			int num2 = Physics.OverlapSphereNonAlloc(position, radius, _colliders, Layers.Character);
			for (int i = 0; i < num2; i++)
			{
				if (ignore != null && _colliders[i].gameObject == ignore.gameObject)
				{
					continue;
				}
				Actor component = _colliders[i].GetComponent<Actor>();
				if (component != null && (!ignoreDead || component.IsAlive))
				{
					float num3 = Vector3.Distance(component.transform.position, position);
					if (actor == null || num3 < num)
					{
						actor = component;
						num = num3;
					}
				}
			}
			return actor;
		}

		public static bool IsNavigationBlocked(Vector3 origin, Vector3 target)
		{
			NavMeshHit hit;
			return NavMesh.Raycast(origin, target, out hit, -1);
		}

		public static bool GetClosestStandablePosition(ref Vector3 position)
		{
            NavMeshHit hit;

            if (NavMesh.SamplePosition(position, out  hit, 3f, -1))
			{
				position = hit.position;
				return true;
			}
			return false;
		}

		public static bool IsPositionOnNavMesh(Vector3 position)
		{
			NavMeshHit hit;
			return NavMesh.SamplePosition(position, out hit, 0.2f, -1);
		}

		public static void Path(ref NavMeshPath path, Vector3 source, Vector3 target)
		{
			if (path == null)
			{
				path = new NavMeshPath();
			}
			GetClosestStandablePosition(ref source);
			GetClosestStandablePosition(ref target);
			NavMesh.CalculatePath(source, target, -1, path);
		}

		public static bool IsInSight(Actor actor, Vector3 target, float maxDistance, float fieldOfView, float obstacleObstructionDistance = 1f)
		{
			Vector3 standingTopPosition = actor.StandingTopPosition;
			Vector3 vector = target - standingTopPosition;
			if (vector.magnitude > maxDistance)
			{
				return false;
			}
			vector.y = 0f;
			float num = Mathf.Abs(Mathf.DeltaAngle(0f, Mathf.Acos(Vector3.Dot(vector.normalized, actor.HeadDirection)) * 57.29578f));
			if (num > fieldOfView * 0.5f)
			{
				return false;
			}
			return vector.magnitude < obstacleObstructionDistance || !IsObstructed(standingTopPosition, target);
		}

		public static bool IsObstructed(Vector3 origin, Vector3 target)
		{
            RaycastHit hitInfo;

            if (Physics.Raycast(origin, (target - origin).normalized, out  hitInfo, Vector3.Distance(origin, target), Layers.Geometry, QueryTriggerInteraction.Ignore))
			{
				if (Vector3.Distance(hitInfo.point, target) < 0.5f)
				{
					return false;
				}
				return true;
			}
			return false;
		}

		public static bool IsGoodAngle(float maxTallAngle, float maxLowAngle, Cover cover, Vector3 a, Vector3 b, bool isTall)
		{
			float f = Vector3.Dot((b - a).normalized, cover.Forward);
			if (isTall)
			{
				if (Mathf.DeltaAngle(0f, Mathf.Acos(f) * 57.29578f) > maxTallAngle)
				{
					return false;
				}
			}
			else if (Mathf.DeltaAngle(0f, Mathf.Acos(f) * 57.29578f) > maxLowAngle)
			{
				return false;
			}
			return true;
		}

		public static bool IsCoverPositionFree(Cover cover, Vector3 position, float threshold, Actor newcomer)
		{
			if (!IsJustThisCoverPositionFree(cover, position, threshold, newcomer))
			{
				return false;
			}
			if (cover.LeftAdjacent != null && !IsJustThisCoverPositionFree(cover.LeftAdjacent, position, threshold, newcomer))
			{
				return false;
			}
			if (cover.RightAdjacent != null && !IsJustThisCoverPositionFree(cover.RightAdjacent, position, threshold, newcomer))
			{
				return false;
			}
			return true;
		}

		public static bool IsJustThisCoverPositionFree(Cover cover, Vector3 position, float threshold, Actor newcomer)
		{
			foreach (CoverUser user in cover.Users)
			{
				CoverUser current = user;
				if (current.Actor != newcomer && Vector3.Distance(current.Position, position) <= threshold)
				{
					return false;
				}
			}
			return true;
		}
	}
}
