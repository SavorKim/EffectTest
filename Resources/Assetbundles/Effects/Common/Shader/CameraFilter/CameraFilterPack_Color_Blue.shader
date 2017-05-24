﻿////////////////////////////////////////////////////////////////////////////////////
//  Savor (Sangwon.kim) fixed             //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

Shader"CameraFilter/Color_Blue" {
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		//_TimeX ("Time", Range(0.0, 1.0)) = 1.0
		//_Distortion ("_Distortion", Range(0.0, 1.00)) = 1.0
		_ScreenResolution ("_ScreenResolution", Vector) = (0.,0.,0.,0.)
	}
	SubShader 
	{
		Pass
		{
			ZTest Always
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#include "UnityCG.cginc"
			
			
			uniform sampler2D _MainTex;
			//uniform float _TimeX;
			//uniform float _Distortion;
			uniform float4 _ScreenResolution;
			
		       struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f
            {
                  half2 texcoord  : TEXCOORD0;
                  float4 vertex   : SV_POSITION;
                  fixed4 color    : COLOR;
           };   
             
  			v2f vert(appdata_t IN)
            {
                v2f OUT;
                OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
                OUT.texcoord = IN.texcoord;
                OUT.color = IN.color;
                
                return OUT;
            }
            

float4 frag (v2f i) : COLOR
{
	float3 r= tex2D(_MainTex, i.texcoord.xy).rgb;
	r.b = dot(r.rgb, float3(0.75f, 0.96f, 0.68f));
	r.g = dot(r.rgb, float3(0.25f, 0.5f, 0.2f));
	r.r = dot(r.rgb, float3(0.15f, 0.35f, 0.1f));


    return float4(r*.85, 1);
}
			
			ENDCG
		}
		
	}
}