#pragma once

#include <d3d11.h>
#include <directxmath.h>

class LightShaderClass
{
private:
	struct MatrixBufferType
	{
		DirectX::XMMATRIX world;
		DirectX::XMMATRIX view;
		DirectX::XMMATRIX projection;
	};

	struct LightBufferType
	{
		DirectX::XMFLOAT4 ambientColor;
		DirectX::XMFLOAT4 diffuseColor;
		DirectX::XMFLOAT3 lightDirection;
		float padding;
	};

public:
	LightShaderClass();
	LightShaderClass(const LightShaderClass& other);
	virtual ~LightShaderClass();

	bool Initialize(ID3D11Device* device, HWND hwnd);
	void Shutdown();
	bool Render(
		ID3D11DeviceContext* deviceContext, int indexCount,
		DirectX::XMMATRIX worldMatrix, DirectX::XMMATRIX viewMatrix, DirectX::XMMATRIX projectionMatrix,
		ID3D11ShaderResourceView* texture,
		DirectX::XMFLOAT3 lightDirection, DirectX::XMFLOAT4 ambientColor, DirectX::XMFLOAT4 diffuseColor
	);

private:
	bool InitializeShader(ID3D11Device* device, HWND hwnd, const WCHAR* vsFilename, const WCHAR* psFilename);
	void ShutdownShader();
	void OutputShaderErrorMessage(ID3DBlob* errorMessage, HWND hwnd, const WCHAR* shaderFilename);

	bool SetShaderParameters(
		ID3D11DeviceContext* deviceContext,
		DirectX::XMMATRIX worldMatrix, DirectX::XMMATRIX viewMatrix, DirectX::XMMATRIX projectionMatrix,
		ID3D11ShaderResourceView* texture,
		DirectX::XMFLOAT3 lightDirection, DirectX::XMFLOAT4 ambientColor, DirectX::XMFLOAT4 diffuseColor
	);
	void RenderShader(ID3D11DeviceContext* deviceContext, int indexCount);

private:
	ID3D11VertexShader* m_vertexShader = nullptr;
	ID3D11PixelShader* m_pixelShader = nullptr;
	ID3D11InputLayout* m_layout = nullptr;
	ID3D11Buffer* m_matrixBuffer = nullptr;
	ID3D11Buffer* m_lightBuffer = nullptr;

	ID3D11SamplerState* m_samplerState = nullptr;
};