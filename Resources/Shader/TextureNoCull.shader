//-----------------------------------------------------------------
/*!
    @file   TextureColor

    @brief  Unlit + Texture + Color のシェーダー

    @author Drecom Co.,Ltd.

    Copyright(C) Drecom Co., Ltd. All rights reserved.
*/
//-----------------------------------------------------------------
Shader "sphere/TextureNoCull"
{
	Properties
	{
		_MainTex ("Texture", 2D) 	= "white" {}
		_Color ("Color", Color) 	= (1,1,1,1)
	}
	SubShader
	{

		ColorMask RGB
		Cull Off
		Tags { "RenderType"="Opaque" "LightMode"="ForwardBase" }
		
		Pass
		{
			CGPROGRAM
			#pragma vertex 		vert
			#pragma fragment 	frag
			
			#include "UnityCG.cginc"
			
			sampler2D 	_MainTex;
			float4 		_MainTex_ST;
			
			fixed4		_Color;
			
			struct VertexInput
			{
				float4 vertex 	: POSITION;
				float2 uv 		: TEXCOORD0;
			};

			struct FragmentInput
			{
				float4 vertex 	: SV_POSITION;
				float2 uv 		: TEXCOORD0;
			};

			//==========================
            // Vertex Shader
            //==========================
			FragmentInput vert (VertexInput v)
			{
				FragmentInput o;
				o.vertex 	= mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv 		= TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			//==========================
            // Fragment Shader
            //==========================
			fixed4 frag (FragmentInput i) : SV_Target
			{
				fixed4 col 	= tex2D(_MainTex, i.uv) * _Color;
				return col;
			}
			ENDCG
		}
	}
}
