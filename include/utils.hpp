#pragma once

#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <string>
#include <vector>

namespace utils {

template <typename T>
[[nodiscard]] std::vector<T> read_vector_from_file(const std::string &filename) {
  std::ifstream input_file_stream{filename};
  std::istream_iterator<T> start{input_file_stream}, end;
  return {start, end};
}

template <typename T>
void write_vector_to_file(const std::vector<T> &v, const std::string &filename) {
  std::ofstream output_file_stream{filename};
  std::ostream_iterator<T> output_stream_iterator{output_file_stream, "\n"};
  std::copy(std::begin(v), std::end(v), output_stream_iterator);
}

template <typename T>
[[nodiscard]] std::vector<T> read_vector_from_stdin() {
  std::istream_iterator<T> start{std::cin}, end;
  return {start, end};
}

template <typename T>
void write_vector_to_stdout(const std::vector<T> &v) {
  std::copy(std::begin(v), std::end(v), std::ostream_iterator<T>{std::cout, "\n"});
}

}  // namespace utils
