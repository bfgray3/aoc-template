.PHONY: all clean setup solve test

CXXFLAGS = -Wall -Wconversion -Werror -Wextra -Wpedantic -Wshadow -std=c++23 -O3
CPPFLAGS = -I./include
CXX = g++
SUBDIR = $(dir $(path))

$(SUBDIR)/aocmain:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $(wildcard $(SUBDIR)/*.cpp)

clean:
	@go clean -cache
	@find -type f -name aocmain -delete
	@find -type f -name a.out -delete
	@find -type d -name __pycache__ -exec rm -rf {} +
	@rm -f starter

setup: starter
	@docker build --pull . -t aoc  # just a single-stage build

solve:
	@docker run -v ${PWD}:/usr/src/aoc --rm aoc:latest ./solve.sh $(SUBDIR)

starter: starter.go
	@go build $<

test:
	@docker run -v ${PWD}:/usr/src/aoc --rm aoc:latest ./test.sh $(SUBDIR)

all: clean setup test
