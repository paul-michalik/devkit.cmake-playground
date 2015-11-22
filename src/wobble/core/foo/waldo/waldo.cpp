#include "waldo/waldo.h"
#include <memory>

void do_waldo(std::string const& in_)
{
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}