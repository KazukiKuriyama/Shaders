Shader "Custom/Flag"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {} // メインテクスチャを設定。デフォルトは白色。
        _Wave ("Wave", Range(0,500)) = 100 // メインテクスチャを設定。デフォルトは白色。
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" } // レンダリングタイプを不透明に設定。
        LOD 200 // LOD（レベル・オブ・ディテール）値を200に設定。

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert // Lambert反射モデルを使用し、vertex関数をvertとして指定。
        #pragma target 3.0 // ターゲットシェーダモデルを3.0に設定。

        sampler2D _MainTex; // メインテクスチャへのサンプラー。
        half _Wave; // メインテクスチャへのサンプラー。

        struct Input
        {
            float2 uv_MainTex; // メインテクスチャのUV座標。
        };

        // 頂点シェーダ関数。
        void vert(inout appdata_full v, out Input o )
        {
            UNITY_INITIALIZE_OUTPUT(Input, o); // oを初期化。
            float amp = 0.5*sin(_Time*100 + v.vertex.x * _Wave); // 時間と頂点のx座標に基づく振幅を計算（波形生成）。
            v.vertex.xyz = float3(v.vertex.x, v.vertex.y+amp, v.vertex.z); // 頂点のy座標に振幅を加算して波形を作成。
        }

        // サーフェスシェーダ関数。
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex); // メインテクスチャから色を取得。
            o.Albedo = c.rgb; // アルベドに取得した色を設定。
            o.Alpha = c.a; // アルファ値に取得した色のアルファ値を設定。
        }
        ENDCG
    }
    FallBack "Diffuse" // フォールバックとしてDiffuseシェーダーを使用。
}