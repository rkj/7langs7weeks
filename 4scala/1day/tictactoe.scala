object Board {
  def parse(repr : String) = {
    repr.split("\n").map { line => line.toCharArray }
  }
  def toString(arr : Array[Array[Char]]) = {
    arr.map { row => row.mkString(" ") }.mkString("\n")
  }
}

class Board(val arr : Array[Array[Char]] ) {
  def this(repr : String) {
    this(Board.parse(repr))
  }
  require(arr.size == 3)

  def rows = arr
  def cols = arr.transpose
  def diags = {
    Array(
      Array(arr(0)(0), arr(1)(1), arr(2)(2)),
      Array(arr(0)(2), arr(1)(1), arr(2)(0))
    )
  }
  def win = {
    val lines = rows ++ cols ++ diags
    lines.map { line =>
      val d = line.distinct
      ( d.size == 1 && d(0) != 'E',
        d(0))
    }.filter(tuple => tuple._1).map (_._2)
  }
  def state = {
    val isAnyEmpty = rows.exists { row =>
      row.exists { _ == 'E' }
    }
    val w = win
    if (!w.isEmpty) {
      w(0).toString + " won"
    } else if (isAnyEmpty){
      "Game in progress"
    } else {
      "Draw"
    }
  }
  override def toString = {
    Board.toString(arr) + "\n- " + state + "\n"
  }
}

val b = new Board("XXX\nEOE\nEEO")
println(b)
//println(Board.toString(b.cols))
//println(Board.toString(b.diags))
//val b2 = new Board("XXXX\nEOEE\nEEOE\nEEEE")
//val b3 = new Board("XXY\nEOE\nEEO")

println(new Board("XEX\nOOO\nEEO"))
println(new Board("XEX\nOEO\nEEO"))
println(new Board("XOX\nOXO\nOXO"))
