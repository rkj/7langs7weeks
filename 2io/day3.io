# ex 1
Builder := Object clone
Builder indent := 0
Builder forward := method(
  write(" " repeated(self indent))
  write("<", call message name)
  map := doMessage(call message arguments at(0))
  if(map type == "MapX",
    map asList sort foreach(kv,
      key := kv at(0); value := kv at(1)
      (" " .. key .. "=\"" .. value .. "\"") print
    )
  )
  writeln(">")
  self indent = self indent + 2
  call message arguments foreach(arg,
    content := self doMessage(arg)
    if(content type == "Sequence",
      write(" " repeated(self indent))
      writeln(content))
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
Object squareBrackets := method(
  call evalArgs
)
[1, 2, 3, "ala"] println

Object "funny" := method("funnymethod" println)
"XXXXXXXXXXXX" println
123 "funny"(12, "123")
"YYYYYYYYY" println
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
# TODO: return string for unknown methods
#MapX forward := method(
#)
MapX atPutX := method(key, value,
  self atPut(doString(key), value)
)
{ 
    "Bob": "5195551212",
    "Mary Walsh": 416222343
} asJson println

Builder book({"author": "Tate"},
  text({"a": 1, "b": "arg", "c": "!"}, "XYZ")
)
