
PREFIX=/usr/local

CHECK_CFLAGS=$(shell pkg-config --cflags check)
CHECK_LDFLAGS=$(shell pkg-config --libs check)
SRC_FILES=tmc-check.c
HEADER_FILES=tmc-check.h
SO_FILE=libtmccheck.so
PKG_CONFIG_FILE=tmccheck.pc
CONVERTER=tmc-check-convert-results

all: rubygems libtmccheck.so

rubygems: .rubygems_installed

.rubygems_installed:
	bundle install
	touch .rubygems_installed

$(SO_FILE): tmc-check.o
	gcc -o $@ -g -O1 tmc-check.o -shared

tmc-check.o: $(SRC_FILES) $(HEADER_FILES)
	gcc -c $(CHECK_CFLAGS) -Wall -fPIC -o $@ $(SRC_FILES)


clean:
	make -C example clean
	rm -f *.o $(SO_FILE) $(PKG_CONFIG_FILE)
	rm -f .rubygems_installed

run-example:
	make -C example run-example

$(PKG_CONFIG_FILE): $(PKG_CONFIG_FILE).in
	sed 's|__PREFIX__|$(PREFIX)|' < $< > $@

install: $(SO_FILE) $(PKG_CONFIG_FILE)
	install -m 755 $(CONVERTER) $(PREFIX)/bin
	install -m 755 -d $(PREFIX)/include
	install -m 755 -d $(PREFIX)/lib
	install -m 755 -d $(PREFIX)/lib/pkgconfig
	install -m 644 $(HEADER_FILES) $(PREFIX)/include
	install -m 644 -T $(SO_FILE) $(PREFIX)/lib/$(SO_FILE).0.0.0
	install -m 644 $(PKG_CONFIG_FILE) $(PREFIX)/lib/pkgconfig
	cd $(PREFIX)/lib && { ln -s -f $(SO_FILE).0.0.0 $(SO_FILE).0; }
	cd $(PREFIX)/lib && { ln -s -f $(SO_FILE).0.0.0 $(SO_FILE); }
	if [ "`whoami`" = "root" ]; then ldconfig; fi

uninstall:
	for header in $(HEADER_FILES); do rm -f $(PREFIX)/include/$$header; done
	rm -f $(PREFIX)/bin/$(CONVERTER)
	rm -f $(PREFIX)/lib/$(SO_FILE) $(PREFIX)/lib/$(SO_FILE).*
	rm -f $(PREFIX)/lib/pkgconfig/$(PKG_CONFIG_FILE)
