struct PixelShaderInput {
	float4 pos : SV_POSITION;
	float depth : TEXCOORD0;
};

struct PixelShaderOutput {
	float4 depth : SV_Target0;
};

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
    output.depth = float4(input.depth, 0.0, 0.0, 1.0);
	
    return output;
}
