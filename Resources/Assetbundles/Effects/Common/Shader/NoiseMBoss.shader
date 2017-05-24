// Savor Shader - 2017- Kim SangWon
//
// Made in Drecom Co.,Ltd.
// Shader for Big Enemy's flow effects!

// Made by SavorK(Shabel@netsgo.com)

Shader "SavorK/NoiseMiddleBoss" {

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Noise (RGB)", 2D) = "white" {}
//		_Cube("Reflection Cubemap", Cube) = "Black" { }
		_h("Color", color) = (0,0,0,0)
		_Speedx("Cloud Speed x", float) = .3
		_Speedy("Cloud Speed y", float) = .3
		_Distort("Distort", float) = .3
		_DistortV("Distort Vector", Vector) = (.3,.3,.3,1)
		_Smoke("Smoke", float) = .3

		_Depth("Morph", Range(-1.1,1.1)) = 0.01
		_NOver("Noise Ovelay", Range(0.0,1.5)) = .2
		_CutRatio("Cutoff Ratio", Range(0,1)) = 0.5
		_CutNumber("Cutoff Number", float) = 3
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}

	SubShader {
		Tags{ "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 200
		//Blend SrcAlpha OneMinusSrcAlpha
		//Blend SrcAlpha DstAlpha
		Blend SrcAlpha One
		//Blend DstColor Zero // Multiplicative
		//Blend DstColor SrcColor // 2x Multiplicative
		//Blend One One
		//Zwrite off
		//Lighting Off
		//ztest always // for fantastic!!
		Cull Off
		//	AlphaToMask On
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert noambient keepAlpha
		
		//float _Depth;
		

		sampler2D _MainTex;
		sampler2D _MainTex2;
		float4 _DistortV;
		float4 _h;
		float _Distort;
		float _Depth;
		float _NOver;
		float _Speedx;
		float _Speedy;
		float _Smoke;
		float _CutRatio;
		float _CutNumber;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float3 viewDir;
			float4 color : COLOR ;
			float3 worldPos;

		};


		void vert(inout appdata_full v) {

			v.vertex.rgb += (sin(_Time.x * _DistortV.a)) * (1 - v.color.a) * _DistortV.rgb;
			//v.vertex.rgb += (abs(2 * (fmod((_Time.y  -.5), 1) - .49)) - .5) * _Depth  *  v.normal * (1 - 0.7 * v.color.a);
			//v.texcoord.x = sin(_Time.y)+ v.texcoord.xy ;

		}

		void surf (Input IN, inout SurfaceOutput o) {

			half4 d = tex2D (_MainTex2, float2((IN.uv_MainTex2.x + _Time.x * _Speedx),(IN.uv_MainTex2.y + _Time.x * _Speedy)) );
			float _pSin = (abs(2 * ((0.25* _Time.y   - .5) - .49)) - .5 )* _Distort;
			//float _pSin = sin(_Time.x * 2)* _Distort;
			half4 c = tex2D(_MainTex, float2((IN.uv_MainTex.x + d.a * _pSin + _Time.x * _Speedx), (IN.uv_MainTex.y + d.a *  _pSin + _Time.x * _Speedy) ));
			
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			
			o.Emission = (c.rgb + .89 - _Smoke * rim  + _NOver * (d.a )) *_h.rgb * IN.color.rgb ;
			o.Alpha =c.a*(
				(1- (1-IN.color.a) * d.a)*IN.color.a -  .7 * rim) ;
			clip(d.a*IN.color.a - .03 );
			clip(frac((IN.worldPos.y - _pSin * _Speedy + IN.worldPos.y*0.01) * _CutNumber *_CutRatio) - _CutRatio);
				//(1- 0.8 *( d.a - _pSin * rim)) * c.a * _h.a + _NOver * d.a * .4;
			//(c.a  * _h.a + _NOver * .5 ) *

		}
		ENDCG
	} 
	FallBack "Transparent/Diffuse"
}