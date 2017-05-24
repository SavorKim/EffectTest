// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:7829,x:32837,y:32742,varname:node_7829,prsc:2|emission-5564-OUT;n:type:ShaderForge.SFN_NormalVector,id:144,x:29258,y:32216,prsc:2,pt:True;n:type:ShaderForge.SFN_Transform,id:7938,x:29447,y:32231,varname:node_7938,prsc:2,tffrom:0,tfto:3|IN-144-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8708,x:29630,y:32263,varname:node_8708,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7938-XYZ;n:type:ShaderForge.SFN_RemapRange,id:3103,x:29834,y:32263,varname:HRambert,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8708-OUT;n:type:ShaderForge.SFN_Tex2d,id:8212,x:30270,y:32389,varname:node_8212,prsc:2,tex:ced8cc17c25fe9047bd35cf440d84e75,ntxv:0,isnm:False|UVIN-3103-OUT,TEX-2505-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2505,x:29963,y:32573,ptovrint:False,ptlb:matMetal,ptin:_matMetal,varname:node_2505,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ced8cc17c25fe9047bd35cf440d84e75,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4226,x:30329,y:32642,varname:RampMap,prsc:2,tex:8be57ed89110c484d91591ec2f79bff5,ntxv:0,isnm:False|UVIN-3103-OUT,TEX-1555-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:1555,x:30060,y:32797,ptovrint:False,ptlb:matToon,ptin:_matToon,varname:node_1555,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8be57ed89110c484d91591ec2f79bff5,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4109,x:30454,y:32018,varname:MaskMap,prsc:2,tex:3fca3cee3e498af46bfaa7a59f4b9f85,ntxv:0,isnm:False|UVIN-3131-UVOUT,TEX-5928-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:5928,x:30193,y:32103,ptovrint:False,ptlb:maskTex,ptin:_maskTex,varname:node_5928,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3fca3cee3e498af46bfaa7a59f4b9f85,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:1959,x:30790,y:32552,varname:node_1959,prsc:2|A-9344-OUT,B-548-OUT,T-4109-R;n:type:ShaderForge.SFN_TexCoord,id:3131,x:30210,y:31903,varname:node_3131,prsc:2,uv:0;n:type:ShaderForge.SFN_Multiply,id:9344,x:30528,y:32464,varname:node_9344,prsc:2|A-8212-RGB,B-2470-OUT;n:type:ShaderForge.SFN_Vector1,id:2470,x:30207,y:32549,varname:node_2470,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:2576,x:31115,y:32544,varname:node_2576,prsc:2|A-1959-OUT,B-8550-RGB,C-3328-OUT;n:type:ShaderForge.SFN_Tex2d,id:8550,x:30923,y:32277,varname:DiffuseMap,prsc:2,tex:aaf11b3f9a3f46c41b36af04c3c8a9c4,ntxv:0,isnm:False|UVIN-3131-UVOUT,TEX-8801-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:8801,x:30695,y:32332,ptovrint:False,ptlb:diffuse,ptin:_diffuse,varname:node_8801,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:aaf11b3f9a3f46c41b36af04c3c8a9c4,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3422,x:31481,y:32303,varname:node_3422,prsc:2|A-2576-OUT,B-8550-RGB,T-4109-G;n:type:ShaderForge.SFN_Lerp,id:2927,x:31970,y:32609,varname:node_2927,prsc:2|A-3422-OUT,B-9191-OUT,T-4109-B;n:type:ShaderForge.SFN_TexCoord,id:3318,x:31184,y:32828,varname:node_3318,prsc:2,uv:1;n:type:ShaderForge.SFN_TexCoord,id:3346,x:31616,y:33144,varname:node_3346,prsc:2,uv:2;n:type:ShaderForge.SFN_Tex2d,id:6666,x:31568,y:32937,varname:EyeMap,prsc:2,tex:c5a9039dddf8d2044b5da3bd7c29a8cf,ntxv:0,isnm:False|UVIN-3318-UVOUT,TEX-5036-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:5036,x:31189,y:32989,ptovrint:False,ptlb:eyesTex,ptin:_eyesTex,varname:node_5036,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c5a9039dddf8d2044b5da3bd7c29a8cf,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5438,x:31915,y:33177,varname:MouthMap,prsc:2,tex:6c65b6b258eec254f903970f6131e7ce,ntxv:0,isnm:False|UVIN-3346-UVOUT,TEX-2008-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2008,x:31586,y:33357,ptovrint:False,ptlb:mouthTex,ptin:_mouthTex,varname:node_2008,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6c65b6b258eec254f903970f6131e7ce,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3253,x:32373,y:32830,varname:node_3253,prsc:2|A-2927-OUT,B-6666-RGB,T-6543-OUT;n:type:ShaderForge.SFN_Lerp,id:5564,x:32646,y:32901,varname:node_5564,prsc:2|A-3253-OUT,B-5438-RGB,T-6829-OUT;n:type:ShaderForge.SFN_Multiply,id:548,x:30549,y:32664,varname:node_548,prsc:2|A-4226-RGB,B-2470-OUT;n:type:ShaderForge.SFN_Vector1,id:3328,x:30897,y:32691,varname:node_3328,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:6543,x:31826,y:32874,varname:node_6543,prsc:2|A-4109-A,B-6666-A;n:type:ShaderForge.SFN_Multiply,id:6829,x:32245,y:33123,varname:node_6829,prsc:2|A-4109-A,B-5438-A;n:type:ShaderForge.SFN_Multiply,id:9191,x:31710,y:32654,varname:node_9191,prsc:2|A-6426-OUT,B-8550-RGB;n:type:ShaderForge.SFN_Vector1,id:6426,x:31480,y:32707,varname:node_6426,prsc:2,v1:4;proporder:2505-1555-5928-8801-5036-2008;pass:END;sub:END;*/

