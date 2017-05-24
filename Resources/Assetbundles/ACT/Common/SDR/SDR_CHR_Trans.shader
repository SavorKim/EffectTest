// Savor Shader -  2017- Kim SangWon
//
// Inspired by SDR_CHR 

// Made by SavorK(Shabel@netsgo.com)

Shader "SDR/SDR_CHR_RIM_Trans" {

	Properties{

		_MainColor("Main Color", Color) = (0.5,0.5,0.5,0.5)
		_RimColor("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_RimPower("Rim Power", Range(0.0,5.0)) = 2.5
		_RimMul("Rim Mul", Range(-3.0,5.0)) = 1.0
		_OutMul("Out Mul", Range(-3.0,5.0)) = 1.0
		_Distort("Distort", float) = .3
		 _matMetal("matMetal", 2D) = "white" {}
		_matToon("matToon", 2D) = "white" {}
		_maskTex("maskTex", 2D) = "white" {}
		_diffuse("diffuse", 2D) = "white" {}
		_eyesTex("eyesTex", 2D) = "white" {}
		_mouthTex("mouthTex", 2D) = "white" {}
		_InnerBright("Inner Bright", float) = .5
		_LColor("Line Color", Color) = (0,0,0,1)
		_Depth("Line Width", float) = 0.01
	}


		SubShader{
			Tags {
				 "RenderType" = "Transparent" "Queue" = "Transparent"
			}
			LOD 200

			Pass{
					Name "Zbuffer"
					Blend SrcAlpha OneMinusSrcAlpha

					Zwrite On
					CGPROGRAM

					#pragma vertex vert
					#pragma fragment frag
					struct VertexInput {
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					
					};

					struct VertexOutput {
						float4 pos : SV_POSITION;
						float4 posWorld : TEXCOORD3;
						float3 normalDir : TEXCOORD4;
						float3 lightDir : TEXCOORD5;
						float3 worldRefl: TEXCOORD6;

					};

					VertexOutput vert(VertexInput v) {
						VertexOutput o = (VertexOutput)0;
						//			o.normalDir = UnityObjectToWorldNormal(v.normal);
									o.posWorld = mul(unity_ObjectToWorld, v.vertex);
									o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
									//			UNITY_TRANSFER_FOG(o, o.pos);
												return o;
											}


					float4 frag(VertexOutput i) : COLOR{
												return (0,0,0,0);
										}
						ENDCG

					}


											
			Pass {
					Name "FORWARD"
					Tags {"LightMode"="ForwardBase"}

					//Blend SrcAlpha OneMinusSrcAlpha
					Blend DstColor SrcColor // 2x Multiplicative
												Cull back

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

													float3 emissive = node_8550.rgb + node_8212.rgb * node_8550.a;

													float3 finalColor = (emissive ) * _MainColor - rim2 * 3 * _OutMul;
													float3 finalColor2 = lerp(finalColor + rimCol * _RimMul, node_6666.rgb, node_6666.a* node_4109.a);
													float3 finalColor3 = lerp(finalColor2, node_5438.rgb, node_5438.a* node_4109.a);
													fixed4 finalRGBA = fixed4(finalColor3 + Screen.rgb , _MainColor.a) ;
													UNITY_APPLY_FOG(i.fogCoord, finalRGBA);

													return finalRGBA;
													}

													
												ENDCG
											 }

						 }


			//FallBack "Transparent/Diffuse"

		
}