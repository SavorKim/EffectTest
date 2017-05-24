Shader "SavorK/Shield_Flicker" {

	// Savor Barrier Shader -  2017- Kim SangWon
	//
	// No Sin, Cos Curve for mobile, with Unity3d Shaderlab

	// Made by SavorK(Shabel@netsgo.com)

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	    _AlphaTex ("AlphaAdd (RGB)", 2D) = "white" {}
		_RimColor ("Rim Color", Color) = (.5,.5,.5,.5)
		_SpecColor("Specular Color",color) = (.5,.5,.5,.5) 
		_Shininess ("Specular Strength", Range (0.01,100)) = 0.078125
		_Gloss ("Glossness", float) = 0.078125
		_RimPow("Rim Power", float) = 2
		_Power("Rim Strength", float) = 2

		_Speedx("UV Scroll x", float) = .3
		_Speedy("UV Scroll y", float) = .3
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue" = "Transparent"  }
		LOD 200
		blend SrcAlpha One
		ztest always
		zwrite off
		cull off
		
		CGPROGRAM
		#pragma surface surf BlinnPhong keepalpha

		sampler2D _MainTex;
		sampler2D _AlphaTex;
		float4 _RimColor;
		float4 _Color;
		float _Shininess;
		float _Gloss;
		float _RimPow;
		float _Power;
		float _Speedx;
		float _Speedy;
		

		struct Input {
			float2 uv_MainTex;
			float2 uv_AlphaTex;
			//float2 uv_BumpMap;
			float3 worldNormal; // 버텍스 노말 
	

			float3 viewDir;
			float3 rimColor;
			float4 color : COLOR ;
		
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);

			half4 d = tex2D(_AlphaTex, float2((IN.uv_AlphaTex.x - _Time.y * _Speedx), (IN.uv_AlphaTex.y - _Time.y * _Speedy)));
			//o.Albedo = 0;
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			float rim = dot (normalize(o.Normal), normalize(IN.viewDir));
			o.Emission = _Power * pow((1-rim),_RimPow)*_RimColor *c.rgb;
			
			//o.Emission = o.Emission 
			
			//float3 t = x * IN.rimColor *2.0;
			//o.Albedo =  o.Emission + c.rgb;
			o.Specular = _Shininess * 4   ;
			o.Gloss = _Gloss* _Power ;
			o.Alpha = _Power * saturate((rim )* (abs(fmod( 2* _Time.y,1)- 0.5)) * (d.a + .1)*c.a) + pow((1 - rim), _Gloss) * _RimColor.a;
			//o.Alpha = d.r;
			//o.Alpha = o.Emission;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
