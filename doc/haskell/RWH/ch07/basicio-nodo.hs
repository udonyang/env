module BasicIONoDo where

main =
  putStrLn "Greeting! What is your name?" >>
  getLine >>=
  (\inpStr->putStrLn $ "Welcome to Haskell, "++inpStr++"!")

