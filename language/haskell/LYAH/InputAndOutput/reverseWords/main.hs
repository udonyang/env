import Control.Monad

main = do
  line <- getLine
  when (null line /= True) $ do
      putStrLn $ unwords $ map reverse $ words line
      main
