object CompressionPuzzle05 extends App {
  val regex = "(.)\\1*".r
  def compress(s: String): String =
    regex.findAllIn(s).map(x => x.length + x.take(1)).mkString  
  
  assert(compress("AAABBAAC") == "3A2B2A1C")
}
