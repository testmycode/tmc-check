
#include "tmc-check.h"
#include <stdio.h>

START_TEST(test_foo)
{
    fail_unless(1+1 == 2, "that's weird");
}
END_TEST

START_TEST(test_bar)
{
    fail_unless(1+1 == 123123, "asdasd");
}
END_TEST

int main(int argc, const char *argv[])
{
    // Suite *s = suite_create("test-tmc-check");
    Suite *s  = tmc_suite_create("test-tmc-check", "2.5");
    tmc_register_test(s, test_foo, "1.1 1.2");
    tmc_register_test(s, test_bar, "1.2");
    return tmc_run_tests(argc, argv, s);
}
