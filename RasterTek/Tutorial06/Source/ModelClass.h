#pragma once

#include <d3d11.h>
#include <directxmath.h>

class TextureClass;

class ModelClass
{
private:
	struct VertexType
	{
		DirectX::XMFLOAT3 position;
		DirectX::XMFLOAT2 uv;
		DirectX::XMFLOAT3 normal;
	};

public:
	ModelClass();
	ModelClass(const ModelClass& other);
	virtual ~ModelClass();

	bool Initialize(ID3D11Device* device, const WCHAR* textureFilename);
	void Shutdown();
	void Render(ID3D11DeviceContext* deviceContext);

	int GetIndexCount();
	ID3D11ShaderResourceView* GetTexture();

private:
	bool InitializeBuffers(ID3D11Device* device);
	void ShutdownBuffers();
	void RenderBuffers(ID3D11DeviceContext* deviceContext);

	bool LoadTexture(ID3D11Device* device, const WCHAR* textureFilename);
	void ReleaseTexture();

private:
	ID3D11Buffer* m_vertexBuffer = nullptr;
	ID3D11Buffer* m_indexBuffer = nullptr;
	int m_vertexCount = 0;
	int m_indexCount = 0;

	TextureClass* m_Texture = nullptr;
};