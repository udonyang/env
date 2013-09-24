{-# LANGUAGE
  TypeSynonymInstances,
  FlexibleInstances,
  OverlappingInstances
  #-}
module Overlap where

import BrokenClass

class Broked a where
  brok::a->String

instance Broked Int where
  brok = show

instance Broked (Int, Int) where
  brok (a, b) = brok a ++ ", " ++ brok b

instance (Broked a, Broked b) => Broked(a, b) where
  brok (a, b) = ">>" ++ brok a ++ " " ++ brok b ++ "<<"
