struct VertexShaderInput
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD0;
};

struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
	float2 depth : TEXCOORD1;
};

uniform float4x4 u_mLightViewProj;

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    float4 pos = float4(input.pos, 1.0);
	pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], pos);
    output.pos = pos;
    output.uv = input.uv;   
	
	pos.z /= pos.w;
	output.depth.x = pos.z
	output.depth.y = mul(mul(gm_Matrices[MATRIX_WORLD], u_mLightViewProj), pos.z);
	
    return output;
}