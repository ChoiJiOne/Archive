#pragma once

#include <directxmath.h>


class LightClass
{
public:
	LightClass();
	LightClass(const LightClass& other);
	virtual ~LightClass();

	void SetAmbientColor(float red, float green, float blue, float alpha);
	void SetDiffuseColor(float red, float green, float blue, float alpha);
	void SetSpecularColor(float red, float green, float blue, float alpha);
	void SetDirection(float x, float y, float z);
	void SetSpecularPower(float power);

	DirectX::XMFLOAT4 GetAmbientColor();
	DirectX::XMFLOAT4 GetDiffuseColor();
	DirectX::XMFLOAT4 GetSpecularColor();
	DirectX::XMFLOAT3 GetDirection();
	float GetSpecularPower();

private:
	DirectX::XMFLOAT4 m_ambientColor;
	DirectX::XMFLOAT4 m_diffuseColor;
	DirectX::XMFLOAT4 m_specularColor;
	DirectX::XMFLOAT3 m_direction;
	float m_specularPower;
};