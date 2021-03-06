module Registry.Model.Config.ServerConfig where

import GHC.Generics

import Shared.Model.Config.Environment
import Shared.Model.Config.ServerConfig

data ServerConfig =
  ServerConfig
    { _serverConfigGeneral :: ServerConfigGeneral
    , _serverConfigDatabase :: ServerConfigDatabase
    , _serverConfigMail :: ServerConfigMail
    , _serverConfigAnalytics :: ServerConfigAnalytics
    , _serverConfigLogging :: ServerConfigLogging
    }
  deriving (Generic, Show)

data ServerConfigGeneral =
  ServerConfigGeneral
    { _serverConfigGeneralEnvironment :: Environment
    , _serverConfigGeneralClientUrl :: String
    , _serverConfigGeneralServerPort :: Int
    , _serverConfigGeneralTemplateFolder :: String
    , _serverConfigGeneralRemoteLocalizationUrl :: Maybe String
    }
  deriving (Generic, Show)
