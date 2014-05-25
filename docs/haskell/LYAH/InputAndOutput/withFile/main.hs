import qualified System.IO as IO
main = do
  IO.withFile "input.in" IO.ReadMode (\handle -> do
    contents <- IO.hGetContents handle
    putStr contents)
