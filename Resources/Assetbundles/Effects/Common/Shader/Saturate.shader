// Savor Shader -  2017- Kim SangWon
//
// Made in Drecom Co.,Ltd.

// Made by SavorK(Shabel@netsgo.com)

Shader "SavorK/Saturate"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		_Hue("Hue", Float) = 0
		_Sat("Saturation", Float) = 1
		_Val("Value", Float) = 1
		[MaterialToggle] PixelSnap("Pixel snap", Float) = 0
	}

		SubShader
	{
		Tags
	{
		"Queue" = "Transparent"
		"IgnoreProjector" = "True"
		"RenderType" = "Transparent"
		"PreviewType" = "Plane"
		"CanUseSpriteAtlas" = "True"
	}

		Cull Off
		Lighting Off
		ZWrite Off
		Fog{ Mode Off }
		Blend One OneMinusSrcAlpha

		Pass
	{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile DUMMY PIXELSNAP_ON
		#include "UnityCG.cginc"

		struct appdata_t
	{
		float4 vertex   : POSITION;
		float4 color    : COLOR;
		float2 texcoord : TEXCOORD0;
	};

	struct v2f
	{
		float4 vertex   : SV_POSITION;
		fixed4 color : COLOR;
		half2 texcoord  : TEXCOORD0;
	};

	fixed4 _Color;

	v2f vert(appdata_t IN)
	{
		v2f OUT;
		OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
		OUT.texcoord = IN.texcoord;
		OUT.color = IN.color * _Color;
		#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap(OUT.vertex);
		#endif

		return OUT;
	}


	fixed3 shift_col(fixed3 RGB, half3 shift)
	{
		fixed3 RESULT = fixed3(RGB);
		float VSU = shift.z*shift.y*cos(shift.x*3.14159265 / 180);
		float VSW = shift.z*shift.y*sin(shift.x*3.14159265 / 180);

		RESULT.x = (.299*shift.z + .701*VSU + .168*VSW)*RGB.x
			+ (.587*shift.z - .587*VSU + .330*VSW)*RGB.y
			+ (.114*shift.z - .114*VSU - .497*VSW)*RGB.z;

		RESULT.y = (.299*shift.z - .299*VSU - .328*VSW)*RGB.x
			+ (.587*shift.z + .413*VSU + .035*VSW)*RGB.y
			+ (.114*shift.z - .114*VSU + .292*VSW)*RGB.z;

		RESULT.z = (.299*shift.z - .3*VSU + 1.25*VSW)*RGB.x
			+ (.587*shift.z - .588*VSU - 1.05*VSW)*RGB.y
			+ (.114*shift.z + .886*VSU - .203*VSW)*RGB.z;

		return (RESULT);
	}

	sampler2D _MainTex;
	half _Hue, _Sat, _Val;

	fixed4 frag(v2f IN) : SV_Target
	{
		fixed4 c = tex2D(_MainTex, IN.texcoord) * IN.color;
	c.rgb *= c.a;

	half3 shift = half3(_Hue, _Sat, _Val);

	return fixed4(shift_col(c, shift), c.a);
	}
		ENDCG
	}
	}
}




/*
Shader "SavorK/NoiseBroadCast" {

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Base (RGB)", 2D) = "white" {}
		_h("Color", color) = (0,0,0,0)
		_Speedx("Cloud Speed x", float) = .3
		_Speedy("Cloud Speed y", float) = .3
		_Distort("Distort", float) = .3
		_NOver("Noise Overay", Range(0.0,1.5)) = .2
	}

	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha
		//Blend SrcAlpha DstAlpha
		//Blend SrcAlpha One
		//Blend One One
		//Zwrite off
		Lighting Off
		//ztest always // for fantastic!!
		Cull Off
		
		
		CGPROGRAM
		#pragma surface surf Lambert keepalpha
		//alpha

		sampler2D _MainTex;
		sampler2D _MainTex2;
		float4 _h;
		float _Distort;
		float _NOver;
		float _Speedx;
		float _Speedy;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float4 color : COLOR ;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 d = tex2D (_MainTex2, float2((IN.uv_MainTex2.x + _Time.x * _Speedx),(IN.uv_MainTex2.y + _Time.x * _Speedy)) );
			
			half4 c = tex2D(_MainTex, float2((IN.uv_MainTex.x + (d.a)* _Distort * (fmod(_Distort*_Time.y, 1)-.5)), (IN.uv_MainTex.y + (d.a)* _Distort * (fmod(_Time.y, 1)-.5)) ));
			
			
			o.Emission = c.rgb *_h.rgb * IN.color.rgb + _NOver * d.a;
			o.Alpha = (c.a  * _h.a +_NOver * .5 * d.a) * IN.color.a;
		}
		ENDCG
	} 
	FallBack "Transparent/Diffuse"
}

*/