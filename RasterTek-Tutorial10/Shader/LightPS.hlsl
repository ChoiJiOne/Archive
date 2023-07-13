cbuffer LightBuffer : register(b0)
{
    float4 ambientColor;
    float4 diffuseColor;
    float4 specularColor;
    float3 lightDirection;
    float specularPower;
}

struct PS_INPUT
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normal : NORMAL;
    float3 viewDirection : TEXCOORD1;
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
    float4 specular = float4(0.0f, 0.0f, 0.0f, 1.0f);
    
    if (lightIntensity > 0.0f)
    {
        output.color += diffuseColor * lightIntensity;
        output.color = saturate(output.color);
        
        float3 reflection = normalize(2 * lightIntensity * input.normal - lightDir);
        specular = pow(saturate(dot(reflection, input.viewDirection)), specularPower);
    }
    
    output.color *= textureColor;
    output.color = saturate(output.color + specular);
    
    
	return output;
}