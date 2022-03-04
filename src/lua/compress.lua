local function compress(s)
  local i, j = 1, 1
  local t = {}
  while i and i <= #s do
    local c = s:sub(i,i)
    i, j = s.find(s,c.."+",i)
    if i then t[#t+1] = tostring(j-i+1)..c end
    i = j + 1
  end
  return table.concat(t)
end

assert(compress("AAABBAAC") == "3A2B2A1C")
