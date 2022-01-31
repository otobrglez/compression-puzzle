object CompressionPuzzle02 extends App {
  val compress: String => String =
    _.foldLeft(Seq.empty[String]) {
      case (Nil, char) => List(char.toString)
      case (h :: t, char) =>
        if (h.endsWith(char.toString) || h.isEmpty)
          (h + char.toString) :: t
        else char.toString :: h :: t
    }.reverse
      .flatMap(s => Seq(s.length.toString, s.head))
      .mkString


  assert(compress("AAABBAAC") == "3A2B2A1C")
}
