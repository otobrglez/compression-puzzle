local function compress(s)
  return s:gsub(".","\0%0%0")
          :gsub("(.)%z%1","%1")
          :gsub("%z.(%Z+)",function(x) return #x..x:sub(1,1) end)
end

assert(compress("AAABBAAC") == "3A2B2A1C")
