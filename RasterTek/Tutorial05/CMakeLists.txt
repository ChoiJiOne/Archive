# CMake 최소 버전입니다.
cmake_minimum_required(VERSION 3.27)

# 소스 코드 경로입니다.
set(TUTORIAL_SOURCE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Source")
file(GLOB_RECURSE TUTORIAL_SOURCE "${TUTORIAL_SOURCE_PATH}/*")

# 셰이더 코드 경로입니다.
set(SHADER_SOURCE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Shader")
file(GLOB_RECURSE SHADER_SOURCE "${SHADER_SOURCE_PATH}/*")

# Tutorial 프로젝트입니다.
add_executable(Tutorial05 WIN32 ${TUTORIAL_SOURCE} ${SHADER_SOURCE})

# Tutorial 프로젝트의 해더 경로를 설정합니다.
target_include_directories(Tutorial05 PUBLIC ${TUTORIAL_SOURCE_PATH} ${SHADER_SOURCE_PATH})

# 셰이더 컴파일을 비활성화 합니다.
set_source_files_properties(${SHADER_SOURCE} PROPERTIES VS_TOOL_OVERRIDE "None")

# Tutorial 프로젝트에서 사용할 라이브러리를 추가합니다.
target_link_libraries(Tutorial05 PUBLIC d3d11.lib dxgi.lib dxguid.lib d3dcompiler.lib winmm.lib)

set(COMMAND_ARGUMENTS "${CMAKE_CURRENT_SOURCE_DIR}")
set_property(TARGET Tutorial05 PROPERTY VS_DEBUGGER_COMMAND_ARGUMENTS ${COMMAND_ARGUMENTS})

source_group(Source FILES ${TUTORIAL_SOURCE})
source_group(Shader FILES ${SHADER_SOURCE})

