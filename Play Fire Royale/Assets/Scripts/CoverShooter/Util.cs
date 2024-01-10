// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.Util
// SourcesPostProcessor 
using ControlFreak2;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace CoverShooter
{
	public sealed class Util
	{
		public static Collider[] Colliders = new Collider[256];

		public static RaycastHit[] Hits = new RaycastHit[256];

		private static List<DarkZone> _dark = new List<DarkZone>();

		private static List<LightZone> _light = new List<LightZone>();

		private static List<GrassZone> _grass = new List<GrassZone>();

		private const float Multiplier = 2f;

		public static Mesh Clone(Mesh mesh, int[] triangles)
		{
			Mesh mesh2 = new Mesh();
			mesh2.Clear();
			mesh2.vertices = mesh.vertices;
			mesh2.triangles = triangles;
			mesh2.uv = mesh.uv;
			mesh2.uv2 = mesh.uv2;
			mesh2.uv3 = mesh.uv3;
			mesh2.uv4 = mesh.uv4;
			mesh2.colors = mesh.colors;
			mesh2.subMeshCount = 1;
			mesh2.normals = mesh.normals;
			return mesh2;
		}

		public static float GetViewDistance(Vector3 position, float viewDistance, bool isAlerted)
		{
			int num = Physics.OverlapSphereNonAlloc(position, 1f, Colliders, Layers.Zones, QueryTriggerInteraction.Collide);
			_dark.Clear();
			_light.Clear();
			_grass.Clear();
			for (int i = 0; i < num; i++)
			{
				DarkZone darkZone = Zone<DarkZone>.Get(Colliders[i].gameObject);
				if (darkZone != null)
				{
					_dark.Add(darkZone);
				}
				LightZone lightZone = Zone<LightZone>.Get(Colliders[i].gameObject);
				if (lightZone != null)
				{
					_light.Add(lightZone);
				}
				GrassZone grassZone = Zone<GrassZone>.Get(Colliders[i].gameObject);
				if (grassZone != null)
				{
					_grass.Add(grassZone);
				}
			}
			return GetViewDistance(viewDistance, _dark, _light, _grass, isAlerted);
		}

		public static float GetViewDistance(float viewDistance, List<DarkZone> dark, List<LightZone> light, List<GrassZone> grass, bool isAlerted)
		{
			float num = viewDistance;
			if (dark != null)
			{
				for (int i = 0; i < dark.Count; i++)
				{
					DarkZone darkZone = dark[i];
					float num2 = 0f;
					switch (darkZone.Type)
					{
					case VisibilityType.constant:
						num2 = ((!isAlerted) ? darkZone.DefaultValue : darkZone.AlertValue);
						break;
					case VisibilityType.multiplier:
						num2 = viewDistance * ((!isAlerted) ? darkZone.DefaultValue : darkZone.AlertValue);
						break;
					}
					if (num2 < num)
					{
						num = num2;
					}
				}
			}
			if (light != null)
			{
				for (int j = 0; j < light.Count; j++)
				{
					LightZone lightZone = light[j];
					float num3 = 0f;
					switch (lightZone.Type)
					{
					case VisibilityType.constant:
						num3 = lightZone.Value;
						break;
					case VisibilityType.multiplier:
						num3 = viewDistance * lightZone.Value;
						break;
					}
					if (num3 > num)
					{
						num = num3;
					}
				}
			}
			if (grass != null)
			{
				for (int k = 0; k < grass.Count; k++)
				{
					GrassZone grassZone = grass[k];
					float num4 = 0f;
					switch (grassZone.Type)
					{
					case VisibilityType.constant:
						num4 = ((!isAlerted) ? grassZone.DefaultValue : grassZone.AlertValue);
						break;
					case VisibilityType.multiplier:
						num4 = viewDistance * ((!isAlerted) ? grassZone.DefaultValue : grassZone.AlertValue);
						break;
					}
					if (num4 < num)
					{
						num = num4;
					}
				}
			}
			return num;
		}

		public static T[] GetInterfaces<T>(GameObject gameObject) where T : class
		{
			Component[] components = gameObject.GetComponents(typeof(MonoBehaviour));
			int num = 0;
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i] is T)
				{
					num++;
				}
			}
			T[] array = new T[num];
			num = 0;
			for (int j = 0; j < components.Length; j++)
			{
				if (components[j] is T)
				{
					array[num++] = (T)(object)components[j];
				}
			}
			return array;
		}

		public static bool IsFree(GameObject gameObject, Vector3 origin, Vector3 direction, float distance, bool coverMeansFree, bool actorMeansFree)
		{
			int num = Physics.RaycastNonAlloc(origin, direction, Hits, distance);
			bool result = true;
			for (int i = 0; i < num; i++)
			{
				if (coverMeansFree && Hits[i].collider.isTrigger && Hits[i].collider.GetComponent<Cover>() != null)
				{
					return true;
				}
				if (actorMeansFree && !Hits[i].collider.isTrigger && Actors.Get(Hits[i].collider.gameObject) != null)
				{
					return true;
				}
				if (!Hits[i].collider.isTrigger && !InHiearchyOf(Hits[i].collider.gameObject, gameObject))
				{
					result = false;
				}
			}
			return result;
		}

		public static bool GetClosestCover(Vector3 position, float radius, ref Cover resultCover, ref Vector3 resultPosition)
		{
			float num = 0f;
			int num2 = Physics.OverlapSphereNonAlloc(position, radius, Colliders, Layers.Cover, QueryTriggerInteraction.Collide);
			resultCover = null;
			for (int i = 0; i < num2; i++)
			{
				Cover cover = CoverSearch.GetCover(Colliders[i].gameObject);
				if (cover != null)
				{
					Vector3 vector = cover.ClosestPointTo(position, 0.3f, 0.3f);
					float num3 = Vector3.Distance(position, vector);
					if (num3 < num || resultCover == null)
					{
						resultCover = cover;
						resultPosition = vector;
						num = num3;
					}
				}
			}
			return resultCover != null;
		}

		public static RaycastHit GetClosestRaycastHit(Vector3 origin, Vector3 target, float minDistance, GameObject ignore = null)
		{
			Vector3 normalized = (target - origin).normalized;
			float num = Vector3.Distance(origin, target);
			RaycastHit result = default(RaycastHit);
			int num2 = Physics.RaycastNonAlloc(origin, normalized, Hits);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Hits[i];
				if (raycastHit.collider.gameObject != ignore && !raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num)
				{
					num = raycastHit.distance;
					result = raycastHit;
				}
			}
			return result;
		}

		public static Vector3 GetClosestNonActorHit(Vector3 origin, Vector3 target, float minDistance, GameObject ignore = null)
		{
			Vector3 normalized = (target - origin).normalized;
			float num = Vector3.Distance(origin, target);
			Vector3 result = target;
			int num2 = Physics.RaycastNonAlloc(origin, normalized, Hits);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Hits[i];
				if (raycastHit.collider.gameObject != ignore && !raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num && Actors.Get(raycastHit.collider.gameObject) == null)
				{
					num = raycastHit.distance;
					result = raycastHit.point;
				}
			}
			return result;
		}

		public static Vector3 GetClosestHitIgnoreSide(Vector3 origin, Vector3 target, float minDistance, int side, out Vector3 normal)
		{
			Vector3 normalized = (target - origin).normalized;
			float num = Vector3.Distance(origin, target);
			Vector3 result = target;
			int num2 = Physics.RaycastNonAlloc(origin, normalized, Hits);
			normal = Vector3.zero;
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Hits[i];
				if (!raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num)
				{
					Actor actor = Actors.Get(raycastHit.collider.gameObject);
					if (actor == null || actor.Side != side)
					{
						num = raycastHit.distance;
						result = raycastHit.point;
						normal = raycastHit.normal;
					}
				}
			}
			return result;
		}

		public static Vector3 GetClosestStaticHit(Vector3 origin, Vector3 target, float minDistance, GameObject ignore = null)
		{
			Vector3 normalized = (target - origin).normalized;
			float num = Vector3.Distance(origin, target);
			Vector3 result = target;
			int num2 = Physics.RaycastNonAlloc(origin, normalized, Hits, num, Layers.Geometry, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Hits[i];
				if (raycastHit.collider.gameObject != ignore && !raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num)
				{
					num = raycastHit.distance;
					result = raycastHit.point;
				}
			}
			return result;
		}

		public static Vector3 GetClosestHit(Vector3 origin, Vector3 target, float minDistance, GameObject ignore = null)
		{
			Vector3 normalized = (target - origin).normalized;
			float num = Vector3.Distance(origin, target);
			Vector3 result = target;
			int num2 = Physics.RaycastNonAlloc(origin, normalized, Hits);
			for (int i = 0; i < num2; i++)
			{
				RaycastHit raycastHit = Hits[i];
				if (raycastHit.collider.gameObject != ignore && !raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num)
				{
					num = raycastHit.distance;
					result = raycastHit.point;
				}
			}
			return result;
		}

		public static float RandomUnobstructedAngle(GameObject gameObject, Vector3 position, float maxObstruction, int attempts = 10)
		{
			return RandomUnobstructedAngle(gameObject, position, 0f, 360f, maxObstruction, attempts);
		}

		public static float RandomUnobstructedAngle(GameObject gameObject, Vector3 position, float current, float angleRange, float maxObstruction, int attempts = 10)
		{
			for (int num = attempts; num > 0; num--)
			{
				float num2 = (num <= attempts / 2) ? UnityEngine.Random.Range(0f, 360f) : UnityEngine.Random.Range(current - angleRange / 2f, current + angleRange / 2f);
				Vector3 direction = HorizontalVector(num2);
				if (IsFree(gameObject, position, direction, maxObstruction, coverMeansFree: false, actorMeansFree: true))
				{
					return num2;
				}
			}
			return UnityEngine.Random.Range(0f, 360f);
		}

		public static float GetPinch()
		{
			if (CF2Input.touchCount == 2)
			{
				InputRig.Touch touch = CF2Input.GetTouch(0);
				InputRig.Touch touch2 = CF2Input.GetTouch(1);
				Vector2 a = touch.position - touch.deltaPosition;
				Vector2 b = touch2.position - touch2.deltaPosition;
				float magnitude = (a - b).magnitude;
				float magnitude2 = (touch.position - touch2.position).magnitude;
				return magnitude2 - magnitude;
			}
			return 0f;
		}

		public static float Lerp(float Value, float Target, float rate)
		{
			return Value + (Target - Value) * Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static float LerpAngle(float Value, float Target, float rate)
		{
			return Mathf.LerpAngle(Value, Target, 1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static Vector3 Lerp(Vector3 Value, Vector3 Target, float rate)
		{
			return Value + (Target - Value) * Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static Vector3 Slerp(Vector3 Value, Vector3 Target, float rate)
		{
			return Vector3.Slerp(Value, Target, Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime)));
		}

		public static Quaternion Lerp(Quaternion Value, Quaternion Target, float rate)
		{
			return Quaternion.Slerp(Value, Target, 1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static void Lerp(ref float Value, float Target, float rate)
		{
			Value += (Target - Value) * Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static void LerpAngle(ref float Value, float Target, float rate)
		{
			Value = Mathf.LerpAngle(Value, Target, 1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static void Lerp(ref Vector3 Value, Vector3 Target, float rate)
		{
			Value += (Target - Value) * Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static void Slerp(ref Vector3 Value, Vector3 Target, float rate)
		{
			Value = Vector3.Slerp(Value, Target, Mathf.Clamp01(1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime)));
		}

		public static void Lerp(ref Quaternion Value, Quaternion Target, float rate)
		{
			Value = Quaternion.Slerp(Value, Target, 1f - Mathf.Exp((0f - rate) * 2f * Time.deltaTime));
		}

		public static void Move(ref Vector3 Value, Vector3 Target, float speed)
		{
			Vector3 a = Target - Value;
			float magnitude = a.magnitude;
			if (!(magnitude <= float.Epsilon))
			{
				if (magnitude < speed)
				{
					Value = Target;
				}
				else
				{
					Value += a * speed / magnitude;
				}
			}
		}

		public static void Move(ref float Value, float Target, float speed)
		{
			if (Target > Value)
			{
				if (Value + speed > Target)
				{
					Value = Target;
				}
				else if (speed > 0f)
				{
					Value += speed;
				}
			}
			else if (Value - speed < Target)
			{
				Value = Target;
			}
			else if (speed > 0f)
			{
				Value -= speed;
			}
		}

		public static void MoveAngle(ref float Value, float Target, float speed)
		{
			float num = Mathf.DeltaAngle(Value, Target);
			if (num > 0f)
			{
				if (Value + speed > Target)
				{
					Value = Target;
				}
				else if (speed > 0f)
				{
					Value += speed;
				}
			}
			else if (Value - speed < Target)
			{
				Value = Target;
			}
			else if (speed > 0f)
			{
				Value -= speed;
			}
		}

		public static bool InHiearchyOf(GameObject target, GameObject parent)
		{
			GameObject gameObject = target;
			if (target.transform.root == parent.transform)
			{
				return true;
			}
			while (gameObject != null)
			{
				if (gameObject == parent)
				{
					return true;
				}
				gameObject = ((!(gameObject.transform.parent != null)) ? null : gameObject.transform.parent.gameObject);
			}
			return false;
		}

		public static float FindDeltaPath(Vector3 a, Vector3 b, Vector3 point)
		{
			Vector3 vector = point - a;
			Vector3 vector2 = b - a;
			float num = vector2.x * vector2.x + vector2.z * vector2.z;
			float num2 = vector.x * vector2.x + vector.z * vector2.z;
			return num2 / num;
		}

		public static Vector3 FindClosestToPath(Vector3 a, Vector3 b, Vector3 point)
		{
			Vector3 vector = point - a;
			Vector3 a2 = b - a;
			float num = a2.x * a2.x + a2.z * a2.z;
			float num2 = vector.x * a2.x + vector.z * a2.z;
			float value = num2 / num;
			return a + a2 * Mathf.Clamp01(value);
		}

		public static Vector3 HorizontalVector(float angle)
		{
			angle *= (float)Math.PI / 180f;
			return new Vector3(Mathf.Sin(angle), 0f, Mathf.Cos(angle));
		}

		public static Vector3 Vector(float horizontal, float vertical)
		{
			horizontal *= (float)Math.PI / 180f;
			vertical *= (float)Math.PI / 180f;
			return new Vector3(Mathf.Sin(horizontal), 0f - Mathf.Sin(vertical), Mathf.Cos(horizontal));
		}

		public static float HorizontalAngle(Vector3 vector)
		{
			Vector2 to = new Vector2(vector.z, vector.x);
			if (to.sqrMagnitude > 0.01f)
			{
				to.Normalize();
			}
			float num = (!(to.y < 0f)) ? 1f : (-1f);
			return Vector2.Angle(Vector2.right, to) * num;
		}

		public static float VerticalAngle(Vector3 vector)
		{
			Vector3 vector2 = vector;
			vector2.y = 0f;
			float num = (!(vector.y > 0f)) ? 1f : (-1f);
			return Vector2.Angle(Vector2.right, new Vector2(vector2.magnitude, vector.y)) * num;
		}

		public static float VerticalAngle(float height, float distance)
		{
			float num = (!(height > 0f)) ? 1f : (-1f);
			return Vector2.Angle(Vector2.right, new Vector2(distance, height)) * num;
		}

		public static float DistanceToSegment(Vector3 point, Vector3 p0, Vector3 p1)
		{
			float sqrMagnitude = (p1 - p0).sqrMagnitude;
			if (sqrMagnitude <= float.Epsilon)
			{
				return Vector3.Distance(point, p0);
			}
			float d = Mathf.Clamp01(((point.x - p0.x) * (p1.x - p0.x) + (point.y - p0.y) * (p1.y - p0.y) + (point.z - p0.z) * (p1.z - p0.z)) / sqrMagnitude);
			return Vector3.Distance(point, p0 + (p1 - p0) * d);
		}

		public static Vector3 VectorToSegment(Vector3 point, Vector3 p0, Vector3 p1)
		{
			float sqrMagnitude = (p1 - p0).sqrMagnitude;
			if (sqrMagnitude <= float.Epsilon)
			{
				return p0 - point;
			}
			float d = Mathf.Clamp01(((point.x - p0.x) * (p1.x - p0.x) + (point.y - p0.y) * (p1.y - p0.y) + (point.z - p0.z) * (p1.z - p0.z)) / sqrMagnitude);
			return p0 + (p1 - p0) * d - point;
		}
	}
}
