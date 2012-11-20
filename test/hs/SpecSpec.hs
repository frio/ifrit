module SpecSpec where
-- ensures that hspec is actually working
-- because I am a chump

import Test.Hspec

spec = do
  describe "A working hspec setup" $ do
    it "should be able to tell that true is true!" $ do
      True `shouldBe` True
