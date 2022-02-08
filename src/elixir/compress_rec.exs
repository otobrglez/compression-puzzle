import ExUnit.Assertions

defmodule Puzzle do
  def compress(input, char \\ "", count \\ nil)
  def compress(<<char::utf8, rest::binary>>, char, count), do: compress(rest, char, count + 1)
  def compress(<<char::utf8, rest::binary>>, prev, count), do: "#{count}#{[prev]}" <> compress(rest, char, 1)
  def compress("", char, count), do: "#{count}#{[char]}"
end

assert Puzzle.compress("AAABBAAC") == "3A2B2A1C"
