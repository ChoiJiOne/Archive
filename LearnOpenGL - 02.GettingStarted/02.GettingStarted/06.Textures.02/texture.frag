#version 450 core

layout (location = 0) in vec4 ourColor;
layout (location = 1) in vec2 texCoord;

layout (location = 0) out vec4 fragColor;

uniform sampler2D diffuseTexture;

void main()
{
	fragColor = texture(diffuseTexture, texCoord) * ourColor;
}