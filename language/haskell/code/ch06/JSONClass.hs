module JSONClass where

import SimpleJSON

type JSONError = String

class JSON a where
  toJValue::a->JValue
  fromJValue::JValue->Either JSONError a

instance JSON JValue where
  toJValue = id
  fromJValue = Right

instance JSON Bool where
  toJValue = JBool
  fromJValue (JBool a) = Right a
  fromJValue _ = Left "not a JSON boolean"

instance JSON [a] where
  toJValue = JString
  fromJValue (JString a) = Right a
  fromJValue _ = Left "not a JSON string"
