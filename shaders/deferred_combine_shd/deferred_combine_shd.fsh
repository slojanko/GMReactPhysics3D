struct PixelShaderInput 
{
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
};

struct PixelShaderOutput 
{
	float4 color : SV_Target0;
};

uniform float4x4 u_mLightViewProj;

Texture2D t_WorldPos: register(t1);
SamplerState s_WorldPos: register(s1);
Texture2D t_Norm: register(t2);
SamplerState s_Norm: register(s2);
Texture2D t_Depth: register(t3);
SamplerState s_Depth: register(s3);

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
	float4 color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	float4 worldpos = t_WorldPos.Sample(s_WorldPos, input.uv);
	float3 norm = t_Norm.Sample(s_Norm, input.uv).xyz;
	float depth = t_Depth.Sample(s_Depth, input.uv).r;
	
	float shadow = (mul(u_mLightViewProj, worldpos).z - depth) > 1.0 ? 0.0 : 1.0;
	float brightness = max(dot(norm, normalize(float3(1.0, 1.0, 1.0))), 0.0) * 1.0 + 0.5;
	
	output.color = float4(abs(mul(u_mLightViewProj, worldpos).z / 256.0 - depth) < 1.0 ? 1.0 : 0.0, 0.0, 0.0, 1.0); //color * shadow * brightness;
	
	//output.pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(input.pos, 1.0));
	//output.color = input.color;
	//output.depthFromLight = mul(u_mLightViewProj, mul(gm_Matrices[MATRIX_WORLD], float4(input.world_pos, 1.0))).z;
	//output.brightness = max(dot(input.norm.xyz, normalize(float3(1.0, 1.0, 1.0))), 0.0) * 1.0 + 0.5;
	//output.depth = input.depth;
	
	return output;
}
