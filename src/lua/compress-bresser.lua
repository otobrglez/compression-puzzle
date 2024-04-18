local function compress(_input)
  -- If last character then just output 1{CHAR}
  if string.len(_input) == 1 then return string.format("%s%s", 1, _input) end
  -- Get First Character of String
  local char = _input:sub(1, 1)
  -- increment count (as it's always at least 1)
  local count = 1

  -- loop through until we find another character that isn't char
  for i = 2, #_input do
    local c = _input:sub(i, i)
    -- if is the same char then increment count
    if c == char then count = count + 1
      -- if not, then recurse
    else
      return string.format("%s%s", 
        string.format("%s%s", count, char), 
        compress(_input:sub(i, string.len(_input))))
    end
  end
end


assert(compress("AAABBAAC") == "3A2B2A1C", "Invalid Compression")
