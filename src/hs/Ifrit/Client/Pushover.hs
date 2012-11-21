{-# LANGUAGE OverloadedStrings #-}
module Ifrit.Client.Pushover where

import Ifrit.Framework
import Network.HTTP.Conduit
import Data.Conduit
import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Char8 as C
import Data.Conduit.Binary (sinkFile)

data Pushover = Pushover { apiToken :: String
                         , userKey :: String }
                         deriving (Eq, Show)


endpoint = "https://api.pushover.net/1/messages.json"

instance Sendable Pushover where
  send config msg =
       runResourceT $ do
           manager <- liftIO $ newManager def
           noBody  <- liftIO req
           let post = query noBody
           res     <- http post manager
           responseBody res $$+- sinkFile "foo.txt"
           return True
         where req   = parseUrl endpoint
               query = urlEncodedBody [ ("token",   C.pack $ apiToken config)
                                      , ("user",    C.pack $ userKey config)
                                      , ("message", C.pack $ message msg)
                                      ]
