# ruby 2.6.8

def compress(str)
    str.chars.chunk{ |c| c }.map{ |c,a| "#{a.size}#{c}" }.join()
end

fail if compress("AAABBAAC") != "3A2B2A1C" 

# If you want to benchmark it, uncomment this
# require 'benchmark'
# Benchmark.bm do |x|
#     x.report { 
#         10000.times do |x|
#             fail if compress("AAABBAAC") != "3A2B2A1C" 
#         end
#     }
# end
