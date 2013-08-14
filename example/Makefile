TMCCHECK_CFLAGS=$(shell pkg-config --cflags tmccheck)
TMCCHECK_LDFLAGS=$(shell pkg-config --libs tmccheck)

tmc-check-example: tmc-check-example.c
	gcc $(TMCCHECK_CFLAGS) -Wall -o $@ $< $(TMCCHECK_LDFLAGS)

clean:
	rm -f tmc-check-example tmc_available_points.txt tmc_test_results.xml test_output.txt

run-example: tmc-check-example
	# Printing available points
	env LD_LIBRARY_PATH=".:$(LD_LIBRARY_PATH)" ./tmc-check-example --print-available-points
	# Running test. There should be one success and one failure.
	env LD_LIBRARY_PATH=".:$(LD_LIBRARY_PATH)" ./tmc-check-example
	# Converting results to a form understandable by tmc-server
	../tmc-check-convert-results > test_output.txt

