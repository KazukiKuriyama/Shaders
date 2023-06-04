Shader "Unlit/culloff"
{
    // プロパティブロック: シェーダーによって操作されるパラメーターの宣言
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {} // メインのテクスチャ
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Transparent" // レンダリングタイプは透明
            "Queue"="Transparent" // レンダリングキューは透明
        }
        LOD 200 // LODの値は200
        Cull off // カリングは無効（両面をレンダリング）
        Blend SrcAlpha OneMinusSrcAlpha // ブレンディングモード（アルファブレンディング）

        Pass
        {
            CGPROGRAM
            #pragma vertex vert        // 頂点シェーダの定義
            #pragma fragment frag      // フラグメントシェーダの定義

            #include "UnityCG.cginc"   // Unityの共通CGインクルード

            // 頂点データ構造体
            struct appdata
            {
                float4 vertex : POSITION; // 頂点位置
                float2 uv : TEXCOORD0; // テクスチャUV座標
            };

            // 頂点からフラグメントへのデータ構造体
            struct v2f
            {
                float2 uv : TEXCOORD0; // テクスチャUV座標
                float4 vertex : SV_POSITION; // クリップ空間での頂点位置
            };

            sampler2D _MainTex; // テクスチャサンプラー
            float4 _MainTex_ST; // テクスチャのスケールとトランスレーション情報

            // 頂点シェーダ
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); // 頂点位置の変換
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); // UV座標の変換
                return o;
            }

            // フラグメントシェーダ
            fixed4 frag(v2f i) : SV_Target
            {
                // テクスチャサンプリング
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
	}
}