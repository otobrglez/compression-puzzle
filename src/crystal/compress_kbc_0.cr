def compress(str)
  str
    .chars
    .chunk_while { |c1, c2| c1 == c2 }
    .map { |char| "#{char.size}#{char.first}" }
    .join
end

if compress("AAABBAAC") == "3A2B2A1C"
  puts "Successfully compressed."
else
  raise "Did not properly compress."
end
