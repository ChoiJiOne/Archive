#version 450 core

layout (location = 0) in vec2 texCoord;

layout (location = 0) out vec4 fragColor;

uniform sampler2D texture0;
uniform sampler2D texture1;

void main()
{
	fragColor = mix(texture(texture0, texCoord), texture(texture1, texCoord), 0.2f);
}