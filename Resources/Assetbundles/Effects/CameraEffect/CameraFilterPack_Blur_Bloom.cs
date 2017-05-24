// This shader is edited and fixed by Savor Kim (shabel@netsgo.com) at 07 06 2016 with CameraFilterPack.
// image effect with Bloom and Blur
// This is a little heavy for mobile devices, it makes devices more 10frames slower than ever at Galaxy s3.
using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
//[AddComponentMenu ("Camera Filter Pack/Blur/Bloom")]

public class CameraFilterPack_Blur_Bloom : MonoBehaviour {
#region Variables
	public Shader SCShader;
	//private float TimeX = 1.0f;
	private Vector4 ScreenResolution;
	private Material SCMaterial;
	[Range(0.0f, 3.0f)]
	public float Blur = 2.5f;
	[Range(0.5f, 2.0f)]
	public float Bloom = 1.0f;

	public static float ChangeAmount;
	public static float ChangeGlow;
#endregion

#region Properties
	Material material
	{
		get
		{
			if(SCMaterial == null)
			{
				SCMaterial = new Material(SCShader);
				SCMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return SCMaterial;
		}
	}
#endregion

	void Start ()
	{
		ChangeAmount = Blur;
		ChangeGlow = Bloom;

		SCShader = Shader.Find("CameraFilterPack/Blur_Bloom");

		if(!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}
	}

	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
	{
		if(SCShader != null)
		{
			//TimeX+=Time.deltaTime;
			//if (TimeX>100)  TimeX=0;
			//material.SetFloat("_TimeX", TimeX);
			material.SetFloat("_Amount", Blur);
			material.SetFloat("_Glow", Bloom);
			material.SetVector("_ScreenResolution",new Vector2(Screen.width,Screen.height));
			Graphics.Blit(sourceTexture, destTexture, material);
		}
		else
		{
			Graphics.Blit(sourceTexture, destTexture);
		}
	}

	void OnValidate()
	{
		ChangeAmount = Blur;
		ChangeGlow = Bloom;
	}

	public void SetBlur(float blur)
	{
		ChangeAmount = blur;
	}

/*
	void Update ()
 	{
		if (Application.isPlaying)
		{
			Blur = ChangeAmount;
			Bloom = ChangeGlow;
		}

#if UNITY_EDITOR
		if (Application.isPlaying!=true)
		{
			SCShader = Shader.Find("CameraFilterPack/Blur_Bloom");
		}
#endif
	}
*/

	void OnDisable ()
	{
		if(SCMaterial)
		{
			DestroyImmediate(SCMaterial);
		}
	}
}
