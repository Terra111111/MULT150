// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "N5KK7/FireTrail V2"
{
	Properties
	{
		[Toggle(_CustomColors_ON)] _CustomColors("Toggle CustomColors", Float) = 0
		_Color("Tint Color", Color) = (0,0.4627451,1,0)
		[Enum(RGB,14,RGBA,15)]_ColorMask("Color Mask", Float) = 15
		_AlphaTexture("Alpha Texture", 2D) = "white" {}
		_Displacement("Displacement", 2D) = "black" {}
		_FadeMask("Fade Mask", 2D) = "white" {}
		[KeywordEnum(NoFadeMask,FadeMask,DisplacedFadeMask)] _FadeMaskSettings("Fade Mask Settings", Float) = 0
		_DisplacementIntensity("Displacement Intensity", Float) = 1
		_DisplacementSpeed("Displacement Speed", Float) = 0.3
		_DisplacementOffset("Displacement Offset", Vector) = (0,0,0,0)
		_AlphaTextureMovement("Alpha Texture Movement", Vector) = (0,0,0,0)
		[Toggle]_SeparateAxis1("Separate Axis 1", Float) = 0
		[Toggle]_SeparateAxis2("Separate Axis 2", Float) = 0
		_ColorBurn("Color Burn", Range( 0 , 1)) = 0
		_ColorGlow("Color Glow", Float) = 1
		[Header(Alpha Fall Off Settings)][Space]_AlphaFalloffRotation("Alpha Falloff Rotation", Range( 0 , 360)) = 0.25
		_AlphaFalloffOffset("Alpha Falloff Offset", Float) = 0
		_AlphaFalloffPower("Alpha Falloff Power", Float) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask [_ColorMask]
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"

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
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _CustomColors_ON
			#pragma shader_feature_local _FADEMASKSETTINGS_NOFADEMASK _FADEMASKSETTINGS_FADEMASK _FADEMASKSETTINGS_DISPLACEDFADEMASK


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _ColorMask;
			uniform float4 _Color;
			uniform sampler2D _AlphaTexture;
			uniform float4 _AlphaTexture_ST;
			uniform sampler2D _Displacement;
			uniform float _DisplacementSpeed;
			uniform float _SeparateAxis1;
			uniform float4 _Displacement_ST;
			uniform float _SeparateAxis2;
			uniform float _DisplacementIntensity;
			uniform float2 _DisplacementOffset;
			uniform float2 _AlphaTextureMovement;
			uniform sampler2D _FadeMask;
			uniform float4 _FadeMask_ST;
			uniform float _ColorGlow;
			uniform float _ColorBurn;
			uniform float _AlphaFalloffOffset;
			uniform float _AlphaFalloffRotation;
			uniform float _AlphaFalloffPower;
			struct Gradient
			{
				int type;
				int colorsLength;
				int alphasLength;
				float4 colors[8];
				float2 alphas[8];
			};
			
			Gradient NewGradient(int type, int colorsLength, int alphasLength, 
			float4 colors0, float4 colors1, float4 colors2, float4 colors3, float4 colors4, float4 colors5, float4 colors6, float4 colors7,
			float2 alphas0, float2 alphas1, float2 alphas2, float2 alphas3, float2 alphas4, float2 alphas5, float2 alphas6, float2 alphas7)
			{
				Gradient g;
				g.type = type;
				g.colorsLength = colorsLength;
				g.alphasLength = alphasLength;
				g.colors[ 0 ] = colors0;
				g.colors[ 1 ] = colors1;
				g.colors[ 2 ] = colors2;
				g.colors[ 3 ] = colors3;
				g.colors[ 4 ] = colors4;
				g.colors[ 5 ] = colors5;
				g.colors[ 6 ] = colors6;
				g.colors[ 7 ] = colors7;
				g.alphas[ 0 ] = alphas0;
				g.alphas[ 1 ] = alphas1;
				g.alphas[ 2 ] = alphas2;
				g.alphas[ 3 ] = alphas3;
				g.alphas[ 4 ] = alphas4;
				g.alphas[ 5 ] = alphas5;
				g.alphas[ 6 ] = alphas6;
				g.alphas[ 7 ] = alphas7;
				return g;
			}
			
			float4 SampleGradient( Gradient gradient, float time )
			{
				float3 color = gradient.colors[0].rgb;
				UNITY_UNROLL
				for (int c = 1; c < 8; c++)
				{
				float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, (float)gradient.colorsLength-1));
				color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
				}
				#ifndef UNITY_COLORSPACE_GAMMA
				color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
				#endif
				float alpha = gradient.alphas[0].x;
				UNITY_UNROLL
				for (int a = 1; a < 8; a++)
				{
				float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, (float)gradient.alphasLength-1));
				alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
				}
				return float4(color, alpha);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_color = v.color;
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
				float2 texCoord32 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float Time60 = ( _Time.y * (0.0 + (_DisplacementSpeed - 0.0) * (-1.0 - 0.0) / (1.0 - 0.0)) );
				float2 Axis150 = (( _SeparateAxis1 )?( float2( -2,0 ) ):( float2( 0,2 ) ));
				float2 texCoord43 = i.ase_texcoord1.xy * _Displacement_ST.xy + _Displacement_ST.zw;
				float2 panner41 = ( Time60 * Axis150 + texCoord43);
				float2 Axis251 = (( _SeparateAxis2 )?( float2( -1.25,0 ) ):( float2( 0,1.25 ) ));
				float2 panner42 = ( Time60 * Axis251 + texCoord43);
				float2 appendResult29 = (float2(tex2D( _Displacement, panner41 ).r , tex2D( _Displacement, panner42 ).g));
				float2 temp_output_38_0 = ( appendResult29 * _DisplacementIntensity );
				float2 temp_output_97_0 = ( _AlphaTextureMovement * _Time.y );
				float4 tex2DNode6 = tex2D( _AlphaTexture, ( (texCoord32*_AlphaTexture_ST.xy + temp_output_38_0) + _DisplacementOffset + temp_output_97_0 ) );
				float2 texCoord99 = i.ase_texcoord1.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
				float4 tex2DNode70 = tex2D( _AlphaTexture, ( temp_output_97_0 + texCoord99 ) );
				float2 texCoord75 = i.ase_texcoord1.xy * _FadeMask_ST.xy + _FadeMask_ST.zw;
				float4 tex2DNode7 = tex2D( _FadeMask, texCoord75 );
				float2 texCoord67 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode65 = tex2D( _FadeMask, (texCoord67*_FadeMask_ST.xy + temp_output_38_0) );
				#if defined(_FADEMASKSETTINGS_NOFADEMASK)
				float4 staticSwitch63 = tex2DNode70;
				#elif defined(_FADEMASKSETTINGS_FADEMASK)
				float4 staticSwitch63 = tex2DNode7;
				#elif defined(_FADEMASKSETTINGS_DISPLACEDFADEMASK)
				float4 staticSwitch63 = tex2DNode65;
				#else
				float4 staticSwitch63 = tex2DNode70;
				#endif
				float4 lerpResult11 = lerp( float4( 0,0,0,0 ) , ( ( i.ase_color * _Color * i.ase_color.a ) * tex2DNode6 * staticSwitch63 ) , _ColorGlow);
				#if defined(_FADEMASKSETTINGS_NOFADEMASK)
				float staticSwitch64 = tex2DNode70.r;
				#elif defined(_FADEMASKSETTINGS_FADEMASK)
				float staticSwitch64 = tex2DNode7.r;
				#elif defined(_FADEMASKSETTINGS_DISPLACEDFADEMASK)
				float staticSwitch64 = tex2DNode65.r;
				#else
				float staticSwitch64 = tex2DNode70.r;
				#endif
				float lerpResult5 = lerp( 0.0 , ( tex2DNode6.r * staticSwitch64 ) , _ColorGlow);
				Gradient gradient109 = NewGradient( 0, 2, 2, float4( 1, 1, 1, 0 ), float4( 0, 0, 0, 1 ), 0, 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
				float2 temp_cast_1 = (_AlphaFalloffOffset).xx;
				float2 texCoord107 = i.ase_texcoord1.xy * float2( 1,1 ) + temp_cast_1;
				float cos106 = cos( (0.0 + (( _AlphaFalloffRotation + 90.0 ) - 0.0) * (6.28 - 0.0) / (360.0 - 0.0)) );
				float sin106 = sin( (0.0 + (( _AlphaFalloffRotation + 90.0 ) - 0.0) * (6.28 - 0.0) / (360.0 - 0.0)) );
				float2 rotator106 = mul( texCoord107 - float2( 0.5,0.5 ) , float2x2( cos106 , -sin106 , sin106 , cos106 )) + float2( 0.5,0.5 );
				float4 temp_cast_3 = (_AlphaFalloffPower).xxxx;
				float4 Falloff105 = saturate( pow( SampleGradient( gradient109, rotator106.x ) , temp_cast_3 ) );
				float4 appendResult1 = (float4(lerpResult11.rgb , ( lerpResult5 * _ColorBurn * Falloff105 ).r));
				
				
				finalColor = appendResult1;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}