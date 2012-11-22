-- the Dummy client is a basic noop client.  It exists as an example of how to implement a client.
module Ifrit.Client.Dummy where

import Ifrit.Framework

data Dummy = Dummy

instance Sendable Dummy where
  send _ msg = return True

instance Receivable Dummy where
  receive _ = return $ TitledMessage "noop" "noop"
