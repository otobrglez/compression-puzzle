object CompressionPuzzle03 extends App {
  def compress(input: String): String =
    input.split("(?<=(.))(?!\\1|$)").foldLeft(new StringBuilder())((sb, s) => sb.append(s.length).append(s.head)).toString  
  
  assert(compress("AAABBAAC") == "3A2B2A1C")
}
