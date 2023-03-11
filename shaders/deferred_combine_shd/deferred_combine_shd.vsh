struct VertexShaderInput 
{
	float3 pos : POSITION;
	float4 color : COLOR0;
	float2 uv : TEXCOORD0;
};

struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
};

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    output.pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(input.pos, 1.0));
	
	output.uv = input.uv;
	
	return output;
}