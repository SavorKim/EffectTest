Shader "Custom/Cloud_Move" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Base (RGB)", 2D) = "white" {}
		_h("Color", color) = (0,0,0,0)
		_Speedx("구름 속도 x", float) = .3
		_Speedy("구름 속도 y", float) = .3
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200
		blend SrcAlpha One
		zwrite off
		Lighting Off
		//ztest always // 몽환적 분위기를 만들어줍니다. 
		//cull off
		
		
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
			half4 d = tex2D (_MainTex2, float2((IN.uv_MainTex2.x - _Time.x * _Speedx),(IN.uv_MainTex2.y - _Time.x * _Speedy)) );
			half4 c = tex2D (_MainTex, IN.uv_MainTex + d.r *.2 -.07 );
			
			o.Emission = c.rgb * _h.rgb;
			o.Alpha = c.a * _h.a * IN.color.r ;
		}
		ENDCG
	} 
	FallBack "Transparent/Diffuse"
}