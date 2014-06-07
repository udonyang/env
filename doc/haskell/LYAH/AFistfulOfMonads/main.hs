import Data.Maybe
import Control.Monad

-- My Functor, Applicative Functor and Monad
class MyFunctor f where
  infixl 4 <<$>
  (<<$>) :: (a -> b) -> f a -> f b

class MyFunctor f => MyApplicative f where 
  myPure :: a -> f a
  infixl 4 <<*>
  (<<*>) :: f (a -> b) -> f a -> f b

class MyMonad m where
  myReturn :: a -> m a
  (<>>=) :: m a -> (a -> m b) -> m b

-- Maybe Test
type Birds = Int

type Pole = (Birds, Birds)

landLeft n (left, right)
  | abs (left + n - right) < 4 = Just (left + n, right)
  | otherwise = Nothing

landRight n (left, right)
  | abs (left - right - n) < 4 = Just (left, right + n)
  | otherwise = Nothing

banana _ = Nothing

foo = do
  x <- return 3
  y <- return "!"
  Just $ show x ++ y

routine = do
  start <- return (0, 0)
  first <- landLeft 2 start
  second <- landRight 2 first
  landLeft 1 second

routineVerbose = return (0, 0)
  >>= (\start -> landLeft 2 start
  >>= (\first -> landRight 2 first
  >>= (\_ -> Nothing 
  >>= (\second -> landLeft 1 second))))

routineVerbose' = return (0, 0)
  >>= \start -> landLeft 2 start
  >>= \first -> landRight 2 first
  >>= \second -> landLeft 1 second

wopwop = do
  (x:xs) <- Just "H"
  return x

maybeTest = return (Just (0, 0) >>= landLeft 2 >>= banana >>= landRight 5)
  >> print foo
  >> print routine
  >> print routineVerbose
  >> print routineVerbose'
  >> print wopwop

-- List test
test1 = [3,4,5] >>= \x -> [x, -x]

test2 = [] >>= \x -> ["bad", "mad", "rad"]

test3 :: [Int]
test3 = [1,2,3] >>= \x -> []

test4 = [1,2] >>= \n -> ['a', 'b'] >>= \ch -> return (n, ch)

test5 = do
  n <- [1, 2]
  ch <- ['a', 'b']
  return (n,ch)

-- list comprehension
test6 = [x | x <- [1..50], '7' `elem` show x]

-- guard filter out
test7 = [1..50] >>= \x -> guard ('7' `elem` show x) >> return x

-- do filter out
test8 = do
  x <- [1..50]
  guard ('7' `elem` show x)
  return x

-- knight quest
type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = do
  (c',r') <-
    [ (c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
    , (c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
  guard (c' `elem` [1..8] && r' `elem` [1..8])
  return (c',r')

in3 :: KnightPos -> [KnightPos]
in3 start = return start >>= moveKnight >>= moveKnight >>= moveKnight

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start

test9 = (6,2) `canReachIn3` (7,3)

listTest = print test1
  >> print test2
  >> print test3
  >> print test4
  >> print test5
  >> print test6
  >> print test7
  >> print test8
  >> print test9

-- Main
main = do
  maybeTest
  listTest
