import System.IO
import System.Directory
import Data.List

main = do
  handle <- openFile "input.in" ReadMode
  (tempFileName, tempFileHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let tasks = lines contents
      linedTasks = zipWith (\n task -> show n ++ " - " ++ task) [0..] tasks
  putStr $ unlines linedTasks
  putStr $ "Which task should be deleted? : "
  numberBuff <- getLine
  let number = read numberBuff
      newTasks = delete (tasks !! number) tasks
  hPutStr tempFileHandle $ unlines newTasks
  hClose handle
  hClose tempFileHandle
  removeFile "input.in"
  renameFile tempFileName "input.in"
