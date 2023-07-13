#version 450 core

layout (location = 0) in vec4 ourColor;

layout (location = 0) out vec4 fragColor;

void main()
{
	fragColor = ourColor;
}