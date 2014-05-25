module Imp where

import System.IO
import Data.Char (toUpper)

main::IO ()
main = do
  inh<-openFile "input.txt" ReadMode
  outh<-openFile "output.txt" WriteMode
  mainloop inh outh
  hClose inh
  hClose outh

mainloop::Handle->Handle->IO ()
mainloop inh ouh = do
  ineof <- hIsEOF inh
  if ineof then return ()
  else do
    inpStr <- hGetLine inh
    hPutStrLn ouh (map toUpper inpStr)
    mainloop inh ouh
