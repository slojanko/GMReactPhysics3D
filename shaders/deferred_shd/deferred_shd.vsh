struct VertexShaderInput
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD0;
	float3 norm : NORMAL0;
};

struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float3 world_pos : TEXCOORD0;
	float2 uv : TEXCOORD1;
	float3 norm : TEXCOORD2;
	float depth : TEXCOORD3;
};

uniform float4x4 u_mLightViewProj;

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    output.pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(input.pos, 1.0));
	
	output.world_pos = mul(gm_Matrices[MATRIX_WORLD], float4(input.pos, 1.0)).xyz;
	
    output.uv = input.uv;   
	
	output.norm = mul(gm_Matrices[MATRIX_WORLD], float4(input.norm, 0.0)).xyz;
	
	output.depth = mul(u_mLightViewProj, mul(gm_Matrices[MATRIX_WORLD], float4(input.pos, 1.0))).z / 256.0;
	
    return output;
}