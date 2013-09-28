module MyShow where

class MyShow a where
  myShowsPrec :: Int -> a -> myShowS
  myShow :: a -> String
  myShowList :: [a] -> myShowS

instance MyShow [a] where
