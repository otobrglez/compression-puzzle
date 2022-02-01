package main

import (
  "fmt"
)

func compress(in string) (out string) {
  if len(in) == 0 {
    return ""
  }
  ch := rune(in[0])
  count := 0
  for _, cur := range in {
    if cur == ch {
      count++
      continue
    }
    out = out + fmt.Sprint(count) + string(ch)
    ch = cur
    count = 1
  }
  out = out + fmt.Sprint(count) + string(ch)
  return
}

func main() {
  if compress("AAABBAAC") != "3A2B2A1C" {
    panic("AAABBAAC does not match 3A2B2A1C")
  }
}
