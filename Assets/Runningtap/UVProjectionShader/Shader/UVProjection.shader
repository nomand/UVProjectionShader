// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Runningtap/UVProjection"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "black" {}
		_HeightMap("HeightMap", 2D) = "black" {}
		_Height("Height", Range( -2 , 2)) = 0
		[HideInInspector]_BoxPosition("BoxPosition", Vector) = (0,0,0,0)
		[HideInInspector]_BoxScale("BoxScale", Vector) = (0,0,0,0)
		[HideInInspector]_TerrainRotation("TerrainRotation", Vector) = (0,0,0,0)
		[HideInInspector]_BoxRotation("BoxRotation", Vector) = (0,0,0,0)
		_Color("Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _HeightMap;
		uniform float3 _BoxPosition;
		uniform float3 _TerrainRotation;
		uniform float3 _BoxRotation;
		uniform float3 _BoxScale;
		uniform float _Height;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 worldToObj14 = mul( unity_WorldToObject, float4( _BoxPosition, 1 ) ).xyz;
			float2 uv_TexCoord2 = v.texcoord.xy + (( worldToObj14 * 0.1 )).xz;
			float cos34 = cos( radians( ( _TerrainRotation - _BoxRotation ).y ) );
			float sin34 = sin( radians( ( _TerrainRotation - _BoxRotation ).y ) );
			float2 rotator34 = mul( uv_TexCoord2 - float2( 0.5,0.5 ) , float2x2( cos34 , -sin34 , sin34 , cos34 )) + float2( 0.5,0.5 );
			float3 _Vector1 = float3(1,1,1);
			float4 tex2DNode4 = tex2Dlod( _HeightMap, float4( ( ( rotator34 + (( ( _BoxScale - _Vector1 ) / 2.0 )).xz ) * (( _Vector1 / _BoxScale )).xz ), 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2DNode4 * _Height ) * float4( ase_vertexNormal , 0.0 ) ).rgb;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float3 worldToObj14 = mul( unity_WorldToObject, float4( _BoxPosition, 1 ) ).xyz;
			float2 uv_TexCoord2 = i.uv_texcoord + (( worldToObj14 * 0.1 )).xz;
			float cos34 = cos( radians( ( _TerrainRotation - _BoxRotation ).y ) );
			float sin34 = sin( radians( ( _TerrainRotation - _BoxRotation ).y ) );
			float2 rotator34 = mul( uv_TexCoord2 - float2( 0.5,0.5 ) , float2x2( cos34 , -sin34 , sin34 , cos34 )) + float2( 0.5,0.5 );
			float3 _Vector1 = float3(1,1,1);
			float4 tex2DNode4 = tex2D( _HeightMap, ( ( rotator34 + (( ( _BoxScale - _Vector1 ) / 2.0 )).xz ) * (( _Vector1 / _BoxScale )).xz ) );
			o.Albedo = ( tex2D( _MainTex, uv_MainTex ) + tex2DNode4 + _Color ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
92;43;1918;1027;2256.176;741.0429;1.647128;False;False
Node;AmplifyShaderEditor.Vector3Node;1;-2123.571,-485.6027;Float;False;Property;_BoxPosition;BoxPosition;3;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;6.09,0.132,4.3;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;36;-1842.211,-68.58376;Float;False;Property;_BoxRotation;BoxRotation;6;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,75.62103,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformPositionNode;14;-1878.156,-483.1237;Float;False;World;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;20;-1809.558,-325.18;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;57;-1862.008,-226.3401;Float;False;Property;_TerrainRotation;TerrainRotation;5;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;0,293.9876,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;16;-1404.89,33.3508;Float;False;Property;_BoxScale;BoxScale;4;1;[HideInInspector];Create;True;0;0;False;0;0,0,0;2.652705,1.02822,1.824577;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;22;-1401.38,206.4348;Float;False;Constant;_Vector1;Vector 1;3;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1601.299,-424.4027;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;-1586.861,-149.9111;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-1130.184,36.14439;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;60;-1418.718,-153.1866;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SwizzleNode;11;-1400.788,-397.679;Float;False;FLOAT2;0;2;2;2;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1134.773,133.5327;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;39;-1106.036,-130.594;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1174.758,-347.91;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-990.1848,35.14439;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;23;-1127.36,221.1657;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotatorNode;34;-870.65,-252.3268;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;28;-850.7438,28.85998;Float;False;FLOAT2;0;2;2;2;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;18;-973.3884,224.9754;Float;False;FLOAT2;0;2;2;2;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-630.5848,-120.1626;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-454.3117,-48.42146;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-250.9117,146.6937;Float;False;Property;_Height;Height;2;0;Create;True;0;0;False;0;0;2;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-260.298,-72.03421;Float;True;Property;_HeightMap;HeightMap;1;0;Create;True;0;0;False;0;bcbdc67f9177ca144a4592712253dbee;dfcd13f448cca2f4a908635e478b9397;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-263.1058,-284.5978;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;bcbdc67f9177ca144a4592712253dbee;dea5499cc0313044cb1768f79a1c5fc6;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;5;49.3605,219.0633;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;75.96329,33.80927;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;65;260.3678,-26.4628;Float;False;Property;_Color;Color;7;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;293.3129,160.9198;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;500.6039,-127.4175;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;659.7111,-90.81429;Float;False;True;2;Float;ASEMaterialInspector;0;0;Lambert;Runningtap/UVProjection;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;1;0
WireConnection;15;0;14;0
WireConnection;15;1;20;0
WireConnection;59;0;57;0
WireConnection;59;1;36;0
WireConnection;26;0;16;0
WireConnection;26;1;22;0
WireConnection;60;0;59;0
WireConnection;11;0;15;0
WireConnection;39;0;60;1
WireConnection;2;1;11;0
WireConnection;27;0;26;0
WireConnection;27;1;67;0
WireConnection;23;0;22;0
WireConnection;23;1;16;0
WireConnection;34;0;2;0
WireConnection;34;2;39;0
WireConnection;28;0;27;0
WireConnection;18;0;23;0
WireConnection;7;0;34;0
WireConnection;7;1;28;0
WireConnection;21;0;7;0
WireConnection;21;1;18;0
WireConnection;4;1;21;0
WireConnection;6;0;4;0
WireConnection;6;1;10;0
WireConnection;9;0;6;0
WireConnection;9;1;5;0
WireConnection;53;0;52;0
WireConnection;53;1;4;0
WireConnection;53;2;65;0
WireConnection;0;0;53;0
WireConnection;0;11;9;0
ASEEND*/
//CHKSM=77E33319C72C293C9CB9157C99BF727DB5BD88C1