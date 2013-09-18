
class Test(name : String) {
  //name = name + name
}
class Test2(val name : String) {
  //name = name + name
}
class Test3(var name : String) {
  name = name + name
}
val a = new Test("bla")
//println(a.name)
val a2 = new Test2("bla")
println(a2.name)
val a3 = new Test3("bla")
println(a3.name)
