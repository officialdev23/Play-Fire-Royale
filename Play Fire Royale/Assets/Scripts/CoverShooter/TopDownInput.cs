// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.TopDownInput
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;
using UnityEngine.EventSystems;

namespace CoverShooter
{
	[RequireComponent(typeof(CharacterMotor))]
	[RequireComponent(typeof(ThirdPersonController))]
	[RequireComponent(typeof(Actor))]
	public class TopDownInput : MonoBehaviour, ICharacterController
	{
		[Tooltip("Input is ignored when a disabler is active.")]
		public GameObject Disabler;

		[Tooltip("Marker that is placed on the ground to mark the target the character is aiming at.")]
		public GameObject Marker;

		[Tooltip("Should the character walk by default and run, or run by default and sprint when needed.")]
		public bool WalkByDefault;

		[Tooltip("Should the character sprint towards the target instead of relative screen up direction.")]
		public bool SprintTowardsTarget;

		[Tooltip("Marker should be enabled and disabled together with this component.")]
		public bool ManageMarkerVisibility = true;

		[Tooltip("Will the marker be constantly displayed on the ground.")]
		public bool MarkerAlwaysOnGround = true;

		[Tooltip("Height off the ground the marker is displayed at.")]
		public float GroundLift = 0.218f;

		private Actor _actor;

		private CharacterMotor _motor;

		private ThirdPersonController _controller;

		private bool _isAimingFriendly;

		private bool _isFireDown;

		private bool _isZoomDown;

		private bool _isSprinting;

		private float _angle;

		private float[] _snapWork = new float[_snaps.Length];

		private static float[] _snaps = new float[8]
		{
			0f,
			-45f,
			45f,
			-90f,
			90f,
			135f,
			-135f,
			180f
		};

		public void UpdateAfterCamera()
		{
			UpdateTarget();
		}

		private void Awake()
		{
			_controller = GetComponent<ThirdPersonController>();
			_motor = GetComponent<CharacterMotor>();
			_actor = GetComponent<Actor>();
			_controller.WaitForUpdateCall = true;
		}

		private void OnDisable()
		{
			if (Marker != null && ManageMarkerVisibility)
			{
				Marker.SetActive(value: false);
			}
		}

		private void Update()
		{
			if (Disabler != null && Disabler.activeSelf)
			{
				return;
			}
			if (Marker != null && ManageMarkerVisibility)
			{
				if (EventSystem.current.IsPointerOverGameObject())
				{
					if (Marker.activeSelf)
					{
						Marker.SetActive(value: false);
					}
				}
				else if (!Marker.activeSelf)
				{
					Marker.SetActive(value: true);
				}
			}
			Camera main = Camera.main;
			bool flag = false;
			if (main != null)
			{
				CharacterCamera component = main.GetComponent<CharacterCamera>();
				if (component != null)
				{
					flag = true;
					component.DeferUpdate(this);
				}
			}
			if (!flag)
			{
				UpdateAfterCamera();
			}
			UpdateMovement();
			UpdateFire();
			_controller.ManualUpdate();
		}

		protected virtual void UpdateMovement()
		{
			CharacterMovement movementInput = default(CharacterMovement);
			Vector3 vector = CF2Input.GetAxis("Horizontal") * Vector3.right + CF2Input.GetAxis("Vertical") * Vector3.forward;
			if (WalkByDefault)
			{
				_isSprinting = false;
				movementInput.Magnitude = 0.5f;
				if (!_isZoomDown && CF2Input.GetButton("Run"))
				{
					movementInput.Magnitude = 1f;
				}
			}
			else
			{
				movementInput.Magnitude = 1f;
				if (_isZoomDown)
				{
					_isSprinting = false;
					movementInput.Magnitude = 0.5f;
				}
				else
				{
					_isSprinting = CF2Input.GetButton("Run");
					if (_isSprinting)
					{
						movementInput.Magnitude = 2f;
					}
				}
			}
			Camera main = Camera.main;
			float num = 0f;
			num = ((!(main == null) && (!_isSprinting || !SprintTowardsTarget)) ? Util.HorizontalAngle(main.transform.forward) : Util.HorizontalAngle(_controller.AimTargetInput - base.transform.position));
			if (vector.magnitude > float.Epsilon)
			{
				movementInput.Direction = Quaternion.Euler(0f, num, 0f) * vector.normalized;
			}
			_controller.MovementInput = movementInput;
		}

		protected virtual void UpdateFire()
		{
			if (CF2Input.GetButtonDown("Fire") && !EventSystem.current.IsPointerOverGameObject())
			{
				_isFireDown = true;
			}
			if (CF2Input.GetButtonUp("Fire"))
			{
				_isFireDown = false;
			}
			if (CF2Input.GetButtonDown("Zoom") && !EventSystem.current.IsPointerOverGameObject())
			{
				_isZoomDown = true;
			}
			if (CF2Input.GetButtonUp("Zoom"))
			{
				_isZoomDown = false;
			}
			if (CF2Input.GetButtonDown("Melee"))
			{
				_motor.InputMelee();
			}
			if (_isFireDown && !_isAimingFriendly)
			{
				_controller.FireInput = true;
			}
			else
			{
				_controller.FireInput = false;
			}
			_controller.ZoomInput = _isZoomDown;
		}

