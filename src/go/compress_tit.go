package main

import "fmt"

func compress(in string) (out string) {
	if len(in) == 0 {
		return ""
	}
	ch := in[0]
	count := 0
	for {
		if len(in) == 0 {
			break
		}
		cur := in[0]
		in = in[1:]
		if cur == ch {
			count++
			continue
		}
		out = out + fmt.Sprintf("%d%s", count, string(ch))
		ch = cur
		count = 1
	}
	out = out + fmt.Sprintf("%d%s", count, string(ch))
	return
}

func main() {
	if compress("AAABBAAC") != "3A2B2A1C" {
		panic("AAABBAAC does not match 3A2B2A1C")
	}
}
