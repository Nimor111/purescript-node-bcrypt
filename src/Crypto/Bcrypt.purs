module Crypto.Bcrypt
  ( Hash(..)
  , hash
  , compare
  ) where

import Effect.Aff

import Data.Functor (map)
import Data.Newtype (class Newtype, unwrap, wrap)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Prelude (class Eq, class Show)


newtype Hash =
  Hash String

derive instance newtypeHash :: Newtype Hash _
derive newtype instance showHash :: Show Hash
derive newtype instance eqHash :: Eq Hash


foreign import _hash
  :: Int
  -> String
  -> EffectFnAff String


foreign import _compare
  :: String
  -> String
  -> EffectFnAff Boolean


{-| Hash a password using the BCrypt algorithm and a given
number of rounds.

A salt is automatically generated.

See the documentation for the Javascript bcrypt.hash function
for more information.

https://www.npmjs.com/package/bcrypt#to-hash-a-password
-}
hash :: Int -> String -> Aff Hash
hash saltRounds password = do
  map wrap
    (fromEffectFnAff (_hash saltRounds password))



{-| Compare a password to a BCrypt password hash.

See the documentation for the Javascript bcrypt.compare function
for more information.

https://www.npmjs.com/package/bcrypt#to-check-a-password
-}
compare :: Hash -> String -> Aff Boolean
compare hashed password =
  fromEffectFnAff (_compare (unwrap hashed) password)
