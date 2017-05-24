Shader "sphere/BGWindowRefraction"
{
    Properties
    {
    	_refraction       		("refraction", 2D)					= "white" {}
        _diffuseTex             ("diffuseTex", 2D) 					= "black" {}
        _RefractionAmoutn		("Refraction Amount", 	 Float )	= 0.5
        _RefractionIntensity 	("Refraction Intensity", Float ) 	= 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        Pass
        {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase" }
            Cull Off
                        
            CGPROGRAM
            #pragma vertex 		vert
            #pragma fragment 	frag

            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"

            #pragma multi_compile_fwdbase_fullshadows

            uniform sampler2D   _refraction;
            uniform sampler2D   _diffuseTex; 	uniform float4 _diffuseTex_ST;
            uniform float		_RefractionAmoutn;
            uniform float       _RefractionIntensity;

            //====================================
            // Vertex input
            //====================================
            struct VertInput
            {
                float4 vertex 		: POSITION;
                float2 texcoord0 	: TEXCOORD0;
            };

            //====================================
            // Fragment input
            //====================================
            struct FragInput
            {
                float4 pos 			: SV_POSITION;
                float2 uv0 			: TEXCOORD0;
            };

            //====================================
            // Vertex shader
            //====================================
            FragInput vert (VertInput v)
            {
                FragInput o = (FragInput)0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                o.uv0 = v.texcoord0;
                return o;
            }

            //====================================
            // Fragment shader
            //====================================
            float4 frag(FragInput i, float facing : VFACE) : COLOR
            {

            	float3 normal = float3( i.uv0.x, i.uv0.y, 0.5f );

                // 法線方向を UV として使用するための変換
                float2 normalUV 		= mul( UNITY_MATRIX_V, float4(normal,0) ).xy * 0.5f + 0.5f;
                float4 refracSample 	= tex2D(_refraction, normalUV );

                // maskTexture の r で metal と toon をブレンド
                float3 lightingTerm = refracSample * _RefractionIntensity;

                // ライティング結果
                float4 diffuseSample 	= tex2D(_diffuseTex,TRANSFORM_TEX(i.uv0, _diffuseTex));
                float3 finalColor 		= lerp(diffuseSample.rgb, lightingTerm, _RefractionAmoutn);

                return float4(finalColor.rgb,0);

            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
