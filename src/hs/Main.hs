module Main where

import Network.Client.Pushover

api  = "1"
user = "1"
config = PushoverConfiguration api user

main :: IO ()
main = send config "This is a test"
