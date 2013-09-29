module MyShow where

class MyShow a where
  myShow :: a -> String
  myShowList :: [a] -> String
  myShow _ = ""
  myShowList _ = ""

instance MyShow Char where
  myShow a = a:[]
  myShowList a = a

instance MyShow a => MyShow [a] where
  myShow = myShowList
