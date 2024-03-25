// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Knight~/TildaFireV1.2"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		[Toggle]_EnableGlow("Enable Glow", Float) = 0
		_Brightness("Brightness", Float) = 0
		_Glow("Glow", Range( 0 , 2)) = 0
		_Contrast("Contrast", Range( 0 , 5)) = 0
		_BackgroundTexture("Background Texture", 2D) = "white" {}
		_Dispacement("Dispacement", 2D) = "white" {}
		_DisplacementIntensity("Displacement Intensity", Range( -10 , 10)) = 0
		_Speed("Speed", Vector) = (0,0,0,0)
		_Displacement2("Displacement 2", 2D) = "white" {}
		_Displacement2Intensity("Displacement 2 Intensity", Range( -10 , 10)) = 0
		_Speed2("Speed 2", Vector) = (0,0,0,0)
		_BackgroundTilling("Background Tilling", Vector) = (0,0,0,0)
		_BackgroundOffset("Background Offset", Vector) = (0,0,0,0)
		_FadeMask1("Fade Mask 1", 2D) = "white" {}
		_FadeMask1Speed("Fade Mask 1 Speed", Vector) = (0,0,0,0)
		_FadeMask1Size("Fade Mask 1 Size", Range( 0 , 5)) = 1.5
		_FadeMask2("Fade Mask 2", 2D) = "white" {}
		_LerpValue("Lerp Value", Range( -1 , 1)) = 0

	}
	
	SubShader
	{
		
		
		Tags {  }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One OneMinusSrcAlpha, [_EnableGlow] OneMinusSrcColor
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		
		
		
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
			#define ASE_NEEDS_FRAG_COLOR


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

			uniform float _EnableGlow;
			uniform float4 _Color;
			uniform float _Contrast;
			uniform float _Brightness;
			uniform sampler2D _BackgroundTexture;
			uniform sampler2D _Dispacement;
			uniform float2 _Speed;
			uniform float4 _Dispacement_ST;
			uniform float _DisplacementIntensity;
			uniform float2 _BackgroundTilling;
			uniform float2 _BackgroundOffset;
			uniform sampler2D _Displacement2;
			uniform float2 _Speed2;
			uniform float4 _Displacement2_ST;
			uniform float _Displacement2Intensity;
			uniform sampler2D _FadeMask1;
			uniform float3 _FadeMask1Speed;
			uniform float _FadeMask1Size;
			uniform sampler2D _FadeMask2;
			uniform float _LerpValue;
			uniform float _Glow;
			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
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
				float4 temp_output_220_0 = ( i.ase_color * _Color );
				float4 lerpResult221 = lerp( temp_output_220_0 , float4( 0,0,0,0 ) , float4( 0,0,0,0 ));
				float2 texCoord168 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv_Dispacement = i.ase_texcoord1.xy * _Dispacement_ST.xy + _Dispacement_ST.zw;
				float2 panner174 = ( 1.0 * _Time.y * _Speed + uv_Dispacement);
				float2 texCoord248 = i.ase_texcoord1.xy * _BackgroundTilling + _BackgroundOffset;
				float2 uv_Displacement2 = i.ase_texcoord1.xy * _Displacement2_ST.xy + _Displacement2_ST.zw;
				float2 panner237 = ( 1.0 * _Time.y * _Speed2 + uv_Displacement2);
				float2 temp_cast_1 = (_FadeMask1Size).xx;
				float2 texCoord157 = i.ase_texcoord1.xy * temp_cast_1 + float2( 0,0 );
				float2 panner158 = ( 1.0 * _Time.y * _FadeMask1Speed.xy + texCoord157);
				float2 texCoord155 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner117 = ( 1.0 * _Time.y * float2( 0,0 ) + texCoord155);
				float4 lerpResult131 = lerp( tex2D( _FadeMask1, panner158 ) , tex2D( _FadeMask2, panner117 ) , _LerpValue);
				float grayscale136 = Luminance(lerpResult131.rgb);
				float4 temp_output_201_0 = ( _Brightness * ( tex2D( _BackgroundTexture, ( ( texCoord168 + ( tex2D( _Dispacement, panner174 ).r * ( _DisplacementIntensity * 0.2 ) ) ) + texCoord248 + ( tex2D( _Displacement2, panner237 ).r * ( _Displacement2Intensity * 0.2 ) ) ) ) * grayscale136 ) );
				float4 appendResult206 = (float4(( lerpResult221 * CalculateContrast(_Contrast,temp_output_220_0) * temp_output_201_0 ).rgb , ( temp_output_201_0 * _Glow ).r));
				
				
				finalColor = appendResult206;
				return finalColor;
			}
			ENDCG
		}
	}
	
	
	
}
/*ASEBEGIN
Version=18900
279;73;1222;655;-291.0766;286.8542;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;170;-3228.92,536.2972;Inherit;True;Property;_Dispacement;Dispacement;6;0;Create;True;0;0;0;False;0;False;None;6beeffedac57e994d826079949c70dcf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;234;-3371.86,1341.237;Inherit;True;Property;_Displacement2;Displacement 2;9;0;Create;True;0;0;0;False;0;False;None;6beeffedac57e994d826079949c70dcf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector2Node;171;-2933.247,849.6563;Inherit;False;Property;_Speed;Speed;8;0;Create;True;0;0;0;False;0;False;0,0;0,-0.54;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;173;-2960.276,712.3041;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;235;-3103.216,1517.244;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;236;-3076.187,1654.597;Inherit;False;Property;_Speed2;Speed 2;11;0;Create;True;0;0;0;False;0;False;0,0;0,-0.54;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;174;-2726.424,711.1115;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-2634.823,-518.7101;Inherit;False;Property;_FadeMask1Size;Fade Mask 1 Size;16;0;Create;True;0;0;0;False;0;False;1.5;0.05;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-2373.918,897.0238;Inherit;False;Constant;_Float6;Float 6;12;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-2521.396,783.4101;Inherit;False;Property;_DisplacementIntensity;Displacement Intensity;7;0;Create;True;0;0;0;False;0;False;0;1.5;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-2222.104,761.8238;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;178;-2550.719,513.8683;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;211;-2437.07,-415.4143;Inherit;False;Property;_FadeMask1Speed;Fade Mask 1 Speed;15;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;155;-2081.252,-364.5933;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;157;-2334.615,-534.7562;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;239;-2516.858,1701.964;Inherit;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;237;-2869.364,1516.052;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;238;-2661.336,1629.35;Inherit;False;Property;_Displacement2Intensity;Displacement 2 Intensity;10;0;Create;True;0;0;0;False;0;False;0;1.5;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;168;-1962.656,289.6025;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;249;-2343.839,1085.667;Inherit;False;Property;_BackgroundOffset;Background Offset;13;0;Create;True;0;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;158;-2076.693,-532.1494;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;250;-2346.161,942.3083;Inherit;False;Property;_BackgroundTilling;Background Tilling;12;0;Create;True;0;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-2085.74,620.3387;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;117;-1822.029,-359.3865;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-2365.044,1566.764;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;243;-2693.659,1318.808;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;169;-1721.557,410.6911;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-1501.904,-205.2224;Inherit;False;Property;_LerpValue;Lerp Value;18;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;124;-1607.954,-386.7112;Inherit;True;Property;_FadeMask2;Fade Mask 2;17;0;Create;True;0;0;0;False;0;False;-1;None;afae872722a425c4ca6cd4aa1ec77996;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;245;-2228.68,1425.279;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;127;-1609.678,-567.8387;Inherit;True;Property;_FadeMask1;Fade Mask 1;14;0;Create;True;0;0;0;False;0;False;-1;None;8717361f89bfd434eb05de437090b28e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;248;-2106.67,1030.883;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;246;-1560.097,788.3604;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;131;-1260.67,-473.7539;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;218;-539.4241,-607.9464;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;134;-1362.296,506.4609;Inherit;True;Property;_BackgroundTexture;Background Texture;5;0;Create;True;0;0;0;False;0;False;-1;None;a5fc303df0f48274aa0428e08de62ee9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;197;-581.4728,-450.3567;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;136;-1117.841,-264.1643;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-298.6847,-462.9427;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-722.5894,511.5557;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;199;-584.6707,-252.5286;Inherit;False;Property;_Contrast;Contrast;4;0;Create;True;0;0;0;False;0;False;0;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-472.9581,-31.90785;Inherit;False;Property;_Brightness;Brightness;2;0;Create;True;0;0;0;False;0;False;0;2.21;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;-252.4734,16.18124;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;2,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-293.2422,340.3364;Inherit;False;Property;_Glow;Glow;3;0;Create;True;0;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;221;-96.20012,-534.0684;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;198;-120.6028,-367.5686;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;242.8185,-76.40367;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;29.2686,241.3886;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;216;843.7386,71.05002;Inherit;False;Property;_EnableGlow;Enable Glow;1;1;[Toggle];Create;True;0;2;Off;0;On;1;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;569.5386,154.3868;Inherit;True;COLOR;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCGrayscale;141;-1032.728,503.5814;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;842.5105,158.9581;Float;False;True;-1;2;ASEMaterialInspector;100;1;Knight~/TildaFireV1.2;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;3;1;False;216;10;False;216;1;0;True;216;6;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;False;-1;True;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;1;RenderType==RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;173;2;170;0
WireConnection;235;2;234;0
WireConnection;174;0;173;0
WireConnection;174;2;171;0
WireConnection;176;0;175;0
WireConnection;176;1;180;0
WireConnection;178;0;170;0
WireConnection;178;1;174;0
WireConnection;157;0;156;0
WireConnection;237;0;235;0
WireConnection;237;2;236;0
WireConnection;158;0;157;0
WireConnection;158;2;211;0
WireConnection;179;0;178;1
WireConnection;179;1;176;0
WireConnection;117;0;155;0
WireConnection;240;0;238;0
WireConnection;240;1;239;0
WireConnection;243;0;234;0
WireConnection;243;1;237;0
WireConnection;169;0;168;0
WireConnection;169;1;179;0
WireConnection;124;1;117;0
WireConnection;245;0;243;1
WireConnection;245;1;240;0
WireConnection;127;1;158;0
WireConnection;248;0;250;0
WireConnection;248;1;249;0
WireConnection;246;0;169;0
WireConnection;246;1;248;0
WireConnection;246;2;245;0
WireConnection;131;0;127;0
WireConnection;131;1;124;0
WireConnection;131;2;125;0
WireConnection;134;1;246;0
WireConnection;136;0;131;0
WireConnection;220;0;218;0
WireConnection;220;1;197;0
WireConnection;145;0;134;0
WireConnection;145;1;136;0
WireConnection;201;0;202;0
WireConnection;201;1;145;0
WireConnection;221;0;220;0
WireConnection;198;1;220;0
WireConnection;198;0;199;0
WireConnection;200;0;221;0
WireConnection;200;1;198;0
WireConnection;200;2;201;0
WireConnection;204;0;201;0
WireConnection;204;1;142;0
WireConnection;206;0;200;0
WireConnection;206;3;204;0
WireConnection;1;0;206;0
ASEEND*/
//CHKSM=F28A5885125198A78DD0C499805B9FF2EB01DA8F