// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "N5KK7/Testing/FireCC"
{
	Properties
	{
		[Header(Color Settings)][Toggle(_CustomColors)] _CustomColors("Custom Colors", Float) = 0
		_MainTexture("Main Texture", 2D) = "white" {}
		[HideInInspector]_Cutoff( "Mask Clip Value", Float ) = 0.07
		_Color("Color", Color) = (0,0.9348869,1,0)
		_TransparencyMask("Transparency Mask", Float) = 0.37
		_Glow("Glow", Range( 0 , 32)) = 1
		_AlphaValue("Alpha Value", Float) = 0
		_TextureMovement("Texture Movement", Vector) = (0,0,0,0)
		_Displacement("Displacement", 2D) = "white" {}
		_DisplacementMovement("Displacement Movement", Vector) = (0,0,0,0)
		_DisplacementStrength("Displacement Strength", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Grass"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma shader_feature_local _CustomColors
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainTexture;
		uniform float2 _TextureMovement;
		uniform float4 _MainTexture_ST;
		uniform sampler2D _Displacement;
		uniform float2 _DisplacementMovement;
		uniform float4 _Displacement_ST;
		uniform float _DisplacementStrength;
		uniform float4 _Color;
		uniform float _Glow;
		uniform float _AlphaValue;
		uniform float _TransparencyMask;
		uniform float _Cutoff = 0.07;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float2 uv_Displacement = i.uv_texcoord * _Displacement_ST.xy + _Displacement_ST.zw;
			float2 panner271 = ( 1.0 * _Time.y * _DisplacementMovement + uv_Displacement);
			float2 panner272 = ( 1.0 * _Time.y * ( _DisplacementMovement * 1.25 ) + uv_Displacement);
			float2 appendResult269 = (float2(tex2D( _Displacement, panner271 ).r , tex2D( _Displacement, panner272 ).g));
			float2 panner200 = ( 1.0 * _Time.y * _TextureMovement + (uv_MainTexture*1.0 + ( appendResult269 * _DisplacementStrength )));
			float4 tex2DNode199 = tex2D( _MainTexture, panner200 );
			float temp_output_220_0 = step( tex2DNode199.r , 0.25 );
			float3 hsvTorgb4_g5 = RGBToHSV( _Color.rgb );
			float3 hsvTorgb8_g5 = HSVToRGB( float3(( hsvTorgb4_g5.x + 0.0 ),( hsvTorgb4_g5.y + 0.0 ),( hsvTorgb4_g5.z + 0.0 )) );
			o.Emission = ( ( ( temp_output_220_0 * _Color ) + float4( ( ( step( tex2DNode199.r , 0.336 ) - temp_output_220_0 ) * saturate( hsvTorgb8_g5 ) ) , 0.0 ) ) * _Glow ).rgb;
			float R264 = tex2DNode199.r;
			o.Alpha = ( R264 * _AlphaValue );
			clip( ( R264 * _TransparencyMask ) - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}