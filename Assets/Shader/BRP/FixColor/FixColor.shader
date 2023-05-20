Shader "Custom/Sample"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        // 物理ベースのスタンダード照明モデルを使用し、すべての光源で影を有効にします
        #pragma surface surf Standard fullforwardshadows

        // より良い照明を得るために、シェーダーモデル3.0をターゲットとして使用します
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // このシェーダーにインスタンシングのサポートを追加します。このシェーダーを使用するマテリアルでは「Enable Instancing」にチェックを入れる必要があります。
        // インスタンシングに関する詳細は https://docs.unity3d.com/Manual/GPUInstancing.html をご参照ください。
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
        // ここにさらなるインスタンスごとのプロパティを配置します
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // アルベドは色によって調整されたテクスチャから来ます
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            // o.Albedo = c.rgb;
            o.Albedo = fixed4(0.1f,0.1f,0.1f,1);
            // メタリックと滑らかさはスライダーの変数から来ます
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}