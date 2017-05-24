Shader "Custom/2_Side" {
	Properties {
		_BaseCol("떼깔" , color) = (.5,.5,.5,.5)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		cull off
		Lighting Off
				
		CGPROGRAM
		#pragma surface surf Lambert
		

		half4 _BaseCol;

		//sampler2D _MainTex;
		struct Input {
			float4 color : COLOR ;
		};

	

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = _BaseCol;
			//o.Emission = c.rgb ;
			o.Albedo = c.rgb ;
			o.Alpha = 1;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
