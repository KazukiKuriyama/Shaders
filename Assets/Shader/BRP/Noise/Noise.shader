Shader "Custom/Noise"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        float random(fixed2 p)
        {
            return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float c = random(IN.uv_MainTex);
            o.Albedo = fixed4(c, c, c, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}