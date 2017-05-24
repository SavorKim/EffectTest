// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'


//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// @Author : Julius Onesimus. Feb 2016
// @Brief  : Customized Anime shading, for softer and CG-like graphics 
// @Warning :
//
//	CREATIVE COMMONS LICENSE : Attribution-NoDerivs (CC BY-ND)
//
//	This license allows for redistribution, COMMERCIAL & NON-COMMERCIAL 
//	as long as it is passed along unchanged and in whole, 
//	WITH CREDIT TO THE AUTHOR (Julius Onesimus) !!!
// 
//  Legal Code : https://creativecommons.org/licenses/by-nd/4.0/legalcode
//
//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Shader "OmniCustom/Omni Anime" 
{
	Properties
	{
		_MainTex ("Main Texture", 2D) 	= "white" {}

		_Softness( "Diffuse Softness", Range(0.0, 1.0) ) 			= 0.0

		_SpecShine( "Specular Shininess", Range( 1.0, 100.0 ) ) 	= 18.0
		_SpecBright( "Specular Brightness", Range( 1.0, 5.0 ) )		= 2.0
		_SpecSoft( "Specular Softness", Range(0.0, 1.0) ) 			= 0.0

		_LineThick( "Outline Thickness", Range(0.0, 5.0) )			= 1.0
	}
	SubShader
	{
		Tags { "Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque" "LightMode"="ForwardBase" }
        

        ZTest LEqual 
        ZWrite On 
        Fog { Mode Off }
        Blend SrcAlpha OneMinusSrcAlpha

        //***********************************************************************************
        // PASS 1 : Outline
        //***********************************************************************************
        Pass
		{
			Cull Front 
			Lighting Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			//#include "AutoLight.cginc"

			struct vert_in
			{
				float4 vertex : POSITION;
				float4 color  : COLOR;
				float3 normal : NORMAL;
				float2 uv 	  : TEXCOORD0;
			};

			struct vert_out
			{
				float4 pos 			: SV_POSITION;
				float4 color  		: COLOR;
				float2 uv 			: TEXCOORD0;
			};

			sampler2D 	_MainTex;
			float4 		_MainTex_ST;

			uniform float _LineThick;
			uniform float _SpecBright;

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//VS
			vert_out vert (vert_in v)
			{
				vert_out o;

				//Move Position
				float3 vNorm	= normalize( v.normal );
				float4 vNewPos  = v.vertex + (float4( vNorm.xyz, 0.0f ) * _LineThick * 0.01f);
				o.pos 			= mul(UNITY_MATRIX_MVP, vNewPos);

				o.uv 			= TRANSFORM_TEX(v.uv, _MainTex);
				o.color			= v.color;

				return o;
			}

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//PS
			fixed4 frag (vert_out i) : SV_Target
			{
				float4 vAlbedo = tex2D( _MainTex, i.uv );
				return vAlbedo * _SpecBright;
			}
			ENDCG
		}

        //***********************************************************************************
        // PASS 2 : The Model
        //***********************************************************************************
		Pass
		{
			Cull Back 

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			struct vert_in
			{
				float4 vertex : POSITION;
				float4 color  : COLOR;
				float3 normal : NORMAL;
				float2 uv 	  : TEXCOORD0;
			};

			struct vert_out
			{
				float4 pos 			: SV_POSITION;
				float4 color  		: COLOR;
				float2 uv 			: TEXCOORD0;
				float3 normal		: TEXCOORD1;
				float3 vEye			: TEXCOORD2;

				LIGHTING_COORDS(3,4)
			};

			sampler2D 	_MainTex;
			float4 		_MainTex_ST;

			uniform float _Softness;
			uniform float _SpecShine;
			uniform float _SpecSoft;
			uniform float _SpecBright;

			uniform fixed4 _LightColor0;

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//VS
			vert_out vert (vert_in v)
			{
				vert_out o;

				o.pos 			= mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv 			= TRANSFORM_TEX(v.uv, _MainTex);
				o.color			= v.color;

				//Rotate Normal based on Model!
				float4x4 mRot = unity_ObjectToWorld;
				float4 vNormal = mul(unity_ObjectToWorld, float4(v.normal.xyz, 0.0f));
				o.normal = vNormal.xyz;

				//Eye
				o.vEye = normalize( _WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0,0,0,1)) );

				TRANSFER_VERTEX_TO_FRAGMENT(o);

				return o;
			}

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//PS
			fixed4 frag (vert_out i) : SV_Target
			{
				//Normal
				float3 vNormal 	= normalize( i.normal );

				//Light
				float3 vL = normalize(_WorldSpaceLightPos0.xyz);

				//Albedo
				float4 vAlbedo = tex2D( _MainTex, i.uv );

				//-------------------------------------------------
				float NdL = dot( vL, vNormal );
				NdL 		= max( 0.0f, NdL );

				float fShad = LIGHT_ATTENUATION(i);
				NdL *= fShad;
				NdL = smoothstep( 0.45f- _Softness, 0.45f + _Softness, NdL );

				//-------------------------------------------------
				float4 vAmb = float4(NdL, NdL, NdL, 1.0f) + vAlbedo;
				vAmb.xyz = min( 1.0f, vAmb.xyz );

				//-------------------------------------------------
				float4 vDiff = vAmb * _LightColor0;

				//-------------------------------------------------
				float3 vH 	= normalize( vL +  i.vEye );
				float fSpec = max( 0.0f, dot( vNormal, vH ) ); 
				fSpec		= pow( fSpec , _SpecShine );

				fSpec   = smoothstep( 0.45f- _SpecSoft, 0.45f + _SpecSoft, fSpec );
				fSpec	= lerp( fSpec * 0.5f , fSpec, fShad );

				//-------------------------------------------------
				//FINALE
				float4 vFinale = float4(0,0,0,1);

				vFinale = lerp( vAlbedo * vDiff, vAlbedo * _SpecBright, fSpec );

				return vFinale;
			}
			ENDCG
		}

	}
	Fallback "VertexLit"
}
