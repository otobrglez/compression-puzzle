def compress(str)
  str.chars.slice_when(&:!=).map { _1.tally.invert.to_a }.join
end

raise 'Fail' unless compress('AAABBAAC') == '3A2B2A1C'
