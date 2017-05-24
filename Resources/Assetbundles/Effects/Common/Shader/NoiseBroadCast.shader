// Savor // Script handling sprite alpha with FadeIn FadeOut, and repeating...  -  2017- Kim SangWon
//
// Made in Drecom Co.,Ltd.

// Made by SavorK(Shabel@netsgo.com)
// Shader expressed noise effect with UV distorting... 

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

		Zwrite off
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
			//float _pSin = (d.a)*_Distort*_Time.x;
			float _pSin = normalize((d.a)* _Distort* abs(fmod((_Distort*_Time.y-.5), 1) - .5));
			half4 c = tex2D(_MainTex, float2((IN.uv_MainTex.x + _pSin + _Time.x * _Speedx), (IN.uv_MainTex.y + _pSin + _Time.x * _Speedy) ));
			
			
			o.Emission = (c.rgb  * IN.color.rgb + _NOver * d.a )*_h.rgb;
			o.Alpha = (c.a  * _h.a +_NOver * .5 * d.a) * IN.color.a;
			//clip(o.Alpha - .25);
		}
		ENDCG
	} 
	FallBack "Transparent/Diffuse"
}