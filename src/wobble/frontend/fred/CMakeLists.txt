cmake_minimum_required(VERSION 3.0)

add_library(fred SHARED fred.h fred.cpp)
    
target_link_libraries(fred
	bar
	baz
	foo)
