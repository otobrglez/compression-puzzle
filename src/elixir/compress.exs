import ExUnit.Assertions

compress = fn input ->
  chunk_fun = fn
    char, {"", nil} -> {:cont, {char, 1}}
    char, {char, count} -> {:cont, {char, count + 1}}
    char, {prev, count} -> {:cont, "#{count}#{prev}", {char, 1}}
  end

  after_fun = fn {char, count} ->
    {:cont, "#{count}#{char}", nil}
  end

  input
  |> String.codepoints()
  |> Enum.chunk_while({"", nil}, chunk_fun, after_fun)
  |> Enum.join()
end

assert compress.("AAABBAAC") == "3A2B2A1C"
