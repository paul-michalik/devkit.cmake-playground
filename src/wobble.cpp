#include "frontend/frontend.h"

// OK, the layer world is not that simple...
#include "frontend/garp/garp.h"

#include <string>

int main(int argc_, char** argv_)
{
    do_frontend("holla from wobble");
    do_garp("holla from wobble layer breaking...");
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}