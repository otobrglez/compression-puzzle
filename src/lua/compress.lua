local function compress(s)
  local i, j = 1, 1
  local t = {}
  while i and i <= #s do
    local c = s:sub(i,i) -- grab 1st char in sequence
    i, j = s:find(c.."+",i) -- count repetitions
    if i then t[#t+1] = tostring(j-i+1)..c end -- save sequence to table
    i = j + 1
  end
  return table.concat(t)
end

assert(compress("AAABBAAC") == "3A2B2A1C")
