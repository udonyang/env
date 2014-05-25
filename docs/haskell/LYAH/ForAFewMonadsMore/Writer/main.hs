import Data.Maybe
import Data.Monoid
import Control.Monad


{-
isBigGang x = (x > 9, "Compared gang size to 9")
applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, log) f = (y, log ++ newLog) where (y, newLog) = f x
-}

applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = (y, log `mappend` newLog) where (y, newLog) = f x

type Food = String
type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

writerTest = do
  -- print $ (3, "Smallish gang.") `applyLog` isBigGang
  -- print $ (30, "A freaking platoon") `applyLog` isBigGang
  print $ Sum 3 `mappend` Sum 9
  print $ ("beans", Sum 10) `applyLog` addDrink
  print $ ("jerky", Sum 25) `applyLog` addDrink
  print $ ("dogmeat", Sum 5) `applyLog` addDrink `applyLog` addDrink


-- Main
main = do
  writerTest
