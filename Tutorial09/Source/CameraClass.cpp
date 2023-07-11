#include "CameraClass.h"

CameraClass::CameraClass()
{
	m_position = DirectX::XMFLOAT3(0.0f, 0.0f, 0.0f);;
	m_rotation = DirectX::XMFLOAT3(0.0f, 0.0f, 0.0f);
}

CameraClass::CameraClass(const CameraClass& other)
{
}

CameraClass::~CameraClass()
{
}

void CameraClass::SetPosition(float x, float y, float z)
{
	m_position.x = x;
	m_position.y = y;
	m_position.z = z;
}

void CameraClass::SetRotation(float x, float y, float z)
{
	m_rotation.x = x;
	m_rotation.y = y;
	m_rotation.z = z;
}

DirectX::XMFLOAT3 CameraClass::GetPosition()
{
	return m_position;
}

DirectX::XMFLOAT3 CameraClass::GetRotation()
{
	return m_rotation;
}

void CameraClass::Render()
{
	DirectX::XMFLOAT3 up = DirectX::XMFLOAT3(0.0f, 1.0f, 0.0f);
	DirectX::XMFLOAT3 position = m_position;
	DirectX::XMFLOAT3 lookAt = DirectX::XMFLOAT3(0.0f, 0.0f, 1.0f);

	DirectX::XMVECTOR upVector = DirectX::XMLoadFloat3(&up);
	DirectX::XMVECTOR positionVector = DirectX::XMLoadFloat3(&position);
	DirectX::XMVECTOR lookAtVector = DirectX::XMLoadFloat3(&lookAt);

	float pitch = m_rotation.x * 0.0174532925f;
	float yaw = m_rotation.y * 0.0174532925f;
	float roll = m_rotation.z * 0.0174532925f;

	DirectX::XMMATRIX rotationMatrix = DirectX::XMMatrixRotationRollPitchYaw(pitch, yaw, roll);

	lookAtVector = DirectX::XMVector3TransformCoord(lookAtVector, rotationMatrix);
	upVector = DirectX::XMVector3TransformCoord(upVector, rotationMatrix);
	lookAtVector = DirectX::XMVectorAdd(positionVector, lookAtVector);

	m_viewMatrix = DirectX::XMMatrixLookAtLH(positionVector, lookAtVector, upVector);
}

void CameraClass::GetViewMatrix(DirectX::XMMATRIX& viewMatrix)
{
	viewMatrix = m_viewMatrix;
}