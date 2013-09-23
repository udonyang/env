module JSONClass where

data JValue = JString [Char]
  | JBool Bool
  | JNull
  deriving (Show)

type JSONError = String

class JSON a where
  toJValue::a->JValue
  fromJValue::JValue->Either JSONError a

instance JSON JValue where
  toJValue = id
  fromJValue = Right

instance JSON Bool where
  toJValue = JBool
  fromJValue (JBool b) = Right b
  fromJValue _ = Left "not a JSON boolean"
