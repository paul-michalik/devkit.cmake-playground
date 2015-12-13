cmake_minimum_required(VERSION 3.0)

add_library(garp SHARED garp.h garp.cpp)

target_link_libraries(garp
    bar
    baz
    foo)
    	