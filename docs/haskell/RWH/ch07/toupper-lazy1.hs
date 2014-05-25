module ToUpperLazy1 where

import System.IO
import Data.Char(toUpper)

main = do
  inh<-openFile "input.txt" ReadMode
  ouh<-openFile "output.txt" WriteMode
  inStr<-hGetContents inh
  let result = processData inStr
  hPutStr ouh result
  hClose inh
  hClose ouh

processData::String->String
processData = map toUpper
