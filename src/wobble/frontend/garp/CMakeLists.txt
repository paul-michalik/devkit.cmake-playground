cmake_minimum_required(3.0)

add_library(garp SHARED garp.h garp.cpp)

target_link_libraries(garp
    bar
    baz
    foo)
    	