Shader "BeatSaber/ZennyTrailReal" {
	Properties {
		_Color ("Color", Color) = (0.5,0.5,0.5,1)
		_MainTex ("MainTex", 2D) = "white" {}
		_AlphaTexture ("AlphaTexture", 2D) = "white" {}
		_ScreenSpace ("ScreenSpace", 2D) = "white" {}
		_Displacement ("Displacement", 2D) = "black" {}
		_DisplacementOffset ("Displacement Offset", Vector) = (0,0,0,0)
		_DisplacementSpeed ("Displacement Speed ", Float) = 1
		_DisplacementIntensity ("Displacement Intensity", Float) = 0.15
		_Glow ("Glow", Range(0, 6.5)) = 1
		_TrailOpacity ("Trail Opacity", Float) = 1
		_Blend ("Blend", Range(0, 2)) = 0
		[MaterialToggle] _CustomColors ("Custom Colors", Float) = 0
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
		GrabPass {
			"Refraction"
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Overlay" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 49211
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 color : COLOR0;
				float4 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float4 _MainTex_ST;
			float4 _AlphaTexture_ST;
			float4 _ScreenSpace_ST;
			float4 _Displacement_ST;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			CBUFFER_START(Props)
				float4 _Color;
				float _Glow;
				float4 _DisplacementOffset;
				float _DisplacementSpeed;
				float _TrailOpacity;
				float _DisplacementIntensity;
				float _Blend;
			CBUFFER_END
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D Refraction;
			sampler2D _MainTex;
			sampler2D _ScreenSpace;
			sampler2D _Displacement;
			sampler2D _AlphaTexture;
			
			// Keywords: DIRECTIONAL
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp1 = tmp0.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp1 = unity_MatrixVP._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp1 = unity_MatrixVP._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp1 = unity_MatrixVP._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                o.position = tmp1;
                o.texcoord.xy = v.texcoord.xy;
                o.color = v.color;
                tmp0.y = tmp0.y * unity_MatrixV._m21;
                tmp0.x = unity_MatrixV._m20 * tmp0.x + tmp0.y;
                tmp0.x = unity_MatrixV._m22 * tmp0.z + tmp0.x;
                tmp0.x = unity_MatrixV._m23 * tmp0.w + tmp0.x;
                o.texcoord1.z = -tmp0.x;
                tmp0.x = tmp1.y * _ProjectionParams.x;
                tmp0.w = tmp0.x * 0.5;
                tmp0.xz = tmp1.xw * float2(0.5, 0.5);
                o.texcoord1.w = tmp1.w;
                o.texcoord1.xy = tmp0.zz + tmp0.xw;
                return o;
			}
			// Keywords: DIRECTIONAL
			fout frag(v2f inp, float facing: VFACE)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0.x = _Time.y * _DisplacementSpeed;
                tmp0 = tmp0.xxxx * float4(0.0, -0.75, 0.0, -1.0) + inp.texcoord.xyxy;
                tmp0 = tmp0 * _Displacement_ST + _Displacement_ST;
                tmp1 = tex2D(_Displacement, tmp0.xy);
                tmp0 = tex2D(_Displacement, tmp0.zw);
                tmp1.y = tmp0.y;
                tmp0.xy = tmp1.xy * _DisplacementIntensity.xx + inp.texcoord.xy;
                tmp0.xy = tmp0.xy + _DisplacementOffset.xy;
                tmp0.xy = tmp0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
                tmp0 = tex2D(_AlphaTexture, tmp0.xy);
                tmp0.x = tmp0.x * _TrailOpacity;
                tmp0.yz = inp.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp1 = tex2D(_MainTex, tmp0.yz);
                tmp0.yzw = tmp1.xyz * inp.color.xyz;
                tmp0.yzw = tmp0.yzw * _Color.xyz;
                tmp1.xy = inp.texcoord1.xy / inp.texcoord1.ww;
                tmp1.zw = tmp1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2 = tex2D(Refraction, tmp1.xy);
                tmp1.xy = tmp1.zw * _ScreenSpace_ST.xy + _ScreenSpace_ST.zw;
                tmp1 = tex2D(_ScreenSpace, tmp1.xy);
                tmp0.yzw = tmp0.yzw * tmp1.xyz;
                tmp1.xyz = -tmp0.yzw * tmp0.xxx + float3(1.0, 1.0, 1.0);
                tmp0.yzw = tmp0.xxx * tmp0.yzw;
                tmp0.x = tmp0.x * _Glow;
                tmp0.yzw = tmp2.xyz * tmp0.yzw;
                tmp0.yzw = tmp0.yzw + tmp0.yzw;
                tmp3.xyz = tmp2.xyz - float3(0.5, 0.5, 0.5);
                tmp2.xyz = tmp2.xyz > float3(0.5, 0.5, 0.5);
                tmp3.xyz = -tmp3.xyz * float3(2.0, 2.0, 2.0) + float3(1.0, 1.0, 1.0);
                tmp1.xyz = -tmp3.xyz * tmp1.xyz + float3(1.0, 1.0, 1.0);
                tmp0.yzw = tmp2.xyz ? tmp1.xyz : tmp0.yzw;
                tmp1.xyz = float3(1.0, 1.0, 1.0) - tmp0.yzw;
                tmp1.w = tmp0.x * _Blend + -0.5;
                tmp1.w = -tmp1.w * 2.0 + 1.0;
                tmp1.xyz = -tmp1.www * tmp1.xyz + float3(1.0, 1.0, 1.0);
                tmp1.w = tmp0.x * _Blend;
                o.sv_target.w = tmp0.x;
                tmp0.x = tmp1.w + tmp1.w;
                tmp1.w = tmp1.w > 0.5;
                tmp0.xyz = tmp0.yzw * tmp0.xxx;
                o.sv_target.xyz = tmp1.www ? tmp1.xyz : tmp0.xyz;
                return o;
			}
			ENDCG
		}
	}
	CustomEditor "ShaderForgeMaterialInspector"
}