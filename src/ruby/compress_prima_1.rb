# ruby 2.6.8

def compress(str)
    chars = str.chars
    result = []

    memo = nil
    tracking_char = chars[0]

    chars.each do |char|
        if tracking_char != char
            result << memo
            memo = nil
            tracking_char = char
        end

        if memo.nil?
            memo = [0, tracking_char]
        end

        memo[0] += 1
    end

    result << memo
    result.join()
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
