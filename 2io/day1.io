1 + 1
// 1 + "one"
// "one" + "two"
true or nil // false
true or 0 // true

// that doesn't work
(12 getSlot("+")(5)) println

meth := 12 getSlot("+")
12 meth(1) println

