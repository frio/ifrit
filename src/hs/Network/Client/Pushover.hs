{-# LANGUAGE OverloadedStrings #-}
module Network.Client.Pushover where

import Network.HTTP.Conduit
import Data.Conduit
import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Char8 as C
import Data.Conduit.Binary (sinkFile)

data PushoverConfiguration = PushoverConfiguration { apiToken :: String
                                                   , userKey :: String }
                                                   deriving (Eq, Show)


type Message = String
                                                   
class CanSend a where
  send :: a -> Message -> IO ()

endpoint = "https://api.pushover.net/1/messages.json"

instance CanSend PushoverConfiguration where
  send config message =
       runResourceT $ do
           manager <- liftIO $ newManager def
           noBody  <- liftIO req
           let post = query noBody
           res     <- http post manager
           responseBody res $$+- sinkFile "foo.txt"
         where req   = parseUrl endpoint
               query = urlEncodedBody [ ("token",   C.pack $ apiToken config)
                                      , ("user",    C.pack $ userKey config)
                                      , ("message", C.pack $ message)
                                      ]