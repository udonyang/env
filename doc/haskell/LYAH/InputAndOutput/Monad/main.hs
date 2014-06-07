main = do
  rs <- sequence [getLine, getLine, getLine]
  putStr $ unlines rs
