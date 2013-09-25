val list = List("ala", "ma", "kota")

val size = (0 /: list) { (sum, s) => sum + s.size }
// println size
println(size)
println(list.map(_.size).reduceLeft(_+_))
println(list.map(_.size).sum)
