#include "TextureClass.h"
#include "DDSTextureLoader.h"

TextureClass::TextureClass()
{
}

TextureClass::TextureClass(const TextureClass& other)
{
}

TextureClass::~TextureClass()
{
}

bool TextureClass::Initialize(ID3D11Device* device, const WCHAR* filename)
{
	if (FAILED(DirectX::CreateDDSTextureFromFile(device, filename, nullptr, &m_texture)))
	{
		return false;
	}

	return true;
}

void TextureClass::Shutdown()
{
	if (m_texture)
	{
		m_texture->Release();
		m_texture = nullptr;
	}
}

ID3D11ShaderResourceView* TextureClass::GetTexture()
{
	return m_texture;
}