package main

import "fmt"

func compress(in string) (out string) {
	if len(in) == 0 {
		return ""
	}
	ch := rune(in[0])
	count := 0
	for _, c := range in {
		if ch != c {
			out += fmt.Sprintf("%d%s", count, string(ch))
			count = 0
			ch = c
		}
		count++
	}
	out += fmt.Sprintf("%d%s", count, string(ch))
	return out
}

func main() {
	if compress("AAABBAAC") != "3A2B2A1C" {
		panic("AAABBAAC does not match 3A2B2A1C")
	}
}
