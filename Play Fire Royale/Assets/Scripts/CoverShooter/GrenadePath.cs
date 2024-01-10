// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.GrenadePath
// SourcesPostProcessor 
using System;
using UnityEngine;

namespace CoverShooter
{
	public static class GrenadePath
	{
		public static Vector3 Origin(CharacterMotor motor, float lookAngle)
		{
			Vector3 vector = Vector3.zero;
			vector = ((!motor.IsInLowCover) ? motor.Grenade.StandingOrigin : motor.Grenade.CrouchOrigin);
			if (motor.IsThrowingLeft)
			{
				vector.x *= -1f;
			}
			vector = Quaternion.AngleAxis(lookAngle, Vector3.up) * vector;
			return vector + motor.transform.position;
		}

		public static void Step(ref Vector3 position, ref Vector3 velocity, float step, float gravity, float bounciness)
		{
			float magnitude = velocity.magnitude;
			Vector3 vector = velocity / magnitude;
            RaycastHit hitInfo;

            if (Physics.Raycast(position - vector * 0.1f, vector, out  hitInfo, magnitude * step + 0.1f, Layers.Geometry, QueryTriggerInteraction.Ignore))
			{
				position = hitInfo.point;
				velocity = Vector3.Reflect(velocity, hitInfo.normal) * bounciness;
			}
			else
			{
				position += velocity * step;
			}
			velocity -= Vector3.up * gravity * step;
		}

		public static int Calculate(Vector3 start, float horizontalAngle, float angleInDegrees, float velocity, GrenadeDescription desc, Vector3[] buffer, float step = 0.05f)
		{
			if (buffer.Length == 0)
			{
				return 0;
			}
			buffer[0] = start;
			int num = 1;
			Vector3 vector = Util.HorizontalVector(horizontalAngle);
			float magnitude = vector.magnitude;
			float f = angleInDegrees * ((float)Math.PI / 180f);
			Vector3 velocity2 = (vector.normalized * Mathf.Cos(f) + Vector3.up * Mathf.Sin(f)) * velocity;
			Vector3 position = start;
			float num2 = 0f;
			while (num < buffer.Length && num2 < desc.Duration && velocity2.magnitude > 0.1f)
			{
				Step(ref position, ref velocity2, step, desc.Gravity, desc.Bounciness);
				num2 += step;
				buffer[num++] = position;
			}
			return num;
		}

		public static Vector3 GetVelocity(Vector3 start, Vector3 target, float maxVelocity, float gravity)
		{
			Vector3 vector = new Vector3(target.x, 0f, target.z) - new Vector3(start.x, 0f, start.z);
			float height = target.y - start.y;
			float magnitude = vector.magnitude;
			float angle = (float)Math.PI / 4f;
			float num = maxVelocity;
			if (getAngle(height, magnitude, num, 0f - gravity, ref angle) && angle > (float)Math.PI / 4f)
			{
				angle = (float)Math.PI / 4f;
				num = getVelocity(height, magnitude, 0f - gravity, angle);
			}
			return (vector.normalized * Mathf.Cos(angle) + Vector3.up * Mathf.Sin(angle)) * num;
		}

		public static int Calculate(Vector3 start, Vector3 target, float maxVelocity, GrenadeDescription desc, Vector3[] buffer, float step = 0.05f)
		{
			if (buffer.Length == 0)
			{
				return 0;
			}
			buffer[0] = start;
			int num = 1;
			Vector3 velocity = GetVelocity(start, target, maxVelocity, desc.Gravity);
			Vector3 position = start;
			float num2 = 0f;
			while (num < buffer.Length && num2 < desc.Duration && velocity.magnitude > 0.1f)
			{
				Step(ref position, ref velocity, step, desc.Gravity, desc.Bounciness);
				num2 += step;
				buffer[num++] = position;
			}
			return num;
		}

		public static int Calculate(Vector3 start, Vector3 target, Vector3[] buffer, float step = 0.05f)
		{
			if (buffer.Length == 0)
			{
				return 0;
			}
			buffer[0] = start;
			int num = 1;
			Vector3 vector = new Vector3(target.x, 0f, target.z) - new Vector3(start.x, 0f, start.z);
			float height = target.y - start.y;
			float magnitude = vector.magnitude;
			int num2 = 10;
			float num3 = (float)Math.PI / 4f;
			float velocity = getVelocity(height, magnitude, -num2, num3);
			Vector3 a = (vector.normalized * Mathf.Cos(num3) + Vector3.up * Mathf.Sin(num3)) * velocity;
			Vector3 vector2 = start;
			float num4 = 0f;
			while (num < buffer.Length && Vector3.Distance(buffer[num], target) > 0.1f)
			{
				vector2 += a * step;
				a -= Vector3.up * num2 * step;
				num4 += step;
				buffer[num++] = vector2;
			}
			return num;
		}

		private static float getVelocity(float height, float distance, float gravity, float angle)
		{
			float num = Mathf.Tan(angle);
			float num2 = Mathf.Sqrt(distance) * Mathf.Sqrt(Mathf.Abs(gravity)) * Mathf.Sqrt(num * num + 1f);
			float num3 = Mathf.Sqrt(0f - (2f * height / distance - 2f * num));
			return num2 / num3;
		}

		private static bool getAngle(float height, float distance, float velocity, float gravity, ref float angle)
		{
			float num = velocity * velocity * velocity * velocity - gravity * (gravity * distance * distance - 2f * height * velocity * velocity);
			if (num > 0f)
			{
				num = Mathf.Sqrt(num);
				angle = Mathf.Atan((velocity * velocity + num) / ((0f - gravity) * distance));
				return true;
			}
			return false;
		}
	}
}
