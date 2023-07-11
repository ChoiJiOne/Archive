#pragma once

#include <string>
#include <windows.h>


class StringHelper
{
public:
	static inline std::wstring Convert(const std::string& utf8String)
	{
		static wchar_t buffer[512];
		MultiByteToWideChar(CP_UTF8, 0, utf8String.c_str(), static_cast<int32_t>(utf8String.size()), buffer, 512);
		return std::wstring(buffer);
	}

	static inline std::string Convert(const std::wstring& utf16String)
	{
		static char buffer[512];
		WideCharToMultiByte(CP_ACP, 0, &utf16String[0], static_cast<int32_t>(utf16String.size()), buffer, 512, nullptr, nullptr);
		return std::string(buffer);
	}
};