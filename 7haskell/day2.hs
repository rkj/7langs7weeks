
module Main where
  import Data.List
  import Test.QuickCheck
  import Test.HUnit

  -- this doesnt work because (roughly) of monomorphic restriction
  -- sortDesc = sortBy (\x y -> compare y x)
  sortDesc2 xs = sortBy (\x y -> compare y x) xs
  fib = 0:1:zipWith (+) fib (tail fib)
  gen y x = x:(gen y (x + y))
  gen3 = gen 3
  gen5 = gen 5
  euclidean a b = last $ takeWhile (> 0) residues
    where residues = a : b : zipWith mod residues (tail residues)

  primes = 2:filter isPrime [3..]
  isPrime n = all (\x -> n `mod` x /= 0) $ takeWhile (\x -> x * x <= n) primes
  mprimes = take 1000000 primes

  split s limit = split' s "" "" [] 0 where
    split' :: [Char] -> [Char] -> [Char] -> [[Char]] -> Integer -> [[Char]]
    split' (h:t) word line result length
      | h ==  ' ' && t == []  =  result ++ [line ++ word]
      | t == []               =  split' (h:" ") word line result length
      | h == ' '              =  split' t "" (line ++ word ++ [h]) result (length + 1)
      | length >= limit && line /= "" = split' t (word ++ [h]) "" (result ++ [line]) 0 -- bug here, zero should be word length
      | otherwise             =  split' t (word ++ [h]) line result (length + 1)

  split2 s limit = split' s ("", "", "") [] 0 where
    split' [] (line, "", "") result length = result ++ [line]
    split' [] p result length = split' " " p result length
    split' (h:t) (line, rest, word) result length
      | (length > limit && line /= "") =  split' rest ("", rest, "") (result ++ [line]) 0
      | h == ' '                       =  split' t (line ++ word ++ [h], t, "") result (length + 1)
      | otherwise                      =  split' t (line, rest, word ++ [h]) result (length + 1)

  splitnl s limit = fst lines where
    lines = foldl (\(res, lineno) line -> (res ++ [(show lineno) ++ ": " ++ line], lineno + 1) )
                   ([], 1)
                   (split2 s limit)
