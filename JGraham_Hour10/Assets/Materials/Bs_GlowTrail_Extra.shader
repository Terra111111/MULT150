// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "_L05am/Glow Trail Extra"
{
	Properties
	{
		[Header(Color Settings)][Enum(RGB,14,RGBA,15)]_ColorMask("Color Mask", Float) = 15
		[Toggle(_CustomColors)] _CustomColors("Custom Colors", Float) = 0
		[KeywordEnum(NoVertexColor,VertexColorforTintColor,VertexColorforGradientColor,VertexColorforBoth)] _ToggleVertexColor("Toggle Vertex Color", Float) = 0
		_Color("Tint Color", Color) = (0.4337916,0,1,1)
		_TintColorBurn("Tint Color Burn ", Float) = 0
		_GColor("Gradient Color", Color) = (1,0,0.3137255,1)
		_GradientColorBurn("Gradient Color Burn ", Float) = 0
		[Header(Gradient Settings)][Toggle]_ToggleGradient("Toggle Gradient", Float) = 1
		[KeywordEnum(UV,U,V)] _GradientUV("Gradient UV", Float) = 2
		_GradientOffset("Gradient Offset", Range( 0 , 2)) = 1
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Texture Settings)]_AlphaTexture("Alpha Texture", 2D) = "white" {}
		[Header(Displacement Texture)]_Displacement("Displacement", 2D) = "black" {}
		[Header(Second Displacement Texure)]_SecondDisplacement("Second Displacement", 2D) = "black" {}
		[Header(FadeMask Texture)]_Fademask("Fade mask", 2D) = "white" {}
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Displacement Settings)]_DisplacementIntensity("Displacement Intensity", Float) = 0.35
		_DisplacementOffset("Displacement Offset", Vector) = (0,0,0,0)
		[Header(Displacement Time and Movement Settings)]_DisplacementSpeed("Displacement Speed", Float) = 1
		[Toggle]_EnableSinTImeforDisplacement("Enable SinTIme for Displacement", Float) = 0
		[Toggle]_ToggleFademaskDisplacement("Toggle Fademask Displacement", Float) = 0
		_DisplacementDelay("Displacement Delay", Float) = 1.25
		[Header(Displacement Axis Settings)][Toggle]_SeparateAxis1("Separate Axis 1", Float) = 1
		[Toggle]_SeparateAxis2("Separate Axis 2", Float) = 0
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Second Displacement Settings)][Toggle]_ToggleSecondDisplacement("Toggle  Second Displacement", Float) = 1
		_SecondDisplacementIntesity("Second Displacement Intesity", Float) = 1
		[Header(Second Displacement Time and Movement Settings)]_SecondDisplacementSpeed("Second Displacement Speed", Float) = 1
		[Toggle]_EnableSinTImeforSecondDisplacement("Enable SinTIme for Second  Displacement", Float) = 1
		_SecondDisplacementDelay("Second Displacement Delay", Float) = 1.25
		[Header(Second Displacement Axis Settings)][Toggle]_SeparateAxis3("Separate Axis 3", Float) = 0
		[Toggle]_SeparateAxis4("Separate Axis 4", Float) = 1
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Glow Settings)][Toggle(_ENABLEGLOWREMAP_ON)] _EnableGlowRemap("Enable Glow Remap", Float) = 0
		_Glow("Glow", Range( 0 , 1)) = 1
		_Opacity("Opacity", Range( 0 , 1)) = 1
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Screenspace Settings)][Toggle]_EnableScreenspaceTexture("Enable Screenspace Texture", Float) = 1
		[Toggle]_ScreenspaceWorldDir("Screenspace World Dir", Float) = 1
		_ScreenspaceTexture("Screenspace Texture", 2D) = "white" {}
		_ScrenspaceStrength("Screnspace Strength", Float) = 1
		_ScreenspaceMovement("Screenspace Movement", Vector) = (1,0,0,0)
		[Toggle]_EnableSinTImeforScreenspace("Enable SinTIme for Screenspace", Float) = 0
		[Header(oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo)][Header(Screenspace Displacement Settings)]_ScreenspaceDisplacementTexture("Screenspace Displacement Texture", 2D) = "black" {}
		_ScreenspaceDisplacementOffset("Screenspace Displacement Offset", Vector) = (1,0,0,0)
		_ScreenspaceDisplacementMovement("Screenspace Displacement Movement", Vector) = (1,0,0,0)
		_ScreenspaceDisplacementIntesity("Screenspace Displacement Intesity", Float) = 1
		[Toggle]_EnableSinTImeforScreenspaceDisplacement("Enable SinTIme for Screenspace Displacement", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transpartent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  "PreviewType"="Plane" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		ColorMask [_ColorMask]
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _CustomColors
		#pragma shader_feature_local _TOGGLEVERTEXCOLOR_NOVERTEXCOLOR _TOGGLEVERTEXCOLOR_VERTEXCOLORFORTINTCOLOR _TOGGLEVERTEXCOLOR_VERTEXCOLORFORGRADIENTCOLOR _TOGGLEVERTEXCOLOR_VERTEXCOLORFORBOTH
		#pragma shader_feature_local _GRADIENTUV_UV _GRADIENTUV_U _GRADIENTUV_V
		#pragma shader_feature_local _ENABLEGLOWREMAP_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform float _ColorMask;
		uniform float _ToggleGradient;
		uniform float4 _Color;
		uniform float _TintColorBurn;
		uniform float4 _GColor;
		uniform float _GradientColorBurn;
		uniform float _GradientOffset;
		uniform sampler2D _Fademask;
		uniform float _ToggleFademaskDisplacement;
		uniform sampler2D _AlphaTexture;
		uniform float4 _AlphaTexture_ST;
		uniform float _ToggleSecondDisplacement;
		uniform sampler2D _Displacement;
		uniform float _DisplacementSpeed;
		uniform float _EnableSinTImeforDisplacement;
		uniform float _SeparateAxis2;
		uniform float _DisplacementDelay;
		uniform float4 _Displacement_ST;
		uniform float _SeparateAxis1;
		uniform float _DisplacementIntensity;
		uniform sampler2D _SecondDisplacement;
		uniform float _SecondDisplacementSpeed;
		uniform float _EnableSinTImeforSecondDisplacement;
		uniform float _SeparateAxis3;
		uniform float4 _SecondDisplacement_ST;
		uniform float _SeparateAxis4;
		uniform float _SecondDisplacementDelay;
		uniform float _SecondDisplacementIntesity;
		uniform float2 _DisplacementOffset;
		uniform float _Glow;
		uniform float _EnableScreenspaceTexture;
		uniform sampler2D _ScreenspaceTexture;
		uniform float _EnableSinTImeforScreenspace;
		uniform float2 _ScreenspaceMovement;
		uniform float _ScreenspaceWorldDir;
		uniform float4 _ScreenspaceTexture_ST;
		uniform sampler2D _ScreenspaceDisplacementTexture;
		uniform float4 _ScreenspaceDisplacementTexture_ST;
		uniform float _EnableSinTImeforScreenspaceDisplacement;
		uniform float2 _ScreenspaceDisplacementMovement;
		uniform float2 _ScreenspaceDisplacementOffset;
		uniform float _ScreenspaceDisplacementIntesity;
		uniform float _ScrenspaceStrength;
		uniform float _Opacity;


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			#if defined(_TOGGLEVERTEXCOLOR_NOVERTEXCOLOR)
				float4 staticSwitch410 = _Color;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORTINTCOLOR)
				float4 staticSwitch410 = i.vertexColor;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORGRADIENTCOLOR)
				float4 staticSwitch410 = _Color;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORBOTH)
				float4 staticSwitch410 = i.vertexColor;
			#else
				float4 staticSwitch410 = _Color;
			#endif
			float3 temp_output_366_0 = (( staticSwitch410 + _TintColorBurn )).rgb;
			float3 HueShift389 = temp_output_366_0;
			#if defined(_TOGGLEVERTEXCOLOR_NOVERTEXCOLOR)
				float4 staticSwitch411 = _GColor;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORTINTCOLOR)
				float4 staticSwitch411 = _GColor;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORGRADIENTCOLOR)
				float4 staticSwitch411 = i.vertexColor;
			#elif defined(_TOGGLEVERTEXCOLOR_VERTEXCOLORFORBOTH)
				float4 staticSwitch411 = i.vertexColor;
			#else
				float4 staticSwitch411 = _GColor;
			#endif
			float2 temp_cast_0 = (i.uv_texcoord.y).xx;
			float2 temp_cast_1 = (i.uv_texcoord.x).xx;
			float2 temp_cast_2 = (i.uv_texcoord.y).xx;
			#if defined(_GRADIENTUV_UV)
				float2 staticSwitch371 = i.uv_texcoord;
			#elif defined(_GRADIENTUV_U)
				float2 staticSwitch371 = temp_cast_1;
			#elif defined(_GRADIENTUV_V)
				float2 staticSwitch371 = temp_cast_0;
			#else
				float2 staticSwitch371 = temp_cast_0;
			#endif
			float grayscale381 = (float3( staticSwitch371 ,  0.0 ).r + float3( staticSwitch371 ,  0.0 ).g + float3( staticSwitch371 ,  0.0 ).b) / 3;
			float Gradient382 = ( grayscale381 * (0.0 + (_GradientOffset - 0.0) * (5.0 - 0.0) / (2.0 - 0.0)) );
			float3 lerpResult364 = lerp( (( staticSwitch411 + _GradientColorBurn )).rgb , temp_output_366_0 , Gradient382);
			float3 Color360 = (( _ToggleGradient )?( lerpResult364 ):( HueShift389 ));
			float2 uv_TexCoord16 = i.uv_texcoord * _AlphaTexture_ST.xy;
			float SinTimeDP160 = (( _EnableSinTImeforDisplacement )?( _SinTime.w ):( _Time.y ));
			float temp_output_7_0 = ( (0.0 + (_DisplacementSpeed - 0.0) * (-1.0 - 0.0) / (1.0 - 0.0)) * SinTimeDP160 );
			float2 appendResult129 = (float2(0.0 , _DisplacementDelay));
			float2 appendResult132 = (float2(_DisplacementDelay , 0.0));
			float2 Axis2114 = (( _SeparateAxis2 )?( appendResult132 ):( appendResult129 ));
			float2 uv_Displacement = i.uv_texcoord * _Displacement_ST.xy + _Displacement_ST.zw;
			float2 panner19 = ( temp_output_7_0 * Axis2114 + uv_Displacement);
			float2 Axis1115 = (( _SeparateAxis1 )?( float2( 2,0 ) ):( float2( 0,2 ) ));
			float2 panner11 = ( temp_output_7_0 * Axis1115 + uv_Displacement);
			float2 appendResult26 = (float2(tex2D( _Displacement, panner19 ).r , tex2D( _Displacement, panner11 ).g));
			float2 Displacement250 = appendResult26;
			float2 Disp275 = ( Displacement250 * _DisplacementIntensity );
			float SinTimeDP2239 = (( _EnableSinTImeforSecondDisplacement )?( _SinTime.w ):( _Time.y ));
			float temp_output_223_0 = ( (0.0 + (_SecondDisplacementSpeed - 0.0) * (-1.0 - 0.0) / (1.0 - 0.0)) * SinTimeDP2239 );
			float2 Axis3233 = (( _SeparateAxis3 )?( float2( 2,0 ) ):( float2( 0,2 ) ));
			float2 uv_SecondDisplacement = i.uv_texcoord * _SecondDisplacement_ST.xy + _SecondDisplacement_ST.zw;
			float2 panner218 = ( temp_output_223_0 * Axis3233 + uv_SecondDisplacement);
			float2 appendResult227 = (float2(0.0 , _SecondDisplacementDelay));
			float2 appendResult228 = (float2(_SecondDisplacementDelay , 0.0));
			float2 Axis4232 = (( _SeparateAxis4 )?( appendResult228 ):( appendResult227 ));
			float2 panner219 = ( temp_output_223_0 * Axis4232 + uv_SecondDisplacement);
			float4 appendResult243 = (float4(tex2D( _SecondDisplacement, panner218 ).r , tex2D( _SecondDisplacement, panner219 ).g , 0.0 , 0.0));
			float4 SDisplacement248 = ( appendResult243 * _SecondDisplacementIntesity );
			float4 lerpResult213 = lerp( float4( Disp275, 0.0 , 0.0 ) , SDisplacement248 , 0.5);
			float4 PlusPlacement253 = lerpResult213;
			float4 SecondSwitch259 = (( _ToggleSecondDisplacement )?( PlusPlacement253 ):( float4( Disp275, 0.0 , 0.0 ) ));
			float4 temp_output_73_0 = ( ( float4( uv_TexCoord16, 0.0 , 0.0 ) + SecondSwitch259 ) + float4( _DisplacementOffset, 0.0 , 0.0 ) );
			float4 tex2DNode51 = tex2D( _Fademask, (( _ToggleFademaskDisplacement )?( temp_output_73_0 ):( float4( i.uv_texcoord, 0.0 , 0.0 ) )).xy );
			#ifdef _ENABLEGLOWREMAP_ON
				float staticSwitch98 = (1.0 + (_Glow - 0.0) * (5.0 - 1.0) / (1.0 - 0.0));
			#else
				float staticSwitch98 = _Glow;
			#endif
			float Glow103 = staticSwitch98;
			float4 appendResult66 = (float4(( float4( Color360 , 0.0 ) * tex2DNode51 ).rgb , Glow103));
			o.Emission = ( appendResult66 * Glow103 ).rgb;
			float4 tex2DNode13 = tex2D( _AlphaTexture, temp_output_73_0.xy );
			float2 UV22_g6 = float4( i.viewDir , 0.0 ).xy;
			float2 localUnStereo22_g6 = UnStereo( UV22_g6 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 UV22_g7 = float4( ase_worldViewDir , 0.0 ).xy;
			float2 localUnStereo22_g7 = UnStereo( UV22_g7 );
			float2 panner144 = ( (( _EnableSinTImeforScreenspace )?( _SinTime.w ):( _Time.y )) * _ScreenspaceMovement + (( _ScreenspaceWorldDir )?( localUnStereo22_g7 ):( localUnStereo22_g6 )));
			float2 uv_TexCoord192 = i.uv_texcoord * _ScreenspaceDisplacementTexture_ST.xy + ( ( _ScreenspaceDisplacementTexture_ST.zw + ( (( _EnableSinTImeforScreenspaceDisplacement )?( _SinTime.w ):( _Time.y )) * _ScreenspaceDisplacementMovement ) ) + _ScreenspaceDisplacementOffset );
			float4 Screenspace155 = ( tex2D( _ScreenspaceTexture, ( float4( panner144, 0.0 , 0.0 ) + float4( _ScreenspaceTexture_ST.xy, 0.0 , 0.0 ) + ( tex2D( _ScreenspaceDisplacementTexture, uv_TexCoord192 ) * _ScreenspaceDisplacementIntesity ) ).rg ) * (1.0 + (_ScrenspaceStrength - 0.0) * (35.0 - 1.0) / (1.0 - 0.0)) );
			float4 lerpResult127 = lerp( float4( 0,0,0,0 ) , Screenspace155 , tex2DNode13.r);
			float4 temp_cast_23 = (_Opacity).xxxx;
			float4 blendOpSrc70 = ( ( tex2DNode51 * (( _EnableScreenspaceTexture )?( lerpResult127 ):( tex2DNode13 )) ) * _Opacity );
			float4 blendOpDest70 = temp_cast_23;
			o.Alpha = ( saturate(  (( blendOpSrc70 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc70 - 0.5 ) ) * ( 1.0 - blendOpDest70 ) ) : ( 2.0 * blendOpSrc70 * blendOpDest70 ) ) )).r;
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
			#pragma target 3.0
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				half4 color : COLOR0;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
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