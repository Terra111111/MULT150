// Made with Amplify Shader Editor v1.9.1.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "N5KK7/OverlayV2"
{
	Properties
	{
		_Color("Tint Color", Color) = (1,0,0,0)
		[Header(Rainbow)][Space][Toggle]_EnableRainbow("Enable Rainbow", Float) = 0
		[KeywordEnum(X,Y)] _RainbowOrientation("Rainbow Orientation", Float) = 0
		[Header(Color)][Toggle(_CustomColors)] _CustomColors("CustomColors", Float) = 0
		[Header(Glow)][Space]_Brightniss("Brightniss", Float) = 1
		_AlphaGlow("Alpha Glow", Range( 0 , 1)) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		GrabPass{ "_Refraction" }

		Pass
		{
			Name "Unlit"

			CGPROGRAM

			#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
			#else
			#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
			#endif


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature_local _CustomColors
			#pragma shader_feature_local _RAINBOWORIENTATION_X _RAINBOWORIENTATION_Y


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _EnableRainbow;
			uniform float4 _Color;
			uniform float _Brightniss;
			ASE_DECLARE_SCREENSPACE_TEXTURE( _Refraction )
			uniform float _AlphaGlow;
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

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord2 = v.vertex;
				
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
				Gradient gradient6 = NewGradient( 0, 8, 2, float4( 1, 0, 0, 0 ), float4( 1, 0.5291772, 0, 0.142855 ), float4( 1, 1, 0, 0.2857099 ), float4( 0.4862278, 1, 0, 0.4285649 ), float4( 0, 1, 0.7303271, 0.5714351 ), float4( 0, 0.5274172, 1, 0.7142901 ), float4( 0.7247448, 0, 1, 0.857145 ), float4( 1, 0, 0, 1 ), float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
				float2 temp_cast_0 = (_Time.y).xx;
				float2 texCoord8 = i.ase_texcoord1.xy * float2( 1,1 ) + temp_cast_0;
				#if defined(_RAINBOWORIENTATION_X)
				float staticSwitch22 = texCoord8.x;
				#elif defined(_RAINBOWORIENTATION_Y)
				float staticSwitch22 = texCoord8.y;
				#else
				float staticSwitch22 = texCoord8.x;
				#endif
				float4 unityObjectToClipPos1 = UnityObjectToClipPos( i.ase_texcoord2.xyz );
				float4 computeGrabScreenPos3 = ComputeGrabScreenPos( unityObjectToClipPos1 );
				float4 screenColor4 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_Refraction,computeGrabScreenPos3.xy/computeGrabScreenPos3.w);
				float grayscale16 = (screenColor4.rgb.r + screenColor4.rgb.g + screenColor4.rgb.b) / 3;
				float4 appendResult21 = (float4(( ( (( _EnableRainbow )?( SampleGradient( gradient6, frac( staticSwitch22 ) ) ):( _Color )) * _Brightniss ) * screenColor4 ).rgb , ( grayscale16 * _AlphaGlow )));
				
				
				finalColor = appendResult21;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19103
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;1;-670.5,-463.75;Inherit;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;2;-864.5,-462.75;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeGrabScreenPosHlpNode;3;-480,-464;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenColorNode;4;-288,-464;Inherit;False;Global;_Refraction;Refraction;5;0;Create;True;0;0;0;False;0;False;Object;-1;True;True;False;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-64,-672;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;112,-608;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCGrayscale;16;112,-512;Inherit;True;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;416,-496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;577.5996,-571.9797;Inherit;False;COLOR;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;20;799,-644;Float;False;True;-1;2;ASEMaterialInspector;100;5;N5KK7/OverlayV2;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.ColorNode;5;-608,-688;Inherit;False;Property;_Color;Tint Color;0;0;Create;False;0;0;0;False;0;False;1,0,0,0;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;123.3367,-284.5025;Inherit;False;Property;_AlphaGlow;Alpha Glow;5;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;13;-323,-737;Inherit;False;Property;_EnableRainbow;Enable Rainbow;1;0;Create;True;0;0;0;False;2;Header(Rainbow);Space;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;24;-1256.972,-578.7048;Inherit;False;Property;_CustomColors;CustomColors;3;0;Create;False;0;0;0;True;1;Header(Color);False;0;0;0;True;_CustomColors;Toggle;2;X;Y;Create;True;False;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-327.4004,-630.9797;Inherit;False;Property;_Brightniss;Brightniss;4;0;Create;True;0;0;0;False;2;Header(Glow);Space;False;1;3.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;6;-1076.038,-946.1013;Inherit;False;0;8;2;1,0,0,0;1,0.5291772,0,0.142855;1,1,0,0.2857099;0.4862278,1,0,0.4285649;0,1,0.7303271,0.5714351;0,0.5274172,1,0.7142901;0.7247448,0,1,0.857145;1,0,0,1;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.GradientSampleNode;7;-830.0383,-932.1013;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;9;-1038.038,-868.1013;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1943.892,-842.4359;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1548.038,-872.1013;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;11;-1742.038,-852.1013;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;22;-1329.382,-848.7567;Inherit;False;Property;_RainbowOrientation;Rainbow Orientation;2;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;X;Y;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
WireConnection;1;0;2;0
WireConnection;3;0;1;0
WireConnection;4;0;3;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;12;0;14;0
WireConnection;12;1;4;0
WireConnection;16;0;4;0
WireConnection;18;0;16;0
WireConnection;18;1;19;0
WireConnection;21;0;12;0
WireConnection;21;3;18;0
WireConnection;20;0;21;0
WireConnection;13;0;5;0
WireConnection;13;1;7;0
WireConnection;7;0;6;0
WireConnection;7;1;9;0
WireConnection;9;0;22;0
WireConnection;8;1;11;0
WireConnection;11;0;10;0
WireConnection;22;1;8;1
WireConnection;22;0;8;2
ASEEND*/
//CHKSM=5CA469DF51511E2B780AD1F86A69B5E0E9CF6203