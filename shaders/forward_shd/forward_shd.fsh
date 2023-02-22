struct PixelShaderInput
{
    float4 pos : SV_POSITION;
    float2 uv : TEXCOORD0;
	float brightness : TEXCOORD1;
};

struct PixelShaderOutput {
	float4 color : SV_Target0;
};

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
    output.color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	output.color.rgb *= input.brightness;
	
    return output;
}
