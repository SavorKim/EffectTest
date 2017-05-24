// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:7829,x:32837,y:32742,varname:node_7829,prsc:2|emission-3253-OUT;n:type:ShaderForge.SFN_NormalVector,id:144,x:29258,y:32216,prsc:2,pt:True;n:type:ShaderForge.SFN_Transform,id:7938,x:29447,y:32231,varname:node_7938,prsc:2,tffrom:0,tfto:3|IN-144-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8708,x:29630,y:32263,varname:node_8708,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7938-XYZ;n:type:ShaderForge.SFN_RemapRange,id:3103,x:29834,y:32263,varname:node_3103,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8708-OUT;n:type:ShaderForge.SFN_Tex2d,id:8212,x:30270,y:32389,varname:node_8212,prsc:2,ntxv:0,isnm:False|UVIN-3103-OUT,TEX-2505-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2505,x:29963,y:32573,ptovrint:False,ptlb:matMetal,ptin:_matMetal,varname:node_2505,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4226,x:30329,y:32642,varname:node_4226,prsc:2,ntxv:0,isnm:False|UVIN-3103-OUT,TEX-1555-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:1555,x:30060,y:32797,ptovrint:False,ptlb:matToon,ptin:_matToon,varname:node_1555,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4109,x:30454,y:32018,varname:node_4109,prsc:2,ntxv:0,isnm:False|UVIN-3131-UVOUT,TEX-5928-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:5928,x:30210,y:32108,ptovrint:False,ptlb:maskTex,ptin:_maskTex,varname:node_5928,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:1959,x:30790,y:32552,varname:node_1959,prsc:2|A-9344-OUT,B-548-OUT,T-4109-R;n:type:ShaderForge.SFN_TexCoord,id:3131,x:30210,y:31903,varname:node_3131,prsc:2,uv:0;n:type:ShaderForge.SFN_Multiply,id:9344,x:30528,y:32464,varname:node_9344,prsc:2|A-8212-RGB,B-2470-OUT;n:type:ShaderForge.SFN_Vector1,id:2470,x:30207,y:32549,varname:node_2470,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:2576,x:31115,y:32544,varname:node_2576,prsc:2|A-1959-OUT,B-8550-RGB,C-3328-OUT;n:type:ShaderForge.SFN_Tex2d,id:8550,x:30880,y:32249,varname:node_8550,prsc:2,ntxv:0,isnm:False|UVIN-3131-UVOUT,TEX-8801-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:8801,x:30499,y:32268,ptovrint:False,ptlb:diffuse,ptin:_diffuse,varname:node_8801,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3422,x:31381,y:32018,varname:node_3422,prsc:2|A-2576-OUT,B-8550-RGB,T-4109-G;n:type:ShaderForge.SFN_Lerp,id:2927,x:31864,y:32412,varname:node_2927,prsc:2|A-3422-OUT,B-9191-OUT,T-4109-B;n:type:ShaderForge.SFN_TexCoord,id:3318,x:31184,y:32828,varname:node_3318,prsc:2,uv:1;n:type:ShaderForge.SFN_Tex2d,id:6666,x:31568,y:32937,varname:node_6666,prsc:2,ntxv:0,isnm:False|UVIN-3318-UVOUT,TEX-5036-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:5036,x:31172,y:33051,ptovrint:False,ptlb:eyesTex,ptin:_eyesTex,varname:node_5036,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:3253,x:32456,y:32812,varname:node_3253,prsc:2|A-5874-OUT,B-6666-RGB,T-1400-OUT;n:type:ShaderForge.SFN_Multiply,id:548,x:30549,y:32664,varname:node_548,prsc:2|A-4226-RGB,B-2470-OUT;n:type:ShaderForge.SFN_Vector1,id:3328,x:30897,y:32691,varname:node_3328,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:6543,x:31826,y:32874,varname:node_6543,prsc:2|A-4109-A,B-6666-A;n:type:ShaderForge.SFN_Multiply,id:9191,x:31710,y:32654,varname:node_9191,prsc:2|A-6426-OUT,B-8550-RGB;n:type:ShaderForge.SFN_Vector1,id:6426,x:31480,y:32707,varname:node_6426,prsc:2,v1:4;n:type:ShaderForge.SFN_Multiply,id:622,x:31969,y:32978,varname:node_622,prsc:2|A-6543-OUT,B-6666-A;n:type:ShaderForge.SFN_Multiply,id:1400,x:32321,y:33024,varname:node_1400,prsc:2|A-152-OUT,B-6869-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6869,x:32159,y:33247,ptovrint:False,ptlb:Emission_Power,ptin:_Emission_Power,varname:node_6869,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Multiply,id:152,x:32134,y:32991,varname:node_152,prsc:2|A-622-OUT,B-7446-RGB;n:type:ShaderForge.SFN_Color,id:7446,x:31835,y:33195,ptovrint:False,ptlb:Emission_Color,ptin:_Emission_Color,varname:node_7446,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Lerp,id:5874,x:32317,y:32211,varname:node_5874,prsc:2|A-2927-OUT,B-1657-OUT,T-8550-A;n:type:ShaderForge.SFN_Multiply,id:1657,x:32027,y:32083,varname:node_1657,prsc:2|A-5601-RGB,B-2927-OUT;n:type:ShaderForge.SFN_Color,id:5601,x:31804,y:31988,ptovrint:False,ptlb:Body_Color,ptin:_Body_Color,varname:node_5601,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.2551723,c3:1,c4:1;proporder:2505-1555-5928-8801-5036-6869-7446-5601;pass:END;sub:END;*/

