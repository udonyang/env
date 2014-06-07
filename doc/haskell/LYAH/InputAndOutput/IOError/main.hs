import System.Environment
import System.IO
import System.IO.Error

main = toTry `catchIOError` handler

toTry = do
  (fileName:_) <- getArgs
  contents <- readFile fileName
  putStrLn $ "The file " ++ fileName ++ " has " ++ show (length $ lines contents) ++ " lines."

handler e
  | isDoesNotExistError e =
    case ioeGetFileName e of
      Just path -> putStrLn $ "Dafuk!! File doesn't exist at: " ++ path ++ "."
      Nothing -> putStrLn $ "Dafuk!! File doesn't exist at an unknown location."
  | otherwise = ioError e
