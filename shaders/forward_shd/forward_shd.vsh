struct VertexShaderInput
{
	float3 pos : POSITION;
	float2 uv : TEXCOORD0;
	float3 norm : NORMAL0;
};

struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
	float brightness : TEXCOORD1;
};

uniform float4x4 u_mLightViewProj;

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    float4 pos = float4(input.pos, 1.0);
	pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], pos);
    output.pos = pos;
    output.uv = input.uv;
	float3 norm = mul(gm_Matrices[MATRIX_WORLD], float4(input.norm, 0.0)).xyz;
	output.brightness = max(dot(norm, normalize(float3(1.0, 1.0, 1.0))), 0.0) * 1.0 + 0.5;
	
    return output;
}