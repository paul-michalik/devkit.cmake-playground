cmake_minimum_required(VERSION 3.0)

project(wobble 
	VERSION 0.0.1 
	LANGUAGES C CXX) #Add languages as required...
	
add_subdirectory(core)

add_subdirectory(frontend)

add_executable(wobble wobble.cpp)