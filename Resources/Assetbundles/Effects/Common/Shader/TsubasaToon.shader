Shader "Tsubasa/TsubasaToon" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RampTex ("Ramp (RGB)", 2D) = "white" {}
		_MainCol("Base Color" , color) = (.8,.8,.8,.5)
		_RimCol("Rim Color" , color) = (.5,.5,.5,.5)
		_RimPow("RimColor Expansion", float) = 2
		_RimMul("RimColor Multiple", float) = 2
		_RampIndex("RimUV Posiont", int) = 0
		_LColor("Line Color", Color) = (0,0,0,1)
		_Depth("Line Width", float) = 0.01
	
	}
	SubShader {
		Tags { 
		"Queue"="AlphaTest"
		"RenderType"="Opaque" }
		LOD 200
		


			cull front
			CGPROGRAM
#pragma surface surf Lambert vertex:vert

		//sampler2D _MainTex1;
		float4 _LColor;
		float _Depth;
	

		struct Input {
			float2 uv_MainTex1;
			float4 color:COLOR;
		};

		void vert(inout appdata_full v) {

			v.vertex.rgb = v.vertex.rgb + _Depth * v.normal;
			

		}

		void surf(Input IN, inout SurfaceOutput o) {
			//half4 c = tex2D(_MainTex1, IN.uv_MainTex1);
			o.Emission = _LColor;
			o.Alpha = 1;

		}
		ENDCG



		cull back
		CGPROGRAM
		#pragma surface surf Sasa

		sampler2D _MainTex;
		//sampler2D _BumpMap;
		sampler2D _RampTex;
		float4 _MainCol;
		float4 _RimCol;
		float _RimPow;
		float _RimMul;
		int _RampIndex;
		
		float4 LightingSasa(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten){
		
		float NdotL= dot(normalize(s.Normal), normalize(lightDir));
		
		NdotL = 0.48* NdotL + 0.5;
		//NdotL = saturate(NdotL);
		
		float SeconSpec = saturate(dot(s.Normal, viewDir)) ;
		float Rim = pow((1-SeconSpec),_RimPow);
		
		float _RampHeight = frac((_RampIndex+ .5) / 51.0);	
		float4 ramp = tex2D(_RampTex, float2( NdotL, _RampHeight));
		ramp.rgb = s.Albedo * _LightColor0.rgb * ramp.rgb * atten ;
		
		float4 Final = ramp - Rim * (1-_RimCol) *_RimMul;
		return Final; 
		}

		struct Input {
			float2 uv_MainTex;
		//	float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _MainCol ;
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Alpha = c.a;
		}
		ENDCG

	} 
	FallBack "Diffuse"
}
