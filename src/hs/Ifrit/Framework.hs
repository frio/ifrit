{-# LANGUAGE FlexibleContexts #-}
module Ifrit.Framework where

import Control.Failure

data Message = TitledMessage { title   :: String
                             , message :: String }
                             deriving (Eq, Show)

class Sendable a where
  send :: a -> Message -> IO Bool

class Receivable a where
  receive :: a -> IO Message