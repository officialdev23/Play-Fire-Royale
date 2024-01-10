// DecompilerFi decompiler from Assembly-CSharp.dll class: CoverShooter.StrategyInput
// SourcesPostProcessor 
using ControlFreak2;
using UnityEngine;
using UnityEngine.EventSystems;

namespace CoverShooter
{
	public class StrategyInput : MonoBehaviour
	{
		[Tooltip("Actors with the same side will be chosen as controllable targets.")]
		public int Side = 1;

		[Tooltip("Target object that receives commands.")]
		public Actor Target;

		[Tooltip("Target marker that projects a texture.")]
		public GameObject MarkerPrefab;

		[Tooltip("Target marker that draws a target sphere.")]
		public GameObject SpherePrefab;

		[Tooltip("Input is ignored when a disabler is active.")]
		public GameObject Disabler;

		[Tooltip("Color used to highlight pickable actors.")]
		public Color PickColor = Color.yellow;

		[Tooltip("Color used to highlight selected actors.")]
		public Color SelectColor = Color.white;

		[Tooltip("Transparency of the target sphere previews.")]
		public float SphereColorOpacity = 0.3f;

		private Camera _camera;

		private GameObject _marker;

		private GameObject _sphere;

		private Material _markerMaterial;

		private Material _sphereMaterial;

		private CharacterOutline _performerOutline;

		private CharacterOutline _targetOutline;

		private AIAction _forcedAction;

		public void GiveCommand(AIAction action)
		{
			_forcedAction = action;
		}

		private void Awake()
		{
			_markerMaterial = null;
			_sphereMaterial = null;
			_camera = GetComponent<Camera>();
			if (MarkerPrefab != null)
			{
				_marker = UnityEngine.Object.Instantiate(MarkerPrefab);
				_marker.transform.SetParent(null, worldPositionStays: true);
				Projector component = _marker.GetComponent<Projector>();
				if (component != null)
				{
					_markerMaterial = UnityEngine.Object.Instantiate(component.material);
					component.material = _markerMaterial;
				}
			}
			if (SpherePrefab != null)
			{
				_sphere = UnityEngine.Object.Instantiate(SpherePrefab);
				_sphere.transform.SetParent(null, worldPositionStays: true);
				MeshRenderer component2 = _sphere.GetComponent<MeshRenderer>();
				if (component2 != null)
				{
					_sphereMaterial = UnityEngine.Object.Instantiate(component2.sharedMaterial);
					component2.material = _sphereMaterial;
				}
			}
		}

		private void OnDisable()
		{
			hideMarker();
			hideOutline(ref _performerOutline);
			hideOutline(ref _targetOutline);
		}

		private void showSphere(Vector3 target, Color color, float radius)
		{
			if (!(_sphere == null))
			{
				if (!_sphere.activeSelf)
				{
					_sphere.SetActive(value: true);
				}
				_sphere.transform.position = target;
				_sphere.transform.localScale = Vector3.one * radius * 2f;
				if (_sphereMaterial != null)
				{
					color.a *= SphereColorOpacity;
					_sphereMaterial.color = color;
				}
			}
		}

		private void hideSphere()
		{
			if (_sphere != null && _sphere.activeSelf)
			{
				_sphere.SetActive(value: false);
			}
		}

		private void showMarker(Vector3 target, Color color)
		{
			if (!(_marker == null))
			{
				if (!_marker.activeSelf)
				{
					_marker.SetActive(value: true);
				}
				_marker.transform.position = target + Vector3.up * 0.5f;
				if (_markerMaterial != null)
				{
					_markerMaterial.color = color;
				}
			}
		}

		private void hideMarker()
		{
			if (_marker != null && _marker.activeSelf)
			{
				_marker.SetActive(value: false);
			}
		}

		private void showOutline(ref CharacterOutline outline, Actor target, Color color)
		{
			if (outline != null)
			{
				hideOutline(ref outline);
			}
			outline = target.GetComponent<CharacterOutline>();
			if (outline == null)
			{
				outline = target.gameObject.AddComponent<CharacterOutline>();
				outline.DisplayDefault = false;
			}
			outline.PushColor(this, color);
		}

		private void hideOutlines()
		{
			hideOutline(ref _performerOutline);
			hideOutline(ref _targetOutline);
		}

		private void hideOutline(ref CharacterOutline outline)
		{
			if (!(outline == null))
			{
				outline.PopColor(this);
			}
		}

