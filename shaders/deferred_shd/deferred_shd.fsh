struct PixelShaderInput {
	float4 pos : SV_POSITION;
	float3 world_pos : TEXCOORD0;
	float2 uv : TEXCOORD1;
	float3 norm : TEXCOORD2;
	float depth : TEXCOORD3;
};

struct PixelShaderOutput {
	float4 color : SV_Target0;
	float4 world_pos : SV_Target1;
	float4 norm : SV_Target2;
	float4 depth : SV_Target3;
};

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
    output.color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	
	output.world_pos = float4(input.world_pos, 1.0);
	
	output.norm = float4(input.norm, 1.0);
	
	output.depth = float4(input.depth, 0.0, 0.0, 1.0) ;
	
    return output;
}
