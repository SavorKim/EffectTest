// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:7479,x:32719,y:32712,varname:node_7479,prsc:2|emission-5940-OUT,alpha-9104-A;n:type:ShaderForge.SFN_Tex2d,id:9104,x:32261,y:32715,varname:node_9104,prsc:2,ntxv:0,isnm:False|UVIN-2669-UVOUT,TEX-4775-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:4775,x:32055,y:32890,ptovrint:False,ptlb:Alpha_Tex,ptin:_Alpha_Tex,varname:node_4775,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:2669,x:32066,y:32575,varname:node_2669,prsc:2,uv:0;n:type:ShaderForge.SFN_NormalVector,id:4127,x:31460,y:33053,prsc:2,pt:True;n:type:ShaderForge.SFN_Transform,id:5431,x:31677,y:33053,varname:node_5431,prsc:2,tffrom:0,tfto:3|IN-4127-OUT;n:type:ShaderForge.SFN_ComponentMask,id:7022,x:31862,y:33074,varname:node_7022,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5431-XYZ;n:type:ShaderForge.SFN_RemapRange,id:4752,x:32046,y:33074,varname:node_4752,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-7022-OUT;n:type:ShaderForge.SFN_Tex2d,id:3110,x:32247,y:32964,varname:node_3110,prsc:2,ntxv:0,isnm:False|UVIN-4752-OUT,TEX-2695-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:2695,x:32337,y:33186,ptovrint:False,ptlb:node_2695,ptin:_node_2695,varname:node_2695,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4196,x:32450,y:32845,varname:node_4196,prsc:2|A-2835-OUT,B-3110-RGB;n:type:ShaderForge.SFN_Vector1,id:2835,x:32450,y:33059,varname:node_2835,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:5940,x:32519,y:32538,varname:node_5940,prsc:2|A-9104-RGB,B-4196-OUT,C-7045-OUT;n:type:ShaderForge.SFN_Vector1,id:7045,x:32416,y:32636,varname:node_7045,prsc:2,v1:-1;proporder:4775-2695;pass:END;sub:END;*/

Shader "SDR/SDR_CHR_Alpha" {
    Properties {
        _Alpha_Tex ("Alpha_Tex", 2D) = "white" {}
        _node_2695 ("node_2695", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            uniform sampler2D _Alpha_Tex; uniform float4 _Alpha_Tex_ST;
            uniform sampler2D _node_2695; uniform float4 _node_2695_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
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
                float4 node_9104 = tex2D(_Alpha_Tex,TRANSFORM_TEX(i.uv0, _Alpha_Tex));
                float2 node_4752 = (mul( UNITY_MATRIX_V, float4(normalDirection,0) ).xyz.rgb.rg*0.5+0.5);
                float4 node_3110 = tex2D(_node_2695,TRANSFORM_TEX(node_4752, _node_2695));
                float3 emissive = (node_9104.rgb+(2.0*node_3110.rgb)+(-1.0));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,node_9104.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