Shader "SDR/SDR_CHR_Monster_S" {
    Properties {
        _matMetal ("matMetal", 2D) = "white" {}
        _matToon ("matToon", 2D) = "white" {}
        _maskTex ("maskTex", 2D) = "white" {}
        _diffuse ("diffuse", 2D) = "white" {}
        _eyesTex ("eyesTex", 2D) = "white" {}
        _Emission_Power ("Emission_Power", Float ) = 2
        _Emission_Color ("Emission_Color", Color) = (1,0,0,1)
        _Body_Color ("Body_Color", Color) = (0,0.2551723,1,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _matMetal; uniform float4 _matMetal_ST;
            uniform sampler2D _matToon; uniform float4 _matToon_ST;
            uniform sampler2D _maskTex; uniform float4 _maskTex_ST;
            uniform sampler2D _diffuse; uniform float4 _diffuse_ST;
            uniform sampler2D _eyesTex; uniform float4 _eyesTex_ST;
            uniform float _Emission_Power;
            uniform float4 _Emission_Color;
            uniform float4 _Body_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float2 node_3103 = (mul( UNITY_MATRIX_V, float4(normalDirection,0) ).xyz.rgb.rg*0.5+0.5);
                float4 node_8212 = tex2D(_matMetal,TRANSFORM_TEX(node_3103, _matMetal));
                float node_2470 = 2.0;
                float4 node_4226 = tex2D(_matToon,TRANSFORM_TEX(node_3103, _matToon));
                float4 node_4109 = tex2D(_maskTex,TRANSFORM_TEX(i.uv0, _maskTex));
                float4 node_8550 = tex2D(_diffuse,TRANSFORM_TEX(i.uv0, _diffuse));
                float3 node_2927 = lerp(lerp((lerp((node_8212.rgb*node_2470),(node_4226.rgb*node_2470),node_4109.r)+node_8550.rgb+(-1.0)),node_8550.rgb,node_4109.g),(4.0*node_8550.rgb),node_4109.b);
                float4 node_6666 = tex2D(_eyesTex,TRANSFORM_TEX(i.uv1, _eyesTex));
                float3 emissive = lerp(lerp(node_2927,(_Body_Color.rgb*node_2927),node_8550.a),node_6666.rgb,((((node_4109.a*node_6666.a)*node_6666.a)*_Emission_Color.rgb)*_Emission_Power));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
