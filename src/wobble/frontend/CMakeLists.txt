cmake_minimum_required(VERSION 3.0)

add_subdirectory(fred)

add_subdirectory(garp)

add_library(frontend SHARED frontend.cpp)

target_link_libraries(frontend
	fred
	garp)
