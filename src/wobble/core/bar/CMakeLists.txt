cmake_minimum_required(VERSION 3.0)

add_subdirectory(ham)

add_subdirectory(spam)

add_library(bar SHARED bar.h bar.cpp)

target_link_libraries(bar 
	ham
	spam)
