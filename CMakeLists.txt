# CMake 최소 버전입니다.
cmake_minimum_required(VERSION 3.27)

# RasterTek 솔루션입니다.
project(RasterTek LANGUAGES CXX)

# C++17 표준을 설정합니다.
set(CMAKE_CXX_STANDARD 17)

# C++ 표준을 필수적으로 사용함을 명시합니다.
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Tutorial 프로젝트들을 추가합니다.
add_subdirectory(Tutorial02)
