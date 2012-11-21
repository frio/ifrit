module Main where

import Ifrit.Client.Pushover
import Ifrit.Framework

api  = "1"
user = "1"
config = Pushover api user

main :: IO ()
main = do
  send config $ TitledMessage "Awesome title" "Awesome test"
  return ()