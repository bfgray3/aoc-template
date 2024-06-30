.PHONY: all clean setup solve test

CXXFLAGS = -Wall -Wextra -Wshadow -Wconversion -Werror -Wpedantic -std=c++23 -O3
CPPFLAGS = -I./include
CXX = g++
SUBDIR = $(dir $(path))

all: clean setup test

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
	@docker run -v ${PWD}:/usr/src/aoc:ro --rm aoc:latest ./solve.sh $(SUBDIR)

starter: starter.go
	@go build starter.go

test:
	@docker run -v ${PWD}:/usr/src/aoc:ro --rm aoc:latest ./test.sh $(SUBDIR)
