Shader "Custom/Snow" { // "Snow"という名前のカスタムシェーダを定義
    Properties {
        _Color ("Color", Color) = (1,1,1,1) // 基本色
        _MainTex ("Albedo (RGB)", 2D) = "white" {} // アルベドマップ（色テクスチャ）
        _Glossiness ("Smoothness", Range(0,1)) = 0.5 // 表面の平滑度（光沢度）
        _Metallic ("Metallic", Range(0,1)) = 0.0 // 表面の金属感
        _Snow("Snow", Range(0,2))= 0.0 // 雪の量を制御
        _SnowColor("SnowColor", Color) = (1,1,1,1) // 雪の色
        
    }
    SubShader {
        Tags { }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows // レンダリングモデルを"Standard"に設定、全てのシャドウタイプをサポート
        #pragma target 3.0 // ターゲットプラットフォームのシェーダモデルバージョンを3.0に設定
        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex; // テクスチャ座標
            float3 worldNormal; // ワールド空間でのノーマルベクトル
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _SnowColor;
        half _Snow;
    
        void surf (Input IN, inout SurfaceOutputStandard o) {
            float d = dot(IN.worldNormal, fixed3(0, 1, 0)); // ワールド空間でのノーマルベクトルと上方向（0,1,0）の内積。表面が上向きかどうか判定
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color; // テクスチャから色情報取得、基本色で調整
            c = lerp(c, _SnowColor, d*_Snow); // 表面色と雪の色を内積結果と雪の量でブレンド

            o.Albedo = c.rgb; // ブレンドした色をアルベド（反射色）として出力
            o.Metallic = _Metallic; // 金属感出力
            o.Smoothness = _Glossiness; // 平滑度（光沢度）出力
            o.Alpha = 1; // アルファ値固定（透明でない）
            }
        ENDCG
    }
    FallBack "Diffuse" // シェーダがサポートされていない場合のフォールバック
}
