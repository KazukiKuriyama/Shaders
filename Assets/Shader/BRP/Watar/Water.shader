Shader "Custom/Water"
{
    Properties
    {
        _MainTex ("Water Texture", 2D) = "white" {}
        _MoveX ("MoveX", Range(0,1)) = 0.1
        _MoveY ("MoveY", Range(0,1)) = 0.2
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        half _MoveX;
        half _MoveY;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed2 uv = IN.uv_MainTex;
            uv.x += _MoveX * _Time;
            uv.y += _MoveY * _Time;
            o.Albedo = tex2D(_MainTex, uv);
        }
        ENDCG
    }
    FallBack "Diffuse"
}