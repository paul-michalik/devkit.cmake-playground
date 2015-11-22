#include "eggs/eggs.h"
#include "ham/ham.h"
#include <iostream>

void do_ham(std::string const& in_)
{
    do_eggs(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}