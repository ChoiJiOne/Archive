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

	struct CameraBufferType
	{
		DirectX::XMFLOAT3 cameraPosition;
		float padding;
	};

	struct LightBufferType
	{
		DirectX::XMFLOAT4 ambientColor;
		DirectX::XMFLOAT4 diffuseColor;
		DirectX::XMFLOAT4 specularColor;
		DirectX::XMFLOAT3 lightDirection;
		float specularPower;
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
		DirectX::XMFLOAT3 lightDirection, DirectX::XMFLOAT4 ambientColor, DirectX::XMFLOAT4 diffuseColor,
		DirectX::XMFLOAT3 cameraPosition, DirectX::XMFLOAT4 specularColor, float specularPower
	);

private:
	bool InitializeShader(ID3D11Device* device, HWND hwnd, const WCHAR* vsFilename, const WCHAR* psFilename);
	void ShutdownShader();
	void OutputShaderErrorMessage(ID3DBlob* errorMessage, HWND hwnd, const WCHAR* shaderFilename);

	bool SetShaderParameters(
		ID3D11DeviceContext* deviceContext,
		DirectX::XMMATRIX worldMatrix, DirectX::XMMATRIX viewMatrix, DirectX::XMMATRIX projectionMatrix,
		ID3D11ShaderResourceView* texture,
		DirectX::XMFLOAT3 lightDirection, DirectX::XMFLOAT4 ambientColor, DirectX::XMFLOAT4 diffuseColor,
		DirectX::XMFLOAT3 cameraPosition, DirectX::XMFLOAT4 specularColor, float specularPower
	);
	void RenderShader(ID3D11DeviceContext* deviceContext, int indexCount);

private:
	ID3D11VertexShader* m_vertexShader = nullptr;
	ID3D11PixelShader* m_pixelShader = nullptr;
	ID3D11InputLayout* m_layout = nullptr;
	ID3D11Buffer* m_matrixBuffer = nullptr;
	ID3D11Buffer* m_cameraBuffer = nullptr;
	ID3D11Buffer* m_lightBuffer = nullptr;

	ID3D11SamplerState* m_samplerState = nullptr;
};




//#pragma once
//
//#include <d3d11.h>
//#include <directxmath.h>
//
//using namespace DirectX;
//
//class LightShaderClass
//{
//private:
//	struct MatrixBufferType
//	{
//		XMMATRIX world;
//		XMMATRIX view;
//		XMMATRIX projection;
//	};
//
//	class CameraBufferType
//	{
//	public:
//		XMFLOAT3 cameraPosition;
//		float padding;
//	};
//
//	struct LightBufferType
//	{
//		XMFLOAT4 ambientColor;
//		XMFLOAT4 diffuseColor;
//		XMFLOAT3 lightDirection;
//		float specularPower;
//		XMFLOAT4 specularColor;
//	};
//public:
//	LightShaderClass();
//	LightShaderClass(const LightShaderClass&);
//	~LightShaderClass();
//
//	bool Initialize(ID3D11Device*, HWND);
//	void Shutdown();
//	bool Render(ID3D11DeviceContext*, int, XMMATRIX, XMMATRIX, XMMATRIX, ID3D11ShaderResourceView*, XMFLOAT3, XMFLOAT4, XMFLOAT4,
//		XMFLOAT3, XMFLOAT4, float);
//
//private:
//	bool InitializeShader(ID3D11Device*, HWND, const WCHAR*, const WCHAR*);
//	void ShutdownShader();
//	void OutputShaderErrorMessage(ID3D10Blob*, HWND, const WCHAR*);
//
//	bool SetShaderParameters(ID3D11DeviceContext*, XMMATRIX, XMMATRIX, XMMATRIX, ID3D11ShaderResourceView*, XMFLOAT3, XMFLOAT4, XMFLOAT4,
//		XMFLOAT3, XMFLOAT4, float);
//	void RenderShader(ID3D11DeviceContext*, int);
//
//private:
//	ID3D11VertexShader* m_vertexShader = nullptr;
//	ID3D11PixelShader* m_pixelShader = nullptr;
//	ID3D11InputLayout* m_layout = nullptr;
//	ID3D11SamplerState* m_sampleState = nullptr;
//	ID3D11Buffer* m_matrixBuffer = nullptr;
//	ID3D11Buffer* m_cameraBuffer = nullptr;
//	ID3D11Buffer* m_lightBuffer = nullptr;
//};