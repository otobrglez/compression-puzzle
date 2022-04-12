object CompressionPuzzle04 extends App {
  def compress(input: String): String =
    (input + '0')
      .foldLeft((List.empty[String], 0, ' ')) {
        case ((acc, n, c), c2) => if (c == c2) (acc, n + 1, c) else ((n.toString + c) :: acc, 1, c2)
      }
      ._1
      .reverse.tail.mkString("")

  assert(compress("AAABBAAC") == "3A2B2A1C")
}
