module Test.Main where

import Effect

import Control.Monad.Free (Free)
import Crypto.Bcrypt (Hash(..), compare, hash)
import Prelude (Unit, bind, discard)
import Test.Unit (TestF, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)


main :: Effect Unit
main =
  runTest suites


suites :: Free TestF Unit
suites = do
  test "Crypo.BCrypt" do
    let password = "hunter7"
    hashed <- hash 1 password

    Assert.expectFailure
      "password should not match hash"
      (Assert.equal (Hash password) hashed)

    shouldMatch <- compare hashed password
    Assert.assert "password hashed can be checked" shouldMatch

    shouldntMatch <- compare hashed "blink182"
    Assert.assertFalse "should not match other password" shouldntMatch
