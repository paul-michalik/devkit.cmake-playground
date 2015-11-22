#include "bar/bar.h"
#include "bar/ham/ham.h"
#include "bar/ham/eggs/eggs.h"
#include "bar/spam/spam.h"
#include <memory>

void do_bar(std::string const& in_)
{
    do_ham(in_);
    do_eggs(in_);
    do_spam(in_);
    std::cout << in_ << " from " << __FUNCTION__ << std::endl;
}