def compress(str)
  str.chars.chunk_while(&:==).map { "#{_1.size}#{_1.first}" }.join
end

raise 'Fail' unless compress('AAABBAAC') == '3A2B2A1C'
