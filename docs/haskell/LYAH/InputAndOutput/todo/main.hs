import System.IO (readFile, writeFile)
import System.Environment (getArgs)
import Data.List (delete)

dispatch :: [(String, [String] -> IO ())]
dispatch =
  [ ("add", add)
  , ("view", view)
  , ("remove", remove)
  , ("bump", bump)]

main = do
  (actionString:args) <- getArgs
  Just action <- return $ lookup actionString dispatch
  action args

add [fileName, task] = appendFile fileName $ task ++ "\n"

view [fileName] = do
  tasksString <- readFile fileName
  let tasks =  lines tasksString
      linedTasks = zipWith (\n task -> show n ++ " - " ++ task) [0..] tasks
  putStrLn $ unlines linedTasks

remove [fileName, numberString] = do
  tasksString <- readFile fileName
  let tasks = lines tasksString
      newTasks = delete (tasks !! read numberString) tasks
  writeFile fileName $ unlines newTasks

bump [fileName, numberString] = do
  tasksString <- readFile fileName
  let tasks = lines tasksString
      topTask = tasks !! read numberString
      newTasks = delete topTask tasks
  writeFile fileName $ unlines $ topTask : newTasks
