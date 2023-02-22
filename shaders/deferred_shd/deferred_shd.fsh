struct PixelShaderInput
{
    float4 pos : SV_POSITION;
    float2 uv : TEXCOORD0;
	float depth : TEXCOORD1;
};

struct PixelShaderOutput {
	float4 color : SV_Target0;
	float4 depthFromView : SV_Target1;
};

float3 packDepth(const float value) {
	const float3 bitSh = float3(256.0*256.0, 256.0, 1.0);
	return frac(value * bitSh);
}

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
    output.color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	output.depthFromView.rgb = packDepth(input.depth).rgb;
	output.depthFromView.a = 1.0;
	
    return output;
}
