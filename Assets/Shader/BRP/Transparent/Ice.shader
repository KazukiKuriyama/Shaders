Shader "Custom/Ice"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        float4 _Color;

        struct Input
        {
            float3 worldNormal;
            float3 viewDir;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float4 color = _Color;
            o.Albedo = color;
            const float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
            o.Alpha = alpha * 0.8f;
        }
        ENDCG
    }
    FallBack "Diffuse"
}