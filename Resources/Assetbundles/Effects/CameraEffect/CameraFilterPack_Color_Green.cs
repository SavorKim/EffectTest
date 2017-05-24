////////////////////////////////////////////////////////////////////////////////////
//  Savor (Sangwon.kim) fixed             //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
//[AddComponentMenu ("Camera Filter Pack/Colors_Green")]

public class CameraFilterPack_Color_Green : MonoBehaviour {
	#region Variables
	public Shader SCShader;
	//private float TimeX = 1.0f;
	private Vector4 ScreenResolution;
	private Material SCMaterial;

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
        if(!SCShader)
		SCShader = Shader.Find("CameraFilter/Color_Green");

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
			material.SetVector("_ScreenResolution",new Vector4(sourceTexture.width,sourceTexture.height,0.0f,0.0f));
			Graphics.Blit(sourceTexture, destTexture, material);
		}
		else
		{
			Graphics.Blit(sourceTexture, destTexture);	
		}
		
		
	}
	
	
	void OnDisable ()
	{
		if(SCMaterial)
		{
			DestroyImmediate(SCMaterial);	
		}
		
	}
	
	
}