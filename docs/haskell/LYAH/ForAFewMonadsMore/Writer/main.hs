import Data.Maybe
import Data.Monoid
import Control.Monad
import Control.Monad.Instances


-- isBigGang x = (x > 9, "Compared gang size to 9")
-- applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
-- applyLog (x, log) f = (y, log ++ newLog) where (y, newLog) = f x

applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = (y, log `mappend` newLog) where (y, newLog) = f x

type Food = String
type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

newtype Writer w a = Writer {runWriter :: (a, w)} deriving (Show)

instance Monoid w => Monad (Writer w) where
	return x = Writer (x, mempty)
	Writer (x, v) >>= f = Writer (y, v `mappend` v') where
		Writer (y, v') = f x

logNumber :: Int -> Writer [String] Int
logNumber x = Writer (x, ["Got Number: " ++ (show x)])

tell :: w -> Writer w ()
tell w = Writer ((), w)

multWithLog = do
	a <- logNumber 3
	b <- logNumber 5
	tell ["Gonna multiply this two"]
	return (a * b)

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
	| b == 0 = do
		tell ["Finish with: " ++ show a]
		return a
	| otherwise = do
		tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
		gcd' b (a `mod` b)

newtype DiffList a = DiffList {getDiffList :: [a] -> [a]}

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Monoid (DiffList a) where
	mempty = DiffList ([]++)
	mappend (DiffList f) (DiffList g) = DiffList (f . g)

gcdReverse' :: Int -> Int -> Writer (DiffList String) Int
gcdReverse' a b
	| b == 0 = do
		tell $ toDiffList ["Finish with: " ++ show a]
		return a
	| otherwise = do
		result <- gcdReverse' b (a `mod` b)
		tell $ toDiffList [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
		return result

finalCountDown :: Int -> Writer [String] ()
finalCountDown 0 = tell ["0"]
finalCountDown x = do
	finalCountDown $ x - 1
	tell [show x]

finalCountDown' :: Int -> Writer (DiffList String) ()
finalCountDown' 0 = tell $ toDiffList ["0"]
finalCountDown' x = do
	finalCountDown' $ x - 1
	tell $ toDiffList [show x]

addStuff :: Int -> Int
addStuff = do
	a <- (*2)
	b <- (+10)
	return (a+b)

-- Main
main = do
  -- print $ (3, "Smallish gang.") `applyLog` isBigGang
  -- print $ (30, "A freaking platoon") `applyLog` isBigGang
  -- print $ Sum 3 `mappend` Sum 9
  -- print $ ("beans", Sum 10) `applyLog` addDrink
  -- print $ ("jerky", Sum 25) `applyLog` addDrink
  -- print $ ("dogmeat", Sum 5) `applyLog` addDrink `applyLog` addDrink
	print $ runWriter (return 3 :: Writer String Int)
	print $ runWriter (return 3 :: Writer (Product Int) Int)
	print $ multWithLog
	mapM_ putStrLn . snd . runWriter $ gcd' 8 3
	mapM_ putStrLn . fromDiffList . snd . runWriter $ gcdReverse' 8 3
	-- print $ length . snd . runWriter $ finalCountDown 500000
	-- print $ length . fromDiffList . snd . runWriter $ finalCountDown' 500000
	print $ addStuff 3
