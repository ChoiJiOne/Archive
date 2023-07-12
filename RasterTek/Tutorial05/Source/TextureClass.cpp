#include "TextureClass.h"

#include <stdio.h>

TextureClass::TextureClass()
{
}


TextureClass::TextureClass(const TextureClass& other)
{
}


TextureClass::~TextureClass()
{
}


bool TextureClass::Initialize(ID3D11Device* device, ID3D11DeviceContext* deviceContext, const char* filename)
{
	int width = 0;
	int height = 0;

	if (!LoadTarga(filename, height, width))
	{
		return false;
	}

	D3D11_TEXTURE2D_DESC textureDesc;
	textureDesc.Height = height;
	textureDesc.Width = width;
	textureDesc.MipLevels = 0;
	textureDesc.ArraySize = 1;
	textureDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
	textureDesc.SampleDesc.Count = 1;
	textureDesc.SampleDesc.Quality = 0;
	textureDesc.Usage = D3D11_USAGE_DEFAULT;
	textureDesc.BindFlags = D3D11_BIND_SHADER_RESOURCE | D3D11_BIND_RENDER_TARGET;
	textureDesc.CPUAccessFlags = 0;
	textureDesc.MiscFlags = D3D11_RESOURCE_MISC_GENERATE_MIPS;

	if (FAILED(device->CreateTexture2D(&textureDesc, nullptr, &m_texture)))
	{
		return false;
	}

	UINT rowPitch = (width * 4) * sizeof(unsigned char);
	deviceContext->UpdateSubresource(m_texture, 0, nullptr, m_targaData, rowPitch, 0);

	D3D11_SHADER_RESOURCE_VIEW_DESC srvDesc;
	srvDesc.Format = textureDesc.Format;
	srvDesc.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
	srvDesc.Texture2D.MostDetailedMip = 0;
	srvDesc.Texture2D.MipLevels = -1;

	if (FAILED(device->CreateShaderResourceView(m_texture, &srvDesc, &m_textureView)))
	{
		return false;
	}

	deviceContext->GenerateMips(m_textureView);

	delete[] m_targaData;
	m_targaData = nullptr;

	return true;
}


void TextureClass::Shutdown()
{
	if (m_textureView)
	{
		m_textureView->Release();
		m_textureView = nullptr;
	}

	if (m_texture)
	{
		m_texture->Release();
		m_texture = nullptr;
	}

	if (m_targaData)
	{
		delete[] m_targaData;
		m_targaData = nullptr;
	}
}


ID3D11ShaderResourceView* TextureClass::GetTexture()
{
	return m_textureView;
}


bool TextureClass::LoadTarga(const char* filename, int& height, int& width)
{
	FILE* filePtr;
	if (fopen_s(&filePtr, filename, "rb") != 0)
	{
		return false;
	}

	TargaHeader targaFileHeader;
	unsigned int count = static_cast<unsigned int>(fread(&targaFileHeader, sizeof(TargaHeader), 1, filePtr));
	if (count != 1)
	{
		return false;
	}

	height = static_cast<int>(targaFileHeader.height);
	width = static_cast<int>(targaFileHeader.width);
	int bpp = static_cast<int>(targaFileHeader.bpp);

	if (bpp != 32)
	{
		return false;
	}

	int imageSize = width * height * 4;
	unsigned char* targaImage = new unsigned char[imageSize];
	if (!targaImage)
	{
		return false;
	}

	count = (unsigned int)fread(targaImage, 1, imageSize, filePtr);
	if (count != imageSize)
	{
		return false;
	}

	if (fclose(filePtr) != 0)
	{
		return false;
	}

	m_targaData = new unsigned char[imageSize];
	if (!m_targaData)
	{
		return false;
	}

	int index = 0;
	int k = (width * height * 4) - (width * 4);

	for (int j = 0; j < height; j++)
	{
		for (int i = 0; i < width; i++)
		{
			m_targaData[index + 0] = targaImage[k + 2];
			m_targaData[index + 1] = targaImage[k + 1];
			m_targaData[index + 2] = targaImage[k + 0]; 
			m_targaData[index + 3] = targaImage[k + 3];

			k += 4;
			index += 4;
		}

		k -= (width * 8);
	}

	delete[] targaImage;
	targaImage = nullptr;

	return true;
}