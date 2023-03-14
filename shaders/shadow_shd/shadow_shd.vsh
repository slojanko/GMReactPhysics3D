struct VertexShaderInput
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD0;
	float3 norm : NORMAL0;
};

struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float depth : TEXCOORD0;
};

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    output.pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(input.pos, 1.0));
	output.depth = (output.pos.z / output.pos.w) * 0.5 + 0.5;
	
    return output;
}