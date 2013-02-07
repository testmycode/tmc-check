
CHECK_CFLAGS=$(shell pkg-config --cflags check)
CHECK_LDFLAGS=$(shell pkg-config --libs check)
SRC_FILES=tmc-check-example.c tmc-check.c

all: tmc-check-example

tmc-check-example: $(SRC_FILES)
	gcc $(CHECK_CFLAGS) -Wall -o$@ $(SRC_FILES) $(CHECK_LDFLAGS)

clean:
	rm -f tmc-check-example tmc_available_points.txt tmc_test_results.xml

run-example: tmc-check-example
	# Printing available points
	./tmc-check-example --print-available-points
	# Running test. There should be one success and one failure.
	./tmc-check-example
