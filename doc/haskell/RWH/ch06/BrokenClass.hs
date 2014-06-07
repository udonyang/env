{-# LANGUAGE FlexibleInstances #-}
module BrokenClass where

import SimpleJSON
import JSONClass

instance (JSON a) => JSON [a] where
  toJValue = undefined
  fromJValue = undefined

instance (JSON a) => JSON [(String, a)] where
  toJValue = undefined
  fromJValue = undefined
