#pragma once

#include <d3d11.h>

class TextureClass
{
private:
	struct TargaHeader
	{
		unsigned char data1[12];
		unsigned short width;
		unsigned short height;
		unsigned char bpp;
		unsigned char data2;
	};

public:
	TextureClass();
	TextureClass(const TextureClass& other);
	virtual ~TextureClass();

	bool Initialize(ID3D11Device* device, ID3D11DeviceContext* deviceContext, const char* filename);
	void Shutdown();

	ID3D11ShaderResourceView* GetTexture();

private:
	bool LoadTarga(const char* filename, int& height, int& width);

private:
	unsigned char* m_targaData = nullptr;
	ID3D11Texture2D* m_texture = nullptr;
	ID3D11ShaderResourceView* m_textureView = nullptr;
};