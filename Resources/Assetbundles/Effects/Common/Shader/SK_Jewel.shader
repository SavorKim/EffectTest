// Shader created by SavorK(Shabel@netsgo.com)
// Inspired by Jemshader .. 
// For mobile, with Texture

Shader "SavorK/JewelwithTexture"

{
	Properties{
		_Color("MainColor", Color) = (1,1,1,1)
		_RColor("BackColor", Color) = (1,1,1,1)
		_Shininess("Shininess", Range(0, 50)) = 3
		_ReflectTex("Reflection Cube Texture", Cube) = "dummy.jpg"
		// _RefractTex ("Refraction Texture", Cube) = "dummy.jpg"
		_MainTex("Base (RGB)", 2D) = "white" {}
		}

		SubShader{
		Tags{
		"RenderType" = "Transparent" "Queue" = "Transparent"
		}
			
			// First pass - inside Jewel 

			Cull Front
			//Ztest On
			Blend SrcAlpha Zero
			CGPROGRAM
	
			#pragma surface surf Lambert

			samplerCUBE _ReflectTex;
			// samplerCUBE _RefractTex;
			sampler2D _MainTex;

			//fixed4 _Color;
			fixed4 _RColor;
			half _Shininess;

			struct Input {
				float3 worldRefl;
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				//half4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = texCUBE(_ReflectTex, IN.worldRefl) * _RColor * _Shininess ;
				//o.Emission = c.rgb;
				//o.Emission = texCUBE(_ReflectTex, IN.worldRefl) * _RColor * c.rgb;
				//o.Alpha = _RColor.a;
			}
		ENDCG

			// Second pass - inside Jewel 
			
			Cull Back
			Blend SrcAlpha One
			zwrite off

			CGPROGRAM
			#pragma surface surf Lambert alpha

			samplerCUBE _ReflectTex;
			// samplerCUBE _RefractTex;
			fixed4 _Color;
			//fixed4 _RColor;
			half _Shininess;
			sampler2D _MainTex;

			struct Input {
				float3 worldRefl;
				float2 uv_MainTex;
			};


			void surf(Input IN, inout SurfaceOutput o) {
				half4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = texCUBE(_ReflectTex, IN.worldRefl) * (1 + _Shininess) * _Color * c.rgb;
				// o.Emission = texCUBE(_ReflectTex, IN.worldRefl) * _Shininess * _Color * c.rgb;
				o.Alpha = _Color.a;
			}

		ENDCG
		}

		Fallback "VertexLit"
}