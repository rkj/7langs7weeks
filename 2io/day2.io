Object printAndDo := method(
    "\n==========" println
    call message arguments join(", ") println
    //call message code print
    //call message print
    "----------" println
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
  tmp := Matrix clone
  for (i, 0, y-1,
    row := List clone
    for (j, 0, x-1, row append(nil))
    tmp append(row)
  )
  tmp
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

// ex 6
Matrix transpose := method(
  x := size
  y := at(0) size
  new := Matrix dim(x, y)
  for (i, 0, y-1,
    for (j, 0, x-1, new set(j, i, get(i, j)))
  )
  new
)
printAndDo(m transpose)
printAndDo(m transpose == m)
printAndDo(m transpose transpose == m)

// ex 7
Matrix y := method(size)
Matrix x := method(at(0) size)
Matrix save := method(filename,
  f := File with(filename)
  f remove
  f openForUpdating
  f write(x() .. "," .. y() .. "\n")
  f write(asString)
  f close
)

Matrix load := method(filename,
  f := File with(filename)
  f openForReading
  size := f readLine split(",")
  ret := Matrix dim(size at(0) asNumber, size at(1) asNumber)
  f readLines foreach(i, line,
    ret atPut(i, doString(line))
  )
  f close
  ret
)
fn := "/tmp/matrix.txt"
m save(fn)
printAndDo(Matrix load(fn))

