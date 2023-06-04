Shader "Custom/CircleDraw"
{
    Properties
    {
        _Radius ("Radius", Range(0,10)) = 2
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

        float _Radius;

        struct Input
        {
            float3 worldPos;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float dist = distance(fixed3(0, 0, 0), IN.worldPos);
            if (_Radius < dist)
            {
                o.Albedo = fixed4(110 / 255.0, 87 / 255.0, 139 / 255.0, 1);
            }
            else
            {
                o.Albedo = fixed4(1, 1, 1, 1);
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}