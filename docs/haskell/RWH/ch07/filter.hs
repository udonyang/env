module Filter where

main = interact (unlines.filter (elem 'a').lines)
