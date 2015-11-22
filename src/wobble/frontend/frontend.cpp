#include "frontend/fred/fred.h"
#include "frontend/garp/garp.h"

// OK, the tier world is not that simple...
#include "core/foo/waldo.h"

#include <string>

int do_frontend(std::string const& in_)
{
    do_fred(in_);
    do_garp(in_);
    do_waldo(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}