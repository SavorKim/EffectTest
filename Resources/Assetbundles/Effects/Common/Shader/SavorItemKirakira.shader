
Shader "SavorK/KirakiraItem"{
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SColor ("Specular Color", Color) = (1, 1, 1, 1)
	_Shininess ("Shininess", Range (0.01, 3)) = 1.5
	_Gloss("Gloss", Range (0.00, 1)) = .5
	_Reflection("Reflection", Range (0.00, 88)) = 0.5
	_Cube ("Reflection Cubemap", Cube) = "Black" { } 


	_RimColor("Rim Color", Color) = (0.26,0.19,0.16,0.0)
	_RimPower("Rim Power", Range(0.5,8.0)) = 3.0
	_RimStrength("Rim Strength", Range(0.1,12.0)) = 0.5
	
	_MainTex ("Diffuse(RGB) Alpha(A)",2D) = "White" {}
	_BumpMap ("Normalmap", 2D) = "Bump" {}
	
}


SubShader {
		
	Tags {"Queue"="Geometry" "RenderType"="Opaque" "IgnoreProjector"="True" }
		
	CGPROGRAM
	#pragma surface surf WrapLambert

	//#include "UnityCG.cginc"

	sampler2D _MainTex;
	samplerCUBE _Cube;
	sampler2D _BumpMap;
	fixed4 _Color;
	fixed4 _SColor;
	float4 _RimColor;
	float _RimPower;
	float _RimStrength;
	half _Shininess;
	fixed _Gloss;
	

	fixed _Reflection;


	

	struct Input {
		float3 worldNormal;
		float2 uv_MainTex;

		float2 uv_BumpMap;
		float3 viewDir;
		float3 worldRefl;
		INTERNAL_DATA
	};

	half4 LightingWrapLambert(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
		half NdotL = dot(s.Normal, lightDir);
		half diff = NdotL * 0.25 + 0.75;
		half4 c;

		half3 h = normalize(lightDir + viewDir);

		

		float nh = max(0, dot(s.Normal, h));
		float spec = pow(nh, 24* _Shininess);



		//c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
		c.rgb = (s.Albedo * diff + _SColor.rgb * spec) * atten;
		c.a = s.Alpha;
		return c;
	}

	void surf(Input IN, inout SurfaceOutput o) {


		//fixed4 SpecGlossRefMask = tex2D(_Spec_Gloss_Reflec_Masks, IN.uv_BumpMap);

		float4 Diffuse = tex2D(_MainTex, IN.uv_MainTex);
		
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		fixed3 worldRefl = normalize(WorldReflectionVector(IN, o.Normal));
		fixed3 worldNormal = WorldNormalVector(IN, o.Normal);
		fixed SurfAngle = 0.5 * dot(worldRefl, worldNormal) + 0.5; // Half-Lambert
		_Shininess *= _Color.a;

		fixed3 CubeTex;
		CubeTex = texCUBE(_Cube, worldRefl).rgb;

		CubeTex.rgb *= _Reflection;


		o.Albedo = Diffuse.rgb  * _Color.rgb  ;
		half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
		o.Emission = (_RimColor.rgb * pow(rim, _RimPower) * _RimStrength + (CubeTex.rgb) * SurfAngle)* Diffuse.a ;





	}
	ENDCG

	
		
	} 
		Fallback "Diffuse"
	}
