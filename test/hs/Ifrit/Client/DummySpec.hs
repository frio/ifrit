module Ifrit.Client.DummySpec where

import Ifrit.Client.Dummy
import Ifrit.Framework
import Test.Hspec

spec = do 
  describe "A dummy client which can send data" $ do
    it "can send a simple message" $ do
      let message = TitledMessage "awesome title" "amazing content!"
      response <- (send Dummy message)
      response `shouldBe` True