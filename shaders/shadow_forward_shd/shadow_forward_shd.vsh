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
	float3 depth : TEXCOORD2;
};

#define SHADE 0.7
#define AMBIENT 0.3

uniform float4x4 u_mLightViewProj;

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
	
    output.pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(input.pos, 1.0));
	
    output.uv = input.uv;
	
	float3 norm = mul(gm_Matrices[MATRIX_WORLD], float4(input.norm, 0.0)).xyz;
	output.brightness = max(dot(norm, normalize(float3(-1.0, 1.0, 1.0))), 0.0) * SHADE + AMBIENT;
	
	float4 depth = mul(u_mLightViewProj, mul(gm_Matrices[MATRIX_WORLD], float4(input.pos, 1.0)));
	output.depth = (depth.xyz / depth.w) * 0.5 + 0.5;
	
    return output;
}