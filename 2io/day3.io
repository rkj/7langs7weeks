# ex 1
Builder := Object clone
Builder indent := 0
Builder forward := method(
  write(" " repeated(self indent))
  write("<", call message name)
  map := call message arguments at(0) 
  writeln(">")
  self indent = self indent + 2
  call message arguments foreach(arg,
    content := self doMessage(arg)
    if(content type == "Sequence", write(" " repeated(self indent)); writeln(content))
  )
  self indent = self indent - 2
  write(" " repeated(self indent))
  writeln("</", call message name, ">")
  )
Builder ul(
  li("Io"), 
  ul(
    li("ab")
    li("xy")
  )
  li("Lua"), 
  li("JavaScript"))

# ex 2
squareBrackets := method(
  call evalArgs
)
[1, 2, 3, "ala"] println

# ex 3
OperatorTable addAssignOperator(":", "atPutX")
MapX := Map clone
curlyBrackets := method(
  r := MapX clone
  call message arguments foreach(arg,
    r doString(arg asString)
  )
  r
)
MapX atPutX := method(key, value,
  self atPut(doString(key), value)
)
{ 
    "Bob Smith": "5195551212",
    "Mary Walsh": 416222343
} asJson println

Builder book({"author": "Tate"},
  text("XYZ")
)
