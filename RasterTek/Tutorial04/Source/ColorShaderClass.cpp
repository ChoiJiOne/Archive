#include "ColorShaderClass.h"

#include <d3dcompiler.h>
#include <string>
#include <vector>

ColorShaderClass::ColorShaderClass()
{
}

ColorShaderClass::ColorShaderClass(const ColorShaderClass& other)
{
}

ColorShaderClass::~ColorShaderClass()
{
}

bool ColorShaderClass::Initialize(ID3D11Device* device, HWND hwnd)
{
	std::wstring shaderPath = __wargv[1];
	std::wstring vsPath = shaderPath + L"/Shader/ColorVS.hlsl";
	std::wstring psPath = shaderPath + L"/Shader/ColorPS.hlsl";
	
	return InitializeShader(device, hwnd, vsPath.c_str(), psPath.c_str());
}

void ColorShaderClass::Shutdown()
{
	ShutdownShader();
}

bool ColorShaderClass::Render(
	ID3D11DeviceContext* deviceContext, int indexCount, 
	DirectX::XMMATRIX worldMatrix, DirectX::XMMATRIX viewMatrix, DirectX::XMMATRIX projectionMatrix
)
{
	if (!SetShaderParameters(deviceContext, worldMatrix, viewMatrix, projectionMatrix))
	{
		return false;
	}

	RenderShader(deviceContext, indexCount);
	return true;
}

bool ColorShaderClass::InitializeShader(ID3D11Device* device, HWND hwnd, const WCHAR* vsFilename, const WCHAR* psFilename)
{
	ID3DBlob* errorMessage = nullptr;

	ID3DBlob* vertexShaderBuffer = nullptr;
	if (FAILED(D3DCompileFromFile(vsFilename, nullptr, nullptr, "main", "vs_5_0", D3DCOMPILE_ENABLE_STRICTNESS, 0, &vertexShaderBuffer, &errorMessage)))
	{
		if (errorMessage)
		{
			OutputShaderErrorMessage(errorMessage, hwnd, vsFilename);
		}
		else
		{
			MessageBoxW(hwnd, vsFilename, L"Missing Shader File", MB_OK);
		}

		return false;
	}

	ID3DBlob* pixelShaderBuffer = nullptr;
	if (FAILED(D3DCompileFromFile(psFilename, nullptr, nullptr, "main", "ps_5_0", D3DCOMPILE_ENABLE_STRICTNESS, 0, &pixelShaderBuffer, &errorMessage)))
	{
		if (errorMessage)
		{
			OutputShaderErrorMessage(errorMessage, hwnd, psFilename);
		}
		else
		{
			MessageBoxW(hwnd, psFilename, L"Missing Shader File", MB_OK);
		}

		return false;
	}

	if (FAILED(device->CreateVertexShader(vertexShaderBuffer->GetBufferPointer(), vertexShaderBuffer->GetBufferSize(), NULL, &m_vertexShader)))
	{
		return false;
	}

	if (FAILED(device->CreatePixelShader(pixelShaderBuffer->GetBufferPointer(), pixelShaderBuffer->GetBufferSize(), NULL, &m_pixelShader)))
	{
		return false;
	}

	std::vector<D3D11_INPUT_ELEMENT_DESC> polygonLayout = {
		{ "POSITION", 0,    DXGI_FORMAT_R32G32B32_FLOAT, 0, D3D11_APPEND_ALIGNED_ELEMENT, D3D11_INPUT_PER_VERTEX_DATA, 0 },
		{    "COLOR", 0, DXGI_FORMAT_R32G32B32A32_FLOAT, 0, D3D11_APPEND_ALIGNED_ELEMENT, D3D11_INPUT_PER_VERTEX_DATA, 0 },
	};

	if (FAILED(device->CreateInputLayout(
		&polygonLayout[0], 
		static_cast<UINT>(polygonLayout.size()),
		vertexShaderBuffer->GetBufferPointer(), 
		vertexShaderBuffer->GetBufferSize(), &m_layout
	)))
	{
		return false;
	}

	vertexShaderBuffer->Release();
	vertexShaderBuffer = nullptr;

	pixelShaderBuffer->Release();
	pixelShaderBuffer = nullptr;

	D3D11_BUFFER_DESC matrixBufferDesc;
	matrixBufferDesc.Usage = D3D11_USAGE_DYNAMIC;
	matrixBufferDesc.ByteWidth = sizeof(MatrixBufferType);
	matrixBufferDesc.BindFlags = D3D11_BIND_CONSTANT_BUFFER;
	matrixBufferDesc.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
	matrixBufferDesc.MiscFlags = 0;
	matrixBufferDesc.StructureByteStride = 0;

	if (FAILED(device->CreateBuffer(&matrixBufferDesc, NULL, &m_matrixBuffer)))
	{
		return false;
	}

	return true;
}

void ColorShaderClass::ShutdownShader()
{
	if (m_matrixBuffer)
	{
		m_matrixBuffer->Release();
		m_matrixBuffer = nullptr;
	}

	if (m_layout)
	{
		m_layout->Release();
		m_layout = nullptr;
	}

	if (m_pixelShader)
	{
		m_pixelShader->Release();
		m_pixelShader = nullptr;
	}

	if (m_vertexShader)
	{
		m_vertexShader->Release();
		m_vertexShader = nullptr;
	}
}

void ColorShaderClass::OutputShaderErrorMessage(ID3DBlob* errorMessage, HWND hwnd, const WCHAR* shaderFilename)
{
	OutputDebugStringW(reinterpret_cast<const wchar_t*>(errorMessage->GetBufferPointer()));

	errorMessage->Release();
	errorMessage = nullptr;

	MessageBoxW(hwnd, L"Error compiling shader.", shaderFilename, MB_OK);
}

bool ColorShaderClass::SetShaderParameters(ID3D11DeviceContext* deviceContext, DirectX::XMMATRIX worldMatrix, DirectX::XMMATRIX viewMatrix, DirectX::XMMATRIX projectionMatrix)
{
	worldMatrix = DirectX::XMMatrixTranspose(worldMatrix);
	viewMatrix = DirectX::XMMatrixTranspose(viewMatrix);
	projectionMatrix = DirectX::XMMatrixTranspose(projectionMatrix);

	D3D11_MAPPED_SUBRESOURCE mappedResource;
	if (FAILED(deviceContext->Map(m_matrixBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, &mappedResource)))
	{
		return false;
	}

	MatrixBufferType* bufferPtr = reinterpret_cast<MatrixBufferType*>(mappedResource.pData);

	bufferPtr->world = worldMatrix;
	bufferPtr->view = viewMatrix;
	bufferPtr->projection = projectionMatrix;

	deviceContext->Unmap(m_matrixBuffer, 0);

	unsigned bufferNumber = 0;
	deviceContext->VSSetConstantBuffers(bufferNumber, 1, &m_matrixBuffer);

	return true;
}

void ColorShaderClass::RenderShader(ID3D11DeviceContext* deviceContext, int indexCount)
{
	deviceContext->IASetInputLayout(m_layout);

	deviceContext->VSSetShader(m_vertexShader, nullptr, 0);
	deviceContext->PSSetShader(m_pixelShader, nullptr, 0);

	deviceContext->DrawIndexed(indexCount, 0, 0);
}
