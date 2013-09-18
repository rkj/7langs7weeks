
//implicit def intToString(x: Int) = x.toString
class Test(name : String) {
  //name = name + name
}
class Test2(val name : String) {
  //name = name + name
}
class Test3(var name : String) {
  name = name + name
  def bla(x : String) {
    println("A String: " + x)
  }
  def ibla[A](x : A)(implicit conv : A => String) {
    println("A String: " + x)
  }
}
class X$ {
  def test { println("X$.test") }
}
object X {
  def test { println("X.test") }
}
val x = new X$
println(x.getClass.getName)
println(X.getClass.getName)
x.test

object Test {
  def static { println("Static method") }
}

val a = new Test("bla")
Test.static
println(a.getClass.getName)
println(Test.getClass.getName)
//println(Class.forName("Test$") == Test)
//println(a.name)
val a2 = new Test2("bla")
println(a2.name)
val a3 = new Test3("bla")
println(a3.name)
a3.bla(10 + "a")
//a3.ibla(10)
//a3.bla(10)

