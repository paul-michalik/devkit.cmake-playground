cmake_minimum_required(3.0)

project(wobble 
	VERSION 0.0.1 
	LANGUAGES C CXX Fortran)
	
add_subdirectory(core)

add_subdirectory(frontend)

add_executable(wobble wobble.cpp)