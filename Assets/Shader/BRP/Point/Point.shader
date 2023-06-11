Shader "Custom/VertexColor" 
{    
    Properties     
    {         
        _PointSize("Point size", Float) = 1 // ポイントサイズのプロパティを定義します
        _Speed("Color Change Speed", Float) = 1 // 色の変化速度のプロパティを定義します
    }       
    SubShader     
    {         
        Pass         
        {             
            LOD 200 // このシェーダーの詳細レベル                         

            CGPROGRAM             
            #pragma vertex vert // 頂点シェーダー関数
            #pragma fragment frag // フラグメントシェーダー関数

            uniform float _PointSize; // プロパティからのポイントサイズユニフォーム    
            uniform float _Speed; // プロパティからの色の変化速度ユニフォーム

            struct VertexInput // 頂点シェーダーへの入力            
            {                 
                float4 vertex: POSITION; // 頂点の位置
                float4 color: COLOR; // 頂点の色
            };               

            struct VertexOutput // 頂点シェーダーからの出力
            {
                float4 pos: SV_POSITION; // スクリーン座標の位置
                float4 col: COLOR; // 頂点の色
                float size: PSIZE; // ポイントのサイズ
            };               

            void vert(VertexInput v, out VertexOutput o) // 頂点シェーダー関数
            {
                 o.pos = UnityObjectToClipPos(v.vertex); // 位置をオブジェクト空間からクリップ空間に変換
                 float time = _Time.y * _Speed; // 現在の時間を取得し、速度で乗算
                 // 調整された時間のsinに基づいて時間とともに変化する色を作成
                 o.col = float4((sin(time) + 1.0) / 2.0, 
                                (sin(time + 2.0) + 1.0) / 2.0, 
                                (sin(time + 4.0) + 1.0) / 2.0, 
                                1.0); // アルファ
                 o.size = _PointSize; // ポイントサイズを設定
            }               

            float4 frag(VertexOutput o) : COLOR // フラグメントシェーダー関数
            {                 
                return o.col; // 頂点の色を返す
            }             
            ENDCG // シェーダープログラムの終了        
        }     
    } 
}
