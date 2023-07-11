#pragma once

#include <d3d11.h>

class TextureClass
{
public:
	TextureClass();
	TextureClass(const TextureClass& other);
	virtual ~TextureClass();

	bool Initialize(ID3D11Device* device, const WCHAR* filename);
	void Shutdown();

	ID3D11ShaderResourceView* GetTexture();
	
private:
	ID3D11ShaderResourceView* m_texture = nullptr;
};