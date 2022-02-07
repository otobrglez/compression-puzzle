fun compress(input: String): String {
    // [A, A, A, B, B, A, A, C]
 return input.chunked(1)
    // ["AAA", "BB", "AA", "C"]
    .fold(mutableListOf<String>(), { sequences, ch -> 
        sequences.add(if (!sequences.isEmpty() 
                           && sequences.last().contains(ch))
                        sequences.removeLast().plus(ch)
                    else
                        ch)
        sequences
    })
    // ["3A", "2B", "2A", "1C"]
    .map({ it.length.toString() + it.first() })
    // "3A2B2A1C"
    .joinToString("")
}

if (compress("AAABBAAC") != "3A2B2A1C")
    throw AssertionError()
