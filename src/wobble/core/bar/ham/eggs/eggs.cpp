#include "eggs/eggs.h"
#include <iostream>

void eggs::crack()
{
	std::cout << typeid(*this).name() << " cracked" << std::endl;
}

void do_eggs(std::string const& in_)
{
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}