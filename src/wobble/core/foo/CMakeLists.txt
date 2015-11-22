cmake_minimum_required(3.0)

add_subdirectory(waldo)

add_library(foo SHARED foo.h foo.cpp)

target_link_libraries(foo 
	waldo)