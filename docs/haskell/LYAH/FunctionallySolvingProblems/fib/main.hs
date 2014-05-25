import System.Environment

main = do
  (numberString:_) <- getArgs
  putStrLn $ show $ fib (read numberString)

fib n = genFib n 0 1

genFib 0 a _ = a
genFib 1 _ b = b
genFib n a b = genFib (n-1) b $! (a+b)`mod`1000000007
