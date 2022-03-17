#!/usr/bin/env crystal

require "./compress_kbc_0"
require "./compress_lexer"
require "benchmark"

Benchmark.ips do |x|
  x.report("compress_kbc_0") do
    compress("AAABBAAC")
  end
  x.report("compress_lexer") do
    CompressionLexer.new("AAABBAAC").to_compressed_string
  end
end
