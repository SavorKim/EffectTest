Shader "Custom/Barrier" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("노말맵 (RGB)", 2D) = "white" {}
		_Depth ("두께", Range (0.01,0.1)) = 0.01
		_LColor ("  ", Color) = (0,0,0,1)
		_SpecCol("스페큘러 칼라" , color) = (.5,.5,.5,.5)
		_RimCol("림 칼라" , color) = (.5,.5,.5,.5)
		_SpecPow("스페큘러 범위", float) = 30
	}
	
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		LOD 200
		blend SrcAlpha OneMinusSrcAlpha
		cull back
		zwrite on
		
		CGPROGRAM
		#pragma surface surf Lambert noambient vertex:vert
		float _Depth;
		
		struct Input {
		
		float4 Color:color;
		};
		
		
		void vert(inout appdata_full v){
		
		v.vertex.rgb += sin(_Time.y)*_Depth * v.normal;
		//v.texcoord.x = sin(_Time.y)+ v.texcoord.xy ;
		
		}
		
		void surf (Input IN, inout SurfaceOutput o){
		o.Albedo = 0;
		o.Alpha = 0;
		
		}
		ENDCG
		
		zwrite off
		
		CGPROGRAM
		#pragma surface surf Barrier vertex:vert
		
		float _Depth;
		float _SpecPow;
		float _SpecCol;
		float _RimCol;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		
		

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float3 viewDir;
		};
		
		float4 LightingBarrier(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten){
		//return float4(1,0,0,1); //red 출력
		//float NdotL= saturate(dot(s.Normal, lightDir));
//			float3 H = normalize(lightDir + viewDir); // 하프벡터 
//			float NH =  dot(s.Normal, H);
//			float3 spec ;
//			spec = pow(NH, _SpecPow) * _SpecCol;
//			
//			
//			float NdotL= dot(s.Normal, lightDir);
//			
//
//			
  			float rim = abs(dot (normalize(s.Normal), normalize(viewDir)));
			rim = 1- rim;
			rim = pow(rim, 2);
//			
//			//if (rim < 0.4) rim = 1; else rim = 0;
//
//	 		
			float4 c;
//			c.rgb = s.Albedo * NdotL * _LightColor0.rgb * atten * 2 + spec + rim;
			c.rgb = rim + s.Albedo;
			//c.Normal = 
			
			c.a = rim ;
			
			return c;
		}



		void vert(inout appdata_full v){
		
		v.vertex.rgb += sin(_Time.y)*_Depth * v.normal;
		//v.texcoord.x = sin(_Time.y)+ v.texcoord.xy ;
		
		}

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex + _Time.y *.1));
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
