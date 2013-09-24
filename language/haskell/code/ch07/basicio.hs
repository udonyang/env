module BasicIO where

main = do
  putStrLn "Greatings! What is your name?"
  inpStr<-getLine
  putStrLn $ "Welcome to Haskell, "++inpStr++"!"
