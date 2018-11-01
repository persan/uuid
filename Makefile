#!/usr/bin/make gps
PREFIX?=$(dir $(shell dirname `which gnatls`))
GPRBUILDFLAGS=-p
PROJECT=uuid
DESTDIR=_
all:
	${MAKE} clean
	${MAKE} compile
	${MAKE} test
compile:
	gprbuild ${GPRBUILDFLAGS}  -P ${PROJECT} -XBUILD=static
	gprbuild ${GPRBUILDFLAGS}  -P ${PROJECT} -XBUILD=relocatable

test:
	${MAKE} clean
	gprbuild ${GPRBUILDFLAGS} -P ${PROJECT}-tests -XBUILD=static
	./bin/uuid-tests-main
	rm bin/*
	gprbuild ${GPRBUILDFLAGS} -P ${PROJECT}-tests -XBUILD=relocatable
	./bin/uuid-tests-main

install:
	gprinstall -P${PROJECT} -p -f -XBUILD=static --prefix=${DESTDIR}${PREFIX}
	gprinstall -P${PROJECT} -p -f -XBUILD=relocatable --prefix=${DESTDIR}${PREFIX}
clean:
	rm -rf bin .obj lib .gen _
generate:
	mkdir .gen
	cd .gen;echo "#include <uuid/uuid.h>">gen.cpp
	cd .gen;g++ -c -fdump-ada-spec gen.cpp
clean:
	git clean -xdf
edit:
	gps -P tests/${PROJECT}-tests&
