import Data.List
import System.Environment

main = do
  (rpn:_) <- getArgs
  putStrLn $ show $ parseRPN rpn

parseRPN :: String -> Double
parseRPN rpn = head $ foldl' parser [] $ words rpn

parser (x:y:xs) "+" = y + x:xs
parser (x:y:xs) "-" = y - x:xs
parser (x:y:xs) "*" = y * x:xs
parser (x:y:xs) "/" = y / x:xs
parser (x:y:xs) "^" = y ** x:xs
parser (x:xs) "ln" = log x:xs
parser xs "sum" = [sum xs]
parser xs numberString = read numberString:xs
