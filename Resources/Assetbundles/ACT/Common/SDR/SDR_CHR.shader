// Savor Shader -  2017- Kim SangWon
//
// Inspired by SDR_CHR 

// Made by SavorK(Shabel@netsgo.com)

Shader "SDR/SDR_CHR_RIM" {

	Properties{

		_MainColor("Main Color", Color) = (0.5,0.5,0.5,0.5)
		_RimColor("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_RimPower("Rim Power", Range(0.0,5.0)) = 2.5
		_RimMul("Rim Mul", Range(-3.0,5.0)) = 1.0
		_OutMul("Out Mul", Range(-3.0,5.0)) = 1.0
		_Distort("Distort", float) = .3
		 _matMetal ("matMetal", 2D) = "white" {}
		_matToon("matToon", 2D) = "white" {}
		_maskTex("maskTex", 2D) = "white" {}
		_diffuse("diffuse", 2D) = "white" {}
		_eyesTex("eyesTex", 2D) = "white" {}
		_mouthTex("mouthTex", 2D) = "white" {}
		_InnerBright("Inner Bright", float) = .5
		_LColor("Line Color", Color) = (0,0,0,1)
		_Depth("Line Width", float) = 0.01
	}


    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 200


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
			#pragma multi_compile _ PIXELSNAP_ON

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
				float3 vEye			: TEXCOORD2;

			};

			sampler2D 	_diffuse;
			float4 _LColor;

			uniform float _Depth;
			uniform float _SpecBright;

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//VS
			vert_out vert(vert_in v)
			{
				vert_out o;

				//Move Position
				float3 vNorm = normalize(v.normal);
				o.vEye = _WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
				float EyeSize = length(o.vEye);
				float4 vNewPos = v.vertex + ((float4(vNorm.xyz, 0.0f) * EyeSize) * _Depth * 0.01f);
				//float4 vNewPos = v.vertex + (float4(vNorm.xyz, 0.0f) * _Depth * 0.1f);
				o.pos = mul(UNITY_MATRIX_MVP, vNewPos);

				o.uv = v.uv;
				o.color = v.color;




				return o;
			}

			//:::::::::::::::::::::::::::::::::::::::::::::::::::::::
			//PS
			fixed4 frag(vert_out i) : SV_Target
			{
				float4 Tex = tex2D(_diffuse, i.uv);
				float4 vAlbedo = lerp(_LColor , Tex,0.3);
				vAlbedo.a = Tex.a;
				return vAlbedo; //* _SpecBright;
			}
				ENDCG

			} // pass1 End




        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#define UNITY_PASS_FORWARDBASE
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#pragma multi_compile_fog
			#pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
			#pragma target 3.0

			float4 _MainColor;
			float4 _RimColor;
			float _RimPower;
			float _RimMul; 
			float _OutMul;
			float _Distort;
			uniform sampler2D _matMetal; uniform float4 _matMetal_ST;
			uniform sampler2D _matToon; uniform float4 _matToon_ST;
			uniform sampler2D _maskTex; uniform float4 _maskTex_ST;
			uniform sampler2D _diffuse; uniform float4 _diffuse_ST;
			uniform sampler2D _eyesTex; uniform float4 _eyesTex_ST;
			uniform sampler2D _mouthTex; uniform float4 _mouthTex_ST;

			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;

				float2 texcoord0 : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				


			};

			struct VertexOutput {
				float4 pos : SV_POSITION;
				float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
				float2 uv2 : TEXCOORD2;
				float4 posWorld : TEXCOORD3;
				float3 normalDir : TEXCOORD4;				
				float3 lightDir : TEXCOORD5;
				float3 worldRefl: TEXCOORD6;
				float4 	screenPos: TEXCOORD7;
				float3 vEye		 : TEXCOORD8;
				UNITY_FOG_COORDS(5)
				
			};

	VertexOutput vert(VertexInput v) {
				VertexOutput o = (VertexOutput)0;
				o.uv0 = v.texcoord0;
				o.uv1 = v.texcoord1;
				o.uv2 = v.texcoord2;
				
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);

				

				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.screenPos = ComputeScreenPos(o.pos);
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;


			}

	float4 frag(VertexOutput i, float facing : VFACE) : COLOR{

			

			float isFrontFace = (facing >= 0 ? 1 : 0);
			float faceSign = (facing >= 0 ? 1 : -1);
			
			i.normalDir = normalize(i.normalDir);
			i.normalDir *= faceSign;
			float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
			//fixed3 worldRefl = normalize(WorldReflectionVector(i, i.normalDir));

			float3 normalDirection = i.normalDir;
			half3 h = normalize(i.lightDir + viewDirection); //half Vector
			float nh = max(0, dot(i.normalDir, h));
			float spec = pow(nh, 148);

			float _pSin = (abs(2 * (fmod((_Time.y *4 - .5), 1) - .49)))* _Distort;

			half rim = pow(1 - saturate(dot(viewDirection, normalDirection)), _RimPower);

			half rim2 = pow(rim, _RimPower * 4);
			rim2 *= 4* nh;

			half3 rimCol = _RimColor.rgb * rim  * _pSin;
			half3 rimCol2 = (1-_RimColor.rgb) * rim2 * _pSin;
			

			////// Lighting:
			////// Emissive:
			float2 node_3103 = (mul(UNITY_MATRIX_V, float4(normalDirection,0)).xyz.rgb.rg*0.5 + 0.5); //Half Lambert
			node_3103.r += spec;
			float4 node_8212 = tex2D(_matToon,TRANSFORM_TEX(node_3103, _matMetal));
		  //float node_2470 = 2.0;
			float4 node_4226 = tex2D(_matToon,TRANSFORM_TEX(node_3103, _matToon));
			float4 node_4109 = tex2D(_maskTex,TRANSFORM_TEX(i.uv0, _maskTex));
			float4 node_8550 = tex2D(_diffuse,TRANSFORM_TEX(i.uv0, _diffuse));
			float4 node_6666 = tex2D(_eyesTex,TRANSFORM_TEX(i.uv1, _eyesTex));
			float4 node_5438 = tex2D(_mouthTex,TRANSFORM_TEX(i.uv2, _mouthTex));
			//float3 emissive = lerp(lerp(lerp(lerp((lerp((node_4226.rgb*2.0),(node_4226.rgb*2.0),node_4109.r) + node_8550.rgb + (-1.0)),node_8550.rgb,node_4109.g),(4.0*node_8550.rgb),node_4109.b),node_6666.rgb,(node_4109.a*node_6666.a)),node_5438.rgb,(node_4109.a*node_5438.a));
			/*float3 emissive = 
								  lerp(
									lerp(
									  (lerp((node_8212.rgb), (node_4226.rgb), node_8550.a) + node_8550.rgb + (-1.0)), node_8550.rgb, node_8550.a)
										, (4.0*node_8550.rgb)
											, node_8550.a);
			*/
			float3 emissive = node_8550.rgb + node_8212.rgb * node_8550.a;
			
			float3 finalColor = (emissive ) * _MainColor - rim2 * 3 * _OutMul;
			float3 finalColor2 = lerp(finalColor + rimCol * _RimMul, node_6666.a*node_6666.rgb , node_6666.a* node_4109.a);
			float3 finalColor3 = lerp(finalColor2, node_5438.a*node_5438.rgb, node_5438.a* node_4109.a);
			

			#if UNITY_UV_STARTS_AT_TOP
						half grabSign = -_ProjectionParams.x;
			#else
						half grabSign = _ProjectionParams.x;
			#endif
			i.screenPos = half4(i.screenPos.xy / i.screenPos.w, 0, 0);
			i.screenPos.y *= _ProjectionParams.x;

			//float3 CameraVector = _WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
			//float EyeSize = length(CameraVector);
			//half2 sceneUVs = (half2(1, -grabSign) * i.screenPos.xy * 0.5 + 0.5) * 2 / pow(EyeSize,2) *float2(8,6);
			half2 sceneUVs = (half2(1, -grabSign) * i.screenPos.xy * 0.5 + 0.5) * 2 ;
			
			half4 sceneColor = tex2D(_matMetal, sceneUVs) ;


/*
			float2 uv_MatrixTex = i.screenPos.xy / i.screenPos.w ;
			//uv_MatrixTex *= float2(8, 6);
			float4 Screen = tex2D(_matMetal, uv_MatrixTex);
	*/		
			
			fixed4 finalRGBA = fixed4(finalColor3, node_8550.a) * sceneColor;
			UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
			return finalRGBA;
			}

		ENDCG
        }
    }
    FallBack "Diffuse"
   // CustomEditor "ShaderForgeMaterialInspector"
}
