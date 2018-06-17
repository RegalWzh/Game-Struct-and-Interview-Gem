﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "MyShader/UVMove" 
{
	Properties {
		[HDR]_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_MoveX ("MoveX",Float) = 0
		_MoveY ("MoveY",Float) = 0
	}

	Category {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		
		Blend SrcAlpha One

		Cull Off Lighting Off ZWrite Off 

		SubShader {
			Pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				sampler2D _MainTex;
				float4 _MainTex_ST;
				fixed4 _TintColor;
				fixed _MoveX;
				fixed _MoveY;
				
				struct appdata_t {
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
				};

				struct v2f {
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float2 texcoord : TEXCOORD0;
				};
				


				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color;
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex) + frac(float2(_MoveX,_MoveY) * _Time.y);
					return o;
				}

				fixed4 frag (v2f i) : SV_Target
				{
					return 2.0f * i.color * _TintColor * tex2D(_MainTex, i.texcoord);
				}
				ENDCG 
			}
		} 	
	}
}