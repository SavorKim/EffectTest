// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-196-OUT,alpha-149-OUT;n:type:ShaderForge.SFN_Vector4Property,id:2151,x:32226,y:32741,ptovrint:False,ptlb:Emissive,ptin:_Emissive,varname:node_2151,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3,v2:3,v3:3,v4:0;n:type:ShaderForge.SFN_Tex2d,id:8237,x:32226,y:32917,ptovrint:False,ptlb:node_8m,ptin:_node_8m,varname:node_8237,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:75b62f515d093ef40bcf0291b92bf3f2,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:196,x:32447,y:32818,varname:node_196,prsc:2|A-2151-XYZ,B-8237-A,C-4683-RGB;n:type:ShaderForge.SFN_Multiply,id:149,x:32447,y:33012,varname:node_149,prsc:2|A-8237-A,B-4683-A;n:type:ShaderForge.SFN_VertexColor,id:4683,x:32226,y:33146,varname:node_4683,prsc:2;proporder:2151-8237;pass:END;sub:END;*/

Shader "Shader Forge/MT_Cube_Glow" {
    Properties {
        _Emissive ("Emissive", Vector) = (3,3,3,0)
        _node_8m ("node_8m", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _Emissive;
            uniform sampler2D _node_8m; uniform float4 _node_8m_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _node_8m_var = tex2D(_node_8m,TRANSFORM_TEX(i.uv0, _node_8m));
                float3 emissive = (_Emissive.rgb*_node_8m_var.a*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,(_node_8m_var.a*i.vertexColor.a));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
