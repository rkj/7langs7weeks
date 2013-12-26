
module Main where
  import Data.List
  {-sortDesc = sortBy (\x y -> compare y x)-}
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
