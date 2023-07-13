-- 02.GettingStarted 작업 영역입니다.
workspace "02.GettingStarted"
    -- 빌드 구성 요소입니다.
    configurations { 
        "Debug", 
        "Release", 
    }

    -- 실행 플랫폼입니다.
    platforms { "Win64", }

    -- 솔루션 경로를 설정합니다.
    location "%{wks.name}"

    -- 외부 라이브러리 경로를 설정합니다.
    thirdparty="%{wks.location}/../../ThirdParty"

    -- 03.HelloWindow.01 프로젝트입니다.
    project "03.HelloWindow.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../03.HelloWindow.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../03.HelloWindow.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 03.HelloWindow.02 프로젝트입니다.
    project "03.HelloWindow.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../03.HelloWindow.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../03.HelloWindow.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 04.HelloTriangle.01 프로젝트입니다.
    project "04.HelloTriangle.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../04.HelloTriangle.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../04.HelloTriangle.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 04.HelloTriangle.02 프로젝트입니다.
    project "04.HelloTriangle.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../04.HelloTriangle.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../04.HelloTriangle.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 04.HelloTriangle.03 프로젝트입니다.
    project "04.HelloTriangle.03"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../04.HelloTriangle.03",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../04.HelloTriangle.03/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 05.Shaders.01 프로젝트입니다.
    project "05.Shaders.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../05.Shaders.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../05.Shaders.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 05.Shaders.02 프로젝트입니다.
    project "05.Shaders.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../05.Shaders.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../05.Shaders.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 05.Shaders.03 프로젝트입니다.
    project "05.Shaders.03"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../05.Shaders.03",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../05.Shaders.03/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 05.Shaders.04 프로젝트입니다.
    project "05.Shaders.04"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../05.Shaders.04",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../05.Shaders.04/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 06.Textures.01 프로젝트입니다.
    project "06.Textures.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../06.Textures.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../06.Textures.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 06.Textures.02 프로젝트입니다.
    project "06.Textures.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../06.Textures.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../06.Textures.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 06.Textures.03 프로젝트입니다.
    project "06.Textures.03"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../06.Textures.03",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../06.Textures.03/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 07.Transformations.01 프로젝트입니다.
    project "07.Transformations.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../07.Transformations.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../07.Transformations.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 07.Transformations.02 프로젝트입니다.
    project "07.Transformations.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../07.Transformations.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../07.Transformations.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 08.CoordinateSystems.01 프로젝트입니다.
    project "08.CoordinateSystems.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../08.CoordinateSystems.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../08.CoordinateSystems.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 08.CoordinateSystems.02 프로젝트입니다.
    project "08.CoordinateSystems.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../08.CoordinateSystems.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../08.CoordinateSystems.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 08.CoordinateSystems.03 프로젝트입니다.
    project "08.CoordinateSystems.03"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../08.CoordinateSystems.03",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../08.CoordinateSystems.03/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 08.CoordinateSystems.04 프로젝트입니다.
    project "08.CoordinateSystems.04"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../08.CoordinateSystems.04",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../08.CoordinateSystems.04/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 09.Camera.01 프로젝트입니다.
    project "09.Camera.01"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../09.Camera.01",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../09.Camera.01/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 09.Camera.02 프로젝트입니다.
    project "09.Camera.02"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../09.Camera.02",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../09.Camera.02/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 09.Camera.03 프로젝트입니다.
    project "09.Camera.03"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../09.Camera.03",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../09.Camera.03/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }


    -- 09.Camera.04 프로젝트입니다.
    project "09.Camera.04"
        -- 프로젝트의 종류를 설정합니다.
        kind "ConsoleApp"

        -- 프로그래밍 언어를 설정합니다.
        language "C++"

        -- C++ 표준을 성정합니다.
        cppdialect "C++17"

        -- 명령행 인수를 설정합니다.
        debugargs {
            "%{wks.location}..\\..\\02.GettingStarted\\",
            "%{wks.location}..\\..\\Resource\\",
        }

        -- include 경로를 설정합니다.
        includedirs {
            "%{wks.location}/../09.Camera.04",
            "%{thirdparty}/Include",
        }
        
        -- file 경로를 설정합니다.
        files {
            "%{wks.location}/../09.Camera.04/*",

            "%{thirdparty}/Include/assimp/*",
            "%{thirdparty}/Include/assimp/Compiler/*",
            "%{thirdparty}/Include/assimp/port/*",
            "%{thirdparty}/Include/assimp/port/AndroidJNI/*",

            "%{thirdparty}/Include/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/*",
            "%{thirdparty}/Include/freetype/freetype/config/*",
            "%{thirdparty}/Include/freetype/freetype/internal/*",
            "%{thirdparty}/Include/freetype/freetype/internal/services/*",

            "%{thirdparty}/Include/glad/*",

            "%{thirdparty}/Include/glfw/*",

            "%{thirdparty}/Include/glm/*",
            "%{thirdparty}/Include/glm/detail/*",
            "%{thirdparty}/Include/glm/ext/*",
            "%{thirdparty}/Include/glm/gtc/*",
            "%{thirdparty}/Include/glm/gtx/*",
            "%{thirdparty}/Include/glm/simd/*",
            
            "%{thirdparty}/Include/stb/*",
        }

        -- Debug 빌드 구성 설정을 수행합니다.
        filter "configurations:Debug"
            defines { "DEBUG" }
            runtime  "Debug"
            optimize "Off"
            symbols "On"
            debugdir "%{thirdparty}/Debug"

            links {
                "%{thirdparty}/Debug/assimp-vc142-mtd.lib",
                "%{thirdparty}/Debug/freetyped.lib",
                "%{thirdparty}/Debug/glfw3.lib",
            }
        
        -- Release 빌드 구성 설정을 수행합니다.
        filter "configurations:Release"
            defines { "RELEASE" }
            runtime "Release"
            optimize "On"
            symbols "On"
            debugdir "%{thirdparty}/Release"

            links {
                "%{thirdparty}/Release/assimp-vc142-mt.lib",
                "%{thirdparty}/Release/freetype.lib",
                "%{thirdparty}/Release/glfw3.lib",
            }