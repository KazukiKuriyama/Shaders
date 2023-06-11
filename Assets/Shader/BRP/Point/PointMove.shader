Shader "Custom/VertexColor" 
{    
    Properties     
    {         
        _PointSize("Point size", Float) = 1 
        _Speed("Color Change Speed", Float) = 1 
        _MovementSpeed("Movement Speed", Float) = 0.1 // Add movement speed property
    }       
    SubShader     
    {         
        Pass         
        {             
            LOD 200                         

            CGPROGRAM             
            #pragma vertex vert
            #pragma fragment frag               

            uniform float _PointSize;     
            uniform float _Speed; 
            uniform float _MovementSpeed; // Add movement speed uniform

            struct VertexInput             
            {                 
                float4 vertex: POSITION;                 
                float4 color: COLOR;            
            };               

            struct VertexOutput          
            {
                float4 pos: SV_POSITION;                 
                float4 col: COLOR;                 
                float size: PSIZE;            
            };               

            void vert(VertexInput v, out VertexOutput o)
            {
                 v.vertex.y += sin(_Time.y * _MovementSpeed); // Move the vertex position over time
                 o.pos = UnityObjectToClipPos(v.vertex);                 
                 float time = _Time.y * _Speed; 
                 o.col = float4((sin(time) + 1.0) / 2.0, 
                                (sin(time + 2.0) + 1.0) / 2.0, 
                                (sin(time + 4.0) + 1.0) / 2.0, 
                                1.0);                 
                 o.size = _PointSize;
            }               

            float4 frag(VertexOutput o) : COLOR             
            {                 
                return o.col;             
            }             
            ENDCG         
        }     
    } 
}
