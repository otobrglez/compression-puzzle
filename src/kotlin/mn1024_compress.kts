fun compress(input: String): String {
  var compressed = ""
  return input
    .map { "$it" }
    .reduce { seq, el ->
      seq.let {
        if (it.take(1) != el) {
          compressed += "${it.length}${it.first()}"
          "$el"
        } else it.plus(el)
      }
    }.let {
      compressed + "${it.length}${it.first()}"
    }
}

if (compress("AAABBAAC") != "3A2B2A1C") throw AssertionError()
