#version 450 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec4 aColor;
layout (location = 2) in vec2 aTexCoord;

layout (location = 0) out vec4 ourColor;
layout (location = 1) out vec2 texCoord;

void main()
{
	gl_Position = vec4(aPos, 1.0f);
	ourColor = aColor;
	texCoord = aTexCoord;
}