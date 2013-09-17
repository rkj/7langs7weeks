object Field extends Enumeration {
  type Field = Value
  val X, O, E = Value
}
object Board {
  def parse(repr : String) = {
    repr.split("\n").map { line =>
      //println("New Line: >" + line + "<")
      line.toCharArray.map { char =>
        //println(char)
        char match {
          case 'X' => Field.X
          case 'O' => Field.O
          case 'E' => Field.E
        }
      }
    }
  }
}

class Board(val arr : Array[Array[Field.Value]] ) {
  def this(repr : String) {
    this(Board.parse(repr))
  }
  require(arr.size == 3)

  def rows() = {
    arr
  }
  def cols() = {
    arr transpose
  }
  def diags() = {
    Array(
      Array(arr(0)(0), arr(1)(1), arr(2)(2)),
      Array(arr(0)(2), arr(1)(1), arr(2)(0))
    )
  }
  def win() = {
    val triplets = rows ++ cols ++ diags
    triplets.map { triplet =>
      val d = triplet.distinct
      (d.size == 1 && d(0) != Field.E, d(0))
    }.filter(b => b._1)
  }
  def toString(arr : Array[Array[Field.Value]]) = {
    arr.map { row => row.mkString(" ") }.mkString("\n")
  }
  override def toString() = {
    toString(arr)
  }
}

val b = new Board("XXX\nEOE\nEEO")
println(b)
println(b.toString(b.cols))
println(b.toString(b.diags))
println(b.win.mkString("\n"))
//val b2 = new Board("XXXX\nEOEE\nEEOE\nEEEE")