		protected virtual void UpdateTarget()
		{
			if (_controller == null || (!_isFireDown && EventSystem.current.IsPointerOverGameObject()))
			{
				return;
			}
			Camera main = Camera.main;
			if (main == null)
			{
				return;
			}
			Vector3 mousePosition = CF2Input.mousePosition;
			mousePosition.z = main.nearClipPlane;
			Vector3 vector = main.ScreenToWorldPoint(mousePosition);
			mousePosition.z = main.farClipPlane;
			Vector3 vector2 = main.ScreenToWorldPoint(mousePosition);
			Vector3 normal;
			Vector3 vector3 = Util.GetClosestHitIgnoreSide(vector, vector2, 1f, _actor.Side, out normal);
			Vector3 a = vector3;
			Actor actor = AIUtil.FindClosestActor(vector3, 0.7f, _actor);
			if (actor != null)
			{
				a = actor.transform.position;
			}
			Vector3 position = _actor.transform.position;
			float num = position.y + 1.5f;
			if (_motor.ActiveWeapon.Gun != null)
			{
				Vector3 gunOrigin = _motor.GunOrigin;
				num = gunOrigin.y;
			}
			bool flag = MarkerAlwaysOnGround || actor != null;
			if (actor != null && actor.Side != _actor.Side)
			{
				Vector3 vector4 = Vector3.Lerp(actor.transform.position, actor.TopPosition, 0.75f);
				vector3.y = vector4.y;
			}
			else
			{
				float y = vector3.y;
				Vector3 position2 = _actor.transform.position;
				if (y > position2.y - 0.5f && vector3.y <= num)
				{
					Plane plane = new Plane(Vector3.up, 0f - num);
					Vector3 normalized = (vector2 - vector).normalized;
					Ray ray = new Ray(vector, normalized);
                    float enter;

                    if (plane.Raycast(ray, out  enter))
					{
						vector3 = vector + normalized * enter;
						flag = MarkerAlwaysOnGround;
					}
				}
			}
			if (Marker != null)
			{
				Vector3 vector5;
				if (flag)
				{
					vector5 = ((!(actor == null)) ? Vector3.up : normal);
					Marker.transform.position = a + GroundLift * vector5;
				}
				else
				{
					Marker.transform.position = vector3;
					vector5 = -_motor.GunDirection;
				}
				Vector3 lhs = (!(Vector3.Distance(vector5, Vector3.forward) > 0.01f)) ? Vector3.Cross(vector5, Vector3.forward) : Vector3.right;
				Vector3 b = Vector3.Cross(lhs, vector5);
				Marker.transform.LookAt(Marker.transform.position + b, vector5);
			}
			float num2 = Util.HorizontalAngle(main.transform.forward);
			Vector3 vector6 = _actor.transform.position + 1.5f * Vector3.up;
			Vector3 vector7 = vector3 - vector6;
			vector7.y = 0f;
			float num3 = Util.HorizontalAngle(vector7);
			float magnitude = vector7.magnitude;
			if (magnitude < 2f && magnitude > float.Epsilon)
			{
				float y2 = vector3.y;
				if (magnitude < 1f)
				{
					Util.LerpAngle(ref _angle, num3, magnitude * 2f);
				}
				else
				{
					_angle = num3;
				}
				vector3 = vector6 + Util.HorizontalVector(_angle) * 2f;
				vector3.y = y2;
			}
			else
			{
				_angle = num3;
			}
			float num4 = Util.HorizontalAngle(main.transform.forward);
			for (int i = 0; i < _snaps.Length; i++)
			{
				_snapWork[i] = Mathf.Abs(Mathf.DeltaAngle(num4 + _snaps[i], _angle));
			}
			float angle = num4;
			for (int j = 0; j < _snaps.Length; j++)
			{
				bool flag2 = true;
				for (int k = j + 1; k < _snaps.Length; k++)
				{
					if (_snapWork[k] < _snapWork[j])
					{
						flag2 = false;
						break;
					}
				}
				if (flag2)
				{
					angle = num4 + _snaps[j];
					break;
				}
			}
			_controller.BodyTargetInput = _actor.transform.position + Util.HorizontalVector(angle) * 10f;
			_controller.AimTargetInput = vector3;
			if (!_isSprinting && Mathf.Abs(Mathf.DeltaAngle(Util.HorizontalAngle(_motor.transform.forward), Util.HorizontalAngle(_controller.BodyTargetInput - _motor.transform.position))) > 90f)
			{
				_motor.InputPossibleImmediateTurn();
			}
		}
	}
}
