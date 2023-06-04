Shader "Custom/CircleDraw"
{
    Properties
    {
        _Radius ("Radius", Range(0,10)) = 2
        _Speed ("Speed", Range(0,500)) = 2
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard
        #pragma target 3.0

        float _Radius;
        float _Speed;

        struct Input
        {
            float3 worldPos;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float dist = distance(fixed3(0, 0, 0), IN.worldPos);
            float val = abs(sin(dist * 3.0 - _Time * _Speed));
            if (val > 0.98)
            {
                o.Albedo = fixed4(1, 1, 1, 1);
            }
            else
            {
                o.Albedo = fixed4(110 / 255.0, 87 / 255.0, 139 / 255.0, 1);
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}