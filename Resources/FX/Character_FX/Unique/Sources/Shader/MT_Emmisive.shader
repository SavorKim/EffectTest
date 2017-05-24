// Shader created with Shader Forge v1.28 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.28;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:33433,y:32588,varname:node_3138,prsc:2|emission-3532-OUT,alpha-1827-OUT;n:type:ShaderForge.SFN_Vector4Property,id:3448,x:32337,y:32517,ptovrint:False,ptlb:colorEmissive,ptin:_colorEmissive,varname:node_3448,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3,v2:3,v3:3,v4:0;n:type:ShaderForge.SFN_Tex2d,id:8121,x:32330,y:32836,ptovrint:False,ptlb:node_8121,ptin:_node_8121,varname:node_8121,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6e9f34d8b40adea45aaf993ef3cc49c4,ntxv:0,isnm:False|UVIN-3060-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:3060,x:32138,y:32836,varname:node_3060,prsc:2,uv:0;n:type:ShaderForge.SFN_Color,id:9241,x:32330,y:32675,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_9241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:402,x:32549,y:32895,varname:node_402,prsc:2|A-9241-A,B-8121-R,C-920-A;n:type:ShaderForge.SFN_Add,id:3532,x:32999,y:32651,varname:node_3532,prsc:2|A-1756-OUT,B-9990-OUT;n:type:ShaderForge.SFN_Tex2d,id:1480,x:32141,y:32176,ptovrint:False,ptlb:line,ptin:_line,varname:node_1480,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a1877bcd95c0b7e45ad895072c6ffc30,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3787,x:32604,y:32174,varname:node_3787,prsc:2|A-9070-OUT,B-9241-RGB;n:type:ShaderForge.SFN_Power,id:9070,x:32345,y:32176,varname:node_9070,prsc:2|VAL-1480-RGB,EXP-1910-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1910,x:32141,y:32358,ptovrint:False,ptlb:Line,ptin:_Line,varname:node_1910,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Add,id:1827,x:32999,y:32880,varname:node_1827,prsc:2|A-1480-A,B-402-OUT;n:type:ShaderForge.SFN_Multiply,id:1756,x:32792,y:32174,varname:node_1756,prsc:2|A-1483-XYZ,B-3787-OUT,C-920-RGB;n:type:ShaderForge.SFN_Vector4Property,id:1483,x:32604,y:32028,ptovrint:False,ptlb:Line_emissive,ptin:_Line_emissive,varname:node_1483,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3,v2:3,v3:3,v4:0;n:type:ShaderForge.SFN_VertexColor,id:920,x:32345,y:32358,varname:node_920,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9990,x:32645,y:32628,varname:node_9990,prsc:2|A-3448-XYZ,B-8121-R;proporder:3448-8121-9241-1480-1910-1483;pass:END;sub:END;*/

Shader "Shader Forge/MT_sprit" {
    Properties {
        _colorEmissive ("colorEmissive", Vector) = (3,3,3,0)
        _node_8121 ("node_8121", 2D) = "white" {}
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _line ("line", 2D) = "black" {}
        _Line ("Line", Float ) = 1
        _Line_emissive ("Line_emissive", Vector) = (3,3,3,0)
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
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _colorEmissive;
            uniform sampler2D _node_8121; uniform float4 _node_8121_ST;
            uniform float4 _Color;
            uniform sampler2D _line; uniform float4 _line_ST;
            uniform float _Line;
            uniform float4 _Line_emissive;
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
                float4 _line_var = tex2D(_line,TRANSFORM_TEX(i.uv0, _line));
                float4 _node_8121_var = tex2D(_node_8121,TRANSFORM_TEX(i.uv0, _node_8121));
                float3 emissive = ((_Line_emissive.rgb*(pow(_line_var.rgb,_Line)*_Color.rgb)*i.vertexColor.rgb)+(_colorEmissive.rgb*_node_8121_var.r));
                float3 finalColor = emissive;
                return fixed4(finalColor,(_line_var.a+(_Color.a*_node_8121_var.r*i.vertexColor.a)));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
