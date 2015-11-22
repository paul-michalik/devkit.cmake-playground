#include "core/bar/bar.h"
#include "core/baz/baz.h"
#include "core/foo/foo.h"
#include <iostream>

void do_garp(std::string const& in_)
{
    do_bar(in_);
    do_baz(in_);
    do_foo(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}