
module Main where
  rev [] = []
  rev (a:t) = (rev t) ++ [a]

  rev2 ([], acc) = acc
  rev2 ((h:t), acc) = rev2 (t, h:acc)

  rev3 xs = rev' xs [] where
    rev' [] acc = acc
    rev' (h:t) acc = rev' t (h:acc)

