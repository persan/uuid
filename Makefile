PREFIX?=$(dir $(shell dirname `which gnatls`))
GPRBUILDFLAGS=-p
PROJECT=uuid
all:
	echo ${DESTDIR}${PREFIX}
	gprinstall -d -a -f -p -P ${PROJECT} --build-var=BUILD #-XBUILD=static
	gprinstall -d -a -f -p -P ${PROJECT} --build-var=BUILD #-XBUILD=relocatable
#	${MAKE} compile
#	${MAKE} test
compile:
	gprbuild ${GPRBUILDFLAGS}  -P ${PROJECT} -XBUILD=static
	gprbuild ${GPRBUILDFLAGS}  -P ${PROJECT} -XBUILD=relocatable

test:
	${MAKE} clean
	gprbuild ${GPRBUILDFLAGS} -p -P ${PROJECT}-tests -XBUILD=static
	./bin/uuid-tests-main
	${MAKE} clean
	gprbuild ${GPRBUILDFLAGS} -p -P ${PROJECT}-tests -XBUILD=relocatable
	./bin/uuid-tests-main

install:

clean:
	rm -rf bin .obj lib .gen
generate:
	mkdir .gen
	cd .gen;echo "#include <uuid/uuid.h>">gen.cpp
	cd .gen;g++ -c -fdump-ada-spec gen.cpp
