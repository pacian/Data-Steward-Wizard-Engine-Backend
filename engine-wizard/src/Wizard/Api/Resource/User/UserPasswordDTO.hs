module Wizard.Api.Resource.User.UserPasswordDTO where

import GHC.Generics

data UserPasswordDTO =
  UserPasswordDTO
    { _password :: String
    }
  deriving (Generic)
