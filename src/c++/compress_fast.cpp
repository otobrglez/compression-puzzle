#include <cassert>
#include <chrono>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

std::string compress(const std::string& input) {
  std::string output;
  // In the worst case, the "compressed" string is twice
  // as large as the input, e.g. when input is 'ABCDE'.
  output.reserve(2 * input.size());

  int streak = 1;
  char previous_char = input.at(0);

  for (size_t i = 1; i < input.size(); ++i) {
    const char& current_char = input.at(i);
    if (current_char != previous_char) {
      output.push_back(streak + '0');
      output.push_back(previous_char);
      streak = 1;
      previous_char = current_char;
    } else {
      streak++;
    }
  }

  output.push_back(streak + '0');
  output.push_back(previous_char);
  return output;
}

int main() {
  // Tests
  assert(compress("AAABBAAC") == "3A2B2A1C");
  assert(compress("ABBAAC") == "1A2B2A1C");
  assert(compress("AAABBAACC") == "3A2B2A2C");
  assert(compress("ABCDE") == "1A1B1C1D1E");

  // Benchmark
  std::string input;
  input.reserve(20000);
  for (size_t i = 0; i < 5000; ++i) {
    input.insert(input.size(), "AABB");
  }

  std::vector<double> times;
  times.reserve(5000);
  for (size_t i = 0; i < 5000; ++i) {
    const auto t1 = std::chrono::high_resolution_clock::now();
    compress(input);
    const auto t2 = std::chrono::high_resolution_clock::now();
    const std::chrono::duration<double, std::milli> ms = t2 - t1;
    times.push_back(ms.count());
  }

  const auto mean = std::reduce(times.begin(), times.end()) / times.size();
  std::cout << "compress_fast mean time: " << mean << "ms" << std::endl;

  return 0;
}
