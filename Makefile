.PHONY: clean build test all

CXXFLAGS = -Wall -Wextra -Wshadow -Werror -Wconversion -Wpedantic -std=c++23 -O3
CPPFLAGS = -I./include
CXX = g++
SUBDIR = $(dir $(path))

$(SUBDIR)/aocmain:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $(wildcard $(SUBDIR)/*.cpp)

clean:
	go clean -cache
	find -type f -name aocmain -delete
	find -type f -name a.out -delete
	find -type d -name __pycache__ -exec rm -rf {} +

build:
	@docker build --pull . -t aoc22  # just a single-stage build

test:
	@docker run -v $(shell pwd):/aoc --rm aoc22:latest $(SUBDIR)

all: clean build test
