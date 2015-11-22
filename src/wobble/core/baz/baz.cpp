#include "baz/baz.h"
#include "bar/bar.h"
#include <memory>

void do_baz(std::string const& in_)
{
    do_bar(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}