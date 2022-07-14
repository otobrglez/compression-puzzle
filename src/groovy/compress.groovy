String compress(String input) {
    StringBuilder.newInstance().tap { result ->
        (input.toList() + '').inject { acc, next ->
            acc[0].with { current ->
                if (current == next) {
                    acc + next
                } else {
                    result << acc.size() << current
                    next
                }
            }
        }
    }
}
assert compress("AAABBAAC") == "3A2B2A1C"