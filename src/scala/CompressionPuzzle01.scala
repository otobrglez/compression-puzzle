object CompressionPuzzle01 extends App {
  val compress: String => String = input =>
    "(?<=(.))(?!\\1|$)".r
        .split(input)
        .flatMap(s => Seq(s.length.toString, s.head))
        .mkString

  assert(compress("AAABBAAC") == "3A2B2A1C")
}
