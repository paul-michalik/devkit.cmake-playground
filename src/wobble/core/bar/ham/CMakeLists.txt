cmake_minimum_required(VERSION 3.0)

add_subdirectory(eggs)

add_library(ham STATIC ham.h ham.cpp) 