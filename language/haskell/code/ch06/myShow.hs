module MyShow where

class MyShow a where
  myShow :: a -> String
  myShow a = a
  myShowList :: [a] -> String
  myShowList [a] = "[" ++ helpper [a] where
    helpper [] = "]"
    helpper (a:as) = a ++ ", " ++ helpper as
