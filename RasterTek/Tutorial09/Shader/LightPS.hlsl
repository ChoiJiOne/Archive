cbuffer LightBuffer : register(b0)
{
    float4 ambientColor;
    float4 diffuseColor;
    float3 lightDirection;
    float padding;
}

struct PS_INPUT
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normal : NORMAL;
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
    output.color = ambientColor;
	
    float4 textureColor = shaderTexture.Sample(samplerType, input.uv);
    float3 lightDir = -lightDirection;
    float lightIntensity = saturate(dot(input.normal, lightDir));
    
    if(lightIntensity > 0.0f)
    {
        output.color += saturate(diffuseColor * lightIntensity);
    }
    
    output.color = saturate(output.color);
    output.color *= textureColor;
    
	return output;
}