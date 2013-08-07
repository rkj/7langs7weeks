Object printAndDo := method(
    "\n------------------" println
    call message arguments join(", ") println
    //call message code print
    //call message print
    "====================" println
    call evalArgs join(", ") println
) 
// warmUp
printAndDo(10)
printAndDo(10, 20, 30)
printAndDo(list(1, 2, 3) size)

// ex 1
Object fib := method(n,
  a := 1
  b := 1
  for(i, 3, n,
    c := a + b
    a := b
    b := c
  )
  b
)

Object fibRec := method(n,
  if (n <= 2, 1, fibRec(n - 1) + fibRec(n - 2))
)

printAndDo(fib(10))
printAndDo(fibRec(10))
printAndDo(fib(1000))
// printAndDo(fibRec(100))

// ex 2
originalDivide := Number getSlot("/")
Number / := method(b,
  if (b == 0, 0, self originalDivide(b))
)
printAndDo(20 / 2)
printAndDo(20 / 0)

// ex 4
List myAverage := method(
  self foreach(v, if(v type != Number type, Exception raise("not a number")))
  self sum / self size
)
printAndDo(list(1, 2, 3, 100) myAverage)
// printAndDo(list(1, 2, 3, "ala") myAverage)

// ex 5

Matrix := List clone
Matrix dim := method(x, y,
  for (i, 0, y,
    row := List clone
    for (j, 0, x, row append(nil))
    append(row)
  )
)
Matrix asString := method(
  map(l, l asString) join("\n")
)
Matrix set := method(x, y, value, at(y) atPut(x, value))
Matrix get := method(x, y, at(y) at(x))

printAndDo(
  m := Matrix dim(3, 4)
  m set(1, 2, 100)
  m
)
printAndDo(
  m get(1, 2)
)
