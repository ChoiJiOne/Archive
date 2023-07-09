struct PS_INPUT
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD0;
};

struct PS_OUTPUT
{
	float4 color : SV_TARGET0;
};

Texture2D shaderTexture : register(t0);
SamplerState samplerType : register(s0);

PS_OUTPUT main(PS_INPUT input)
{
	PS_OUTPUT output;
	
    output.color = shaderTexture.Sample(samplerType, input.uv);
	
	return output;
}