Shader "Custom/TransparentRimLight"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RImColor ("RimColor", Color) = (1,1,1,1)
        _Pow ("Pow", Range(0,10)) = 2.5
        _Alpha ("Alpha", Range(0,1)) = 1
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

        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
            float3 viewDir;
        };

        fixed4 _Color;
        fixed4 _RImColor;
        float _Pow;
        float _Alpha;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 baseColor = _Color;
            fixed4 rimColor = _RImColor;
            fixed powValue = _Pow;
            fixed alpha = _Alpha;

            o.Albedo = baseColor;
            const float rim = 1 - (saturate(dot(IN.viewDir, o.Normal)));
            o.Emission = rimColor * pow(rim, powValue);
            o.Alpha = alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}