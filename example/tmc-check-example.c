
#include <tmc-check.h>
#include <stdio.h>

START_TEST(test_foo)
{
    fail_unless(1+1 == 2, "that's weird");
}
END_TEST

START_TEST(test_bar)
{
    char *null = NULL;
    char *str = "trololoo";
    strcpy(null, str);
}
END_TEST

int main(int argc, const char *argv[])
{
    Suite *s  = tmc_suite_create("test-tmc-check", "2.5 2.6 2.7");
    tmc_register_test(s, test_foo, "1.1 1.2");
    tmc_register_test(s, test_bar, "1.2");
    return tmc_run_tests(argc, argv, s);
}
