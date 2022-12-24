TESTSOURCE=test.cpp
DRIVER=ArrayBagDriver.cpp
# Declare variables for compiler and flags
# Use latest gcc on Ubuntu 18.04
# -std=gnu++14  2014 ISO C++ standard plus amendments (plus GNU extensions)
# -ggdb produce debug info
# -O0 disable optimization
CC=g++-11 -std=gnu++14 -ggdb -O0
# Clang for sanitizers
# -O1 no inlining
CLANG=clang++ -O1 -std=gnu++14 -g
# -Wall enables all the warnings about constructions
# -Werror convert all warnings into errors
# -Wextra enables some extra warning flags that are not enabled by -Wall
# -Wpedantic warnings demanded by strict ISO C++; reject all programs that use forbidden extensions
# -Wshadow warn whenever a local variable or type declaration shadows another variable, parameter, type, class member (in C++), or whenever a built-in function is shadowed
CWARN=-Wall -Werror -Wextra -Wpedantic -Wshadow

# Optional: Add "all" Target At The Top
.PHONY: all
all:

test: $(TESTSOURCE)
	$(CC) $(CWARN) -o test $(TESTSOURCE)

.PHONY: clean
clean:
	rm -f a.out test html/

.PHONY: cppcheck
cppcheck:
	cppcheck --enable=all --inconclusive --std=posix $(DRIVER)

doc:
	doxygen

msan:
	$(CLANG) -fsanitize=memory -fno-omit-frame-pointer -fsanitize-memory-track-origins $(DRIVER) && ./a.out

asan:
	$(CLANG) -fsanitize=address,undefined $(DRIVER) && ./a.out

.PHONY: valgrind
valgrind:
	valgrind --leak-check=full \
	         --show-leak-kinds=all \
	         --track-origins=yes \
	         --verbose \
		 --log-file=valgrind-out.txt \
		 --error-exitcode=100 \
	         ./a.out

build:
	$(CC) $(CWARN) $(DRIVER)

.PHONY: debug
debug:
	gdb a.out

