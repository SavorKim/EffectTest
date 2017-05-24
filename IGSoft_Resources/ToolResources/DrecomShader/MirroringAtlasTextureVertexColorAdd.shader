Shader "FxMaker/Particles/MirroringAtlasTextureVertexColorAdd"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha One
		Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
				float4 uv2 : TEXCOORD1;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 color : COLOR;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _TexSize;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = v.uv;
				o.color = v.color;

				// xy は UV の開始座標
				// zw は UV の終了座標
				o.uv1 = v.uv2;
//				o.uv1.xy = v.uv2.xy;//float2( 0.25f, 0.25f );
//				o.uv1.zw = v.uv2.zw//float2( 0.5f, 0.5f );

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				i.uv.y += 0.5f;
				float2 t = frac(i.uv) * 2.0f;
				float2 length = float2( 1.0, 1.0 );
				float2 mirrorCoord = length - abs(t - length);

				// この時点で mirrorCoord は 0 〜 1 〜 0 の値を取る
				// mirrorCoord の値で UV を補間する
				mirrorCoord = lerp( i.uv1.xy, i.uv1.zw, mirrorCoord);

				fixed4 col = tex2D(_MainTex, mirrorCoord) * i.color;
				return col;
			}
			ENDCG
		}
	}
}
