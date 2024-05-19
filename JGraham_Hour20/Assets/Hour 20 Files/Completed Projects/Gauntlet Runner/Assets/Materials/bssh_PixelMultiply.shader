// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "_L05am/PixelMultiply"
{
	Properties
	{
		[Header(General Settings)][Toggle][Enum(Off,0,On,1)]_Transparency("Transparency", Float) = 0
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 2
		[Toggle(_CustomColors)] _CustomColors("Custom Colors", Float) = 0
		_Color("Color", Color) = (1,0,0,0)
		_ColorBurn("Color Burn", Float) = 1
		_Glow("Glow", Range( 0 , 15)) = 1
		[Header(Main Texture Settings)][Toggle]_TogglePixelateMainTexture("Toggle Pixelate Main Texture", Float) = 0
		_MainTexturePixelate("Main Texture Pixelate", Range( 0 , 50)) = 15
		_MainTexture("Main Texture", 2D) = "white" {}
		[Toggle]_ToggleScreenspaceforMainTexture("Toggle Screenspace for Main Texture", Float) = 0
		_MainTextureMovement("Main Texture Movement", Vector) = (0,0,0,0)
		[Header(Second Texture Settings)][Toggle]_TogglePixelateSecondTexture("Toggle Pixelate Second Texture", Float) = 0
		_SecondTexturePixelate("Second Texture Pixelate", Range( 0 , 50)) = 15
		_SecondTexture("Second Texture", 2D) = "white" {}
		[Toggle]_ToggleScreenspaceforSecondTexture("Toggle Screenspace for Second Texture", Float) = 0
		_SecondTextureMovement("Second Texture Movement", Vector) = (0,0,0,0)
		[Header(Fresnel Settings)][Toggle]_ToggleFresnel("Toggle Fresnel", Float) = 0
		_Scale("Scale", Float) = 1
		_Power("Power", Float) = 5

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One [_Transparency]
		AlphaToMask Off
		Cull [_CullMode]
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local _CustomColors


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _CullMode;
			uniform float _Transparency;
			uniform float _ToggleFresnel;
			uniform sampler2D _MainTexture;
			uniform float _TogglePixelateMainTexture;
			uniform float2 _MainTextureMovement;
			uniform float _ToggleScreenspaceforMainTexture;
			uniform float _MainTexturePixelate;
			uniform float4 _MainTexture_ST;
			uniform sampler2D _SecondTexture;
			uniform float _TogglePixelateSecondTexture;
			uniform float2 _SecondTextureMovement;
			uniform float _ToggleScreenspaceforSecondTexture;
			uniform float _SecondTexturePixelate;
			uniform float4 _SecondTexture_ST;
			uniform float4 _Color;
			uniform float _ColorBurn;
			uniform float _Scale;
			uniform float _Power;
			uniform float _Glow;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord2 = screenPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord3.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 texCoord211 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 screenPos = i.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 panner180 = ( 1.0 * _Time.y * _MainTextureMovement + (( _ToggleScreenspaceforMainTexture )?( ase_screenPosNorm ):( float4( texCoord211, 0.0 , 0.0 ) )).xy);
				float2 PixelPanner1247 = panner180;
				float2 panner181 = ( 1.0 * _Time.y * _SecondTextureMovement + (( _ToggleScreenspaceforSecondTexture )?( ase_screenPosNorm ):( float4( texCoord211, 0.0 , 0.0 ) )).xy);
				float2 PixelPanner2264 = panner181;
				float3 appendResult273 = (float3(_Color.r , _Color.g , _Color.b));
				float3 temp_output_266_0 = ( appendResult273 + _ColorBurn );
				float4 temp_output_167_0 = ( ( tex2D( _MainTexture, ( ( (( _TogglePixelateMainTexture )?( ( floor( ( PixelPanner1247 * _MainTexturePixelate ) ) / _MainTexturePixelate ) ):( panner180 )) + _MainTexture_ST.zw ) * _MainTexture_ST.xy ) ) * tex2D( _SecondTexture, ( ( (( _TogglePixelateSecondTexture )?( ( floor( ( PixelPanner2264 * _SecondTexturePixelate ) ) / _SecondTexturePixelate ) ):( panner181 )) + _SecondTexture_ST.zw ) * _SecondTexture_ST.xy ) ) ) * float4( temp_output_266_0 , 0.0 ) );
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(WorldPosition);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float fresnelNdotV204 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode204 = ( 0.0 + _Scale * pow( 1.0 - fresnelNdotV204, _Power ) );
				float3 lerpResult208 = lerp( float3( 0,0,0 ) , temp_output_266_0 , fresnelNode204);
				
				
				finalColor = ( (( _ToggleFresnel )?( ( temp_output_167_0 + float4( lerpResult208 , 0.0 ) ) ):( temp_output_167_0 )) * _Glow );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}