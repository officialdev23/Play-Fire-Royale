// DecompilerFi decompiler from Assembly-CSharp.dll class: IconPreview
// SourcesPostProcessor 
using UnityEngine;
using UnityEngine.UI;

public class IconPreview : MonoBehaviour
{
	public Sprite[] icons;

	private GameObject icon;

	private void Awake()
	{
		for (int i = 0; i < icons.Length; i++)
		{
			icon = new GameObject("icon" + i);
			icon.transform.SetParent(base.gameObject.transform);
			icon.AddComponent<RectTransform>();
			icon.AddComponent<Image>();
			icon.GetComponent<Image>().sprite = icons[i];
		}
	}

	private void Update()
	{
	}
}