Shader "SavorK/CHR_Toon_Savor" {

    Properties {

		_MainColor("Main Color", Color) = (0.5,0.5,0.5,0.5)
		_RimColor("Rim Color", Color) = (0.5,0.5,0.5,0.5)
		_RimPower("Rim Power", Range(0.0,5.0)) = 2.5
		_RimMul("Rim Mul", Range(-3.0,5.0)) = 1.0
		_OutMul("Out Mul", Range(-3.0,5.0)) = 1.0
       // _matMetal ("matMetal", 2D) = "white" {}
        _matToon ("matToon", 2D) = "white" {}
        _maskTex ("maskTex", 2D) = "white" {}
        _diffuse ("diffuse", 2D) = "white" {}
        _eyesTex ("eyesTex", 2D) = "white" {}
        _mouthTex ("mouthTex", 2D) = "white" {}
		_InnerBright("Inner Bright", float) = .5
		_LColor("Line Color", Color) = (0,0,0,1)
		_Depth("Line Width", float) = 0.01
		[MaterialToggle] _OutLine("OutLine", Float) = 0

    }		

	SubShader {
			
			Tags{
			"RenderType" = "Opaque"
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
				o.pos = mul(UNITY_MATRIX_MVP, vNewPos);

				o.uv = v.uv;
				o.color = v.color;


				//o.vEye = normalize(_WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0, 0, 0, 1)));

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



			
			//***********************************************************************************
			// PASS 2 : Front face
			//***********************************************************************************

		Pass {
				Name "FORWARD"
				
			// Lighting Off

			//Cull Back
			
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

			half rim = pow(1 - saturate(dot(viewDirection, normalDirection)), _RimPower);
			half rim2 = pow(rim, _RimPower * 4);
			half3 rimCol = _RimColor.rgb * rim;
			half3 rimCol2 = (1 - _RimColor.rgb) * rim2;


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

			float3 finalColor = (emissive)* _MainColor - rim2 * 3 * _OutMul;
			float3 finalColor2 = lerp(finalColor + rimCol * _RimMul, node_6666.rgb, node_6666.a* node_4109.a);
			float3 finalColor3 = lerp(finalColor2, node_5438.rgb, node_5438.a* node_4109.a);
			fixed4 finalRGBA = fixed4(finalColor3 , node_8550.a);
			UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
			return finalRGBA;
			}

				ENDCG

			} //pass2 End
		} //SubShader End

	FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"

} //Shader End


