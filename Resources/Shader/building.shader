//-------------------------------------------------------
// @file   building
// @brief  .
//
// @author drecom Co.,Ltd. Kento Masuno
// Copyright(C) drecom Co.,Ltd. All rights reserved.
//-------------------------------------------------------
Shader "Unlit/building"
{
    Properties
    {
        _LightLineTex 	("LightLine", 2D) 		= "white" {}
        _SkyColor		("Sky Color", Color)	= (1.0, 1.0, 1.0, 1.0)
        _GroundColor	("Ground Color", Color)	= (0.745, 0.784, 0.901, 1.0)
        _ShadeColor 	("Shade Color", Color) 	= (0.352, 0.431, 0.588, 1.0)
        _ShadeColor2	("Shade Color2", Color) = (0.352, 0.431, 0.588, 1.0)
        _maxHeight		("Max Height", float) 	= 10.0
    }

    SubShader
    {
        Pass
        {
            Tags {"LightMode"="ForwardBase"}
        
            CGPROGRAM
            #pragma vertex 		vert
            #pragma fragment 	frag

            #include "UnityCG.cginc" 				// for UnityObjectToWorldNormal
            #include "UnityLightingCommon.cginc"	// for _LightColor0

            struct v2f
            {
                float4 	vertex 	: SV_POSITION;
                float2 	uv 		: TEXCOORD0;
                fixed2 	param 	: TEXCOORD1; // x:NdotL / y:world position

            };

            sampler2D 		_LightLineTex;
           	fixed4			_ShadeColor;
           	fixed4			_ShadeColor2;
           	fixed4			_SkyColor;
           	fixed4			_GroundColor;
           	float			_maxHeight;

            //==========================
            // 頂点シェーダー
            //==========================
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex 		= mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv 			= v.texcoord;

                // モデルのワールド法線
                half3 worldNormal;
                worldNormal		= UnityObjectToWorldNormal(v.normal);
                o.param.x 		= max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

                // モデルのワールド座標
                float4 worldPosition;
                worldPosition 	= mul(unity_ObjectToWorld, v.vertex);
                o.param.y 		= worldPosition.y;

                return o;
            }

            //==========================
            // フラグメントシェーダー
            //==========================
            fixed4 frag (v2f i) : SV_Target
            {
            	// 高さの比率
            	float	rate = saturate( i.param.y / _maxHeight );

            	// 高さによってビルにグラデーション
            	fixed4	builColor = lerp( _GroundColor, _SkyColor, rate );

            	// トゥーン用のライト参照用のテクスチャ
                fixed4 light 	= tex2D(_LightLineTex, float2( i.param.x, 0.5f) );

                // ライトの当たり具合で色を分ける.
                fixed4 result = lerp( builColor, lerp(_ShadeColor, _ShadeColor2, i.param.x), (1.0f - light.x) );

                return result;
            }
            ENDCG
        }
    }
}
