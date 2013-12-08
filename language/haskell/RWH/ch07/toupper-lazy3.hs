module ToUpperLazy3 where

import Data.Char(toUpper)

main = do
  inpStr<-readFile "input.txt"
  writeFile "output.txt" (map toUpper inpStr)
