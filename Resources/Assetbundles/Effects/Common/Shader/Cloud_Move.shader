// Savor Shader -  2017- Kim SangWon
//
// Made in Drecom Co.,Ltd.

// Made by SavorK(Shabel@netsgo.com)

Shader "SavorK/Cloud_Move" {

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Base (RGB)", 2D) = "white" {}
		_h("Color", color) = (0,0,0,0)
		_Speedx("Cloud Speed x", float) = .3
		_Speedy("Cloud Speed y", float) = .3
	}

	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200
		//Blend SrcAlpha OneMinusSrcAlpha
		Blend SrcAlpha DstAlpha
		//Blend SrcAlpha One
		//Blend One One
		Zwrite off
		Lighting Off
		//ztest always // for fantastic!!
		Cull front
		
		
		CGPROGRAM
		#pragma surface surf Lambert keepalpha
		//alpha

		sampler2D _MainTex;
		sampler2D _MainTex2;
		float4 _h;
		float _Speedx;
		float _Speedy;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float4 color : COLOR ;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 d = tex2D (_MainTex2, float2((IN.uv_MainTex2.x ),(IN.uv_MainTex2.y  )) );
			
			half4 c = tex2D(_MainTex, float2((d.r + _Time.x * _Speedx), (d.g + _Time.x * _Speedy)));
			//c = tex2D (_MainTex, IN.uv_MainTex + d.r *.2 -.07 );
			
			o.Emission = c.rgb * _h.rgb * d.rgb;
			o.Alpha = (_h.a *2)* d.a * c.a ;
		}
		ENDCG
	} 
	FallBack "Transparent/Diffuse"
}