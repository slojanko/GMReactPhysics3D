struct PixelShaderInput
{
    float4 pos : SV_POSITION;
    float2 uv : TEXCOORD0;
	float brightness : TEXCOORD1;
	float3 depth : TEXCOORD2;
};

struct PixelShaderOutput {
	float4 color : SV_Target0;
};

#define LOOP 8
#define SHADE 0.7
#define AMBIENT 0.3

static const float2 offsets[LOOP] = {
	float2(2.0 / 2048, 0.0), 
	float2(-2.0 / 2048, 0.0),
	float2(0.0,	2.0 / 2048),
	float2(0.0,	-2.0 / 2048),
	float2(1.0 / 2048, 1.0 / 2048), 
	float2(-1.0 / 2048, -1.0 / 2048),
	float2(-1.0 / 2048, 1.0 / 2048),
	float2(1.0 / 2048, -1.0 / 2048)
};

Texture2D t_depth: register(t1);
SamplerState s_depth: register(s1);

PixelShaderOutput main(PixelShaderInput input)
{
	PixelShaderOutput output;
	
	float shadow_strength = 0.0;
	float diff = (input.depth.z - t_depth.Sample(s_depth, input.depth.xy).r) * 50.0;
	for(int i = 0; i < LOOP; i++) {
		float depth = t_depth.Sample(s_depth, input.depth.xy + offsets[i] * max(0.0, diff)).r;
		shadow_strength += (input.depth.z - depth > 0.0002) ? 1.0 : 0.0;
	}
	shadow_strength = (1.0 - shadow_strength / LOOP) * SHADE + AMBIENT;
	
    output.color = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
	output.color.rgb *= min(shadow_strength, input.brightness);
	
    return output;
}