		private void Update()
		{
			if ((Disabler != null && Disabler.activeSelf) || EventSystem.current.IsPointerOverGameObject())
			{
				hideMarker();
				hideOutline(ref _targetOutline);
				hideSphere();
				if (Target == null)
				{
					hideOutline(ref _performerOutline);
				}
				else
				{
					showOutline(ref _performerOutline, Target, SelectColor);
				}
				return;
			}
			Camera camera = _camera;
			if (camera == null)
			{
				camera = Camera.main;
			}
			if (camera == null)
			{
				return;
			}
			Vector3 mousePosition = CF2Input.mousePosition;
			mousePosition.z = camera.nearClipPlane;
			Vector3 origin = camera.ScreenToWorldPoint(mousePosition);
			mousePosition.z = camera.farClipPlane;
			Vector3 target = camera.ScreenToWorldPoint(mousePosition);
			Vector3 closestNonActorHit = Util.GetClosestNonActorHit(origin, target, 1f);
			Actor actor = AIUtil.FindClosestActorIncludingDead(closestNonActorHit, 0.7f);
			bool flag = CF2Input.GetMouseButtonDown(0);
			if (Target == null)
			{
				if (actor != null && actor.Side == Side && actor.IsAlive)
				{
					showOutline(ref _performerOutline, actor, PickColor);
					if (flag)
					{
						Target = actor;
						flag = false;
					}
				}
				else
				{
					hideOutline(ref _performerOutline);
				}
			}
			else if (Target != null)
			{
				showOutline(ref _performerOutline, Target, SelectColor);
			}
			else
			{
				hideOutline(ref _performerOutline);
			}
			AIActions aIActions = null;
			if (Target != null)
			{
				aIActions = Target.GetComponent<AIActions>();
			}
			if ((bool)aIActions)
			{
				Vector3 position = closestNonActorHit;
				AIUtil.GetClosestStandablePosition(ref position);
				bool flag2 = actor != null;
				bool flag3 = flag2 && actor == Target;
				bool flag4 = flag2 && actor.Side == Target.Side;
				bool flag5 = flag2 && actor.Side != Target.Side;
				bool flag6 = flag2 && !actor.IsAlive;
				bool flag7 = Vector3.Distance(position, closestNonActorHit) < 0.5f;
				AIAction aIAction = null;
				bool flag8 = false;
				if (_forcedAction != null)
				{
					if (_forcedAction.CanTargetGround && flag7)
					{
						aIAction = _forcedAction;
					}
					else if ((!flag6 || !_forcedAction.ShouldIgnoreDead) && ((flag3 && _forcedAction.CanTargetSelf) || (flag4 && _forcedAction.CanTargetAlly) || (flag5 && _forcedAction.CanTargetEnemy)))
					{
						aIAction = _forcedAction;
						flag8 = true;
					}
				}
				else
				{
					for (int i = 0; i < aIActions.Actions.Length; i++)
					{
						AIAction aIAction2 = aIActions.Actions[i];
						if (aIAction2.CanTargetGround && flag7)
						{
							aIAction = aIAction2;
							break;
						}
						if ((!flag6 || !aIAction2.ShouldIgnoreDead) && ((flag3 && aIAction2.CanTargetSelf) || (flag4 && aIAction2.CanTargetAlly) || (flag5 && aIAction2.CanTargetEnemy)))
						{
							aIAction = aIAction2;
							flag8 = true;
							break;
						}
					}
				}
				if (aIAction != null)
				{
					if (flag8)
					{
						if (flag3)
						{
							hideOutline(ref _performerOutline);
						}
						showOutline(ref _targetOutline, actor, aIAction.UIColor);
						hideMarker();
						hideSphere();
					}
					else if (aIAction.UIRadius > 0.001f)
					{
						showSphere(position, aIAction.UIColor, aIAction.UIRadius);
						hideOutline(ref _targetOutline);
						hideMarker();
					}
					else
					{
						showMarker(position, aIAction.UIColor);
						hideOutline(ref _targetOutline);
						hideSphere();
					}
				}
				if (flag)
				{
					flag = false;
					if (aIAction != null)
					{
						if (aIAction.CanTargetGround)
						{
							aIActions.Execute(aIAction, position);
						}
						else
						{
							aIActions.Execute(aIAction, actor);
						}
						if (_forcedAction != null)
						{
							_forcedAction = null;
						}
					}
					Target = null;
				}
				else if (CF2Input.GetMouseButtonDown(1))
				{
					Target = null;
				}
			}
			else
			{
				hideOutline(ref _targetOutline);
				hideMarker();
				hideSphere();
			}
		}
	}
}
