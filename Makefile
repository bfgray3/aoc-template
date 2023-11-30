.PHONY: clean setup solve test all

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
	@rm -f starter

setup: starter
	@docker build --pull . -t aoc  # just a single-stage build

solve:
	@docker run -v $(shell pwd):/aoc --rm aoc22:latest ./solve.sh $(SUBDIR)

starter:
	@go build starter.go

test:
	@docker run -v $(shell pwd):/aoc --rm aoc22:latest ./test.sh $(SUBDIR)

all: clean setup test
