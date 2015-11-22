#include "foo/foo.h"
#include "foo/waldo/waldo.h"
#include <iostream>

void do_foo(std::string const& in_)
{
    do_waldo(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}