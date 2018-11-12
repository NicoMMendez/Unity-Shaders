﻿Shader "Custom/060-069/063_Union"
{
    Properties
    {
        _Divisor ("Divisor", Int) = 1
    }
    
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            int _Divisor;
            
            float drawLine(float2 uv, float start, float width)
            {
                if ((uv.x > start && uv.x < start + width) || (uv.y > start && uv.y < start + width)) 
                {
                    return 1;
                }
                return 0;
            }
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }
            
            fixed4 frag(vertexOutput i) : SV_TARGET
            {
                fixed4 col;
                col.rgb = abs(_SinTime) / _Divisor;
                col.a = drawLine(i.uv, abs(sin(_Time.y / _Divisor)), 0.2);
                return col;
            }
            ENDCG
        }
    }
}   