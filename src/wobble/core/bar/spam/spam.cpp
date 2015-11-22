#include "spam/spam.h"
#include "eggs/eggs.h"
#include <iostream>

void do_spam(std::string const& in_)
{
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}