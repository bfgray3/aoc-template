.PHONY: clean setup test all

CXXFLAGS = -Wall -Wextra -Wshadow -Werror -Wconversion -Wpedantic -std=c++23 -O3
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

setup:
	@docker build --pull . -t aoc  # just a single-stage build
	@go build starter.go  # TODO: move out of .PHONY??

test:
	@docker run -v $(shell pwd):/aoc --rm aoc:latest $(SUBDIR)

all: clean setup test
