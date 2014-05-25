{-# LANGUAGE FlexibleInstances, TypeSynonymInstances, OverlappingInstances #-}
module SimpleClass where

import Data.List

class Foo a where
  foo :: a -> String

instance Foo a => Foo [a] where
  foo = concat . intersperse ", " . map foo

instance Foo Char where
  foo c = [c]

instance Foo String where
  foo = id
