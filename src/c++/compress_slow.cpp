#include <cassert>
#include <chrono>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

std::string compress(const std::string& input) {
  auto f = [](const std::string& acc, const char& current_char) {
    std::string res;
    if (acc.empty() || current_char != acc.back()) {
      res = acc + "1" + current_char;
    } else {
      const auto new_count = static_cast<char>(
          (static_cast<int>(acc.at(acc.size() - 2) - '0') + 1) + '0');
      res = acc.substr(0, acc.size() - 2) + new_count + acc.back();
    }
    return res;
  };

  std::string output;
  return std::accumulate(input.begin(), input.end(), output, f);
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
  std::cout << "compress_slow mean time: " << mean << "ms" << std::endl;

  return 0;
}
