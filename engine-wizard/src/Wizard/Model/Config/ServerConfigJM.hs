module Wizard.Model.Config.ServerConfigJM where

import Control.Lens ((^.))
import Control.Monad
import Data.Aeson

import LensesConfig
import Shared.Model.Config.EnvironmentJM ()
import Wizard.Model.Config.ServerConfig
import Wizard.Model.Config.ServerConfigDM

instance FromJSON ServerConfig where
  parseJSON (Object o) = do
    _serverConfigGeneral <- o .: "general"
    _serverConfigDatabase <- o .:? "database" .!= defaultDatabase
    _serverConfigMessaging <- o .:? "messaging" .!= defaultMessaging
    _serverConfigJwt <- o .: "jwt"
    _serverConfigRoles <- o .:? "roles" .!= defaultRoles
    _serverConfigMail <- o .:? "mail" .!= defaultMail
    _serverConfigRegistry <- o .:? "registry" .!= defaultRegistry
    _serverConfigAnalytics <- o .:? "analytics" .!= defaultAnalytics
    _serverConfigFeedback <- o .:? "feedback" .!= defaultFeedback
    return ServerConfig {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigGeneral where
  parseJSON (Object o) = do
    _serverConfigGeneralEnvironment <- o .:? "environment" .!= (defaultGeneral ^. environment)
    _serverConfigGeneralClientUrl <- o .: "clientUrl"
    _serverConfigGeneralServerPort <- o .:? "serverPort" .!= (defaultGeneral ^. serverPort)
    _serverConfigGeneralServiceToken <- o .: "serviceToken"
    _serverConfigGeneralIntegrationConfig <- o .:? "integrationConfig" .!= (defaultGeneral ^. integrationConfig)
    _serverConfigGeneralTemplateFolder <- o .:? "templateFolder" .!= (defaultGeneral ^. templateFolder)
    _serverConfigGeneralRemoteLocalizationUrl <-
      o .:? "remoteLocalizationUrl" .!= (defaultGeneral ^. remoteLocalizationUrl)
    return ServerConfigGeneral {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigDatabase where
  parseJSON (Object o) = do
    _serverConfigDatabaseHost <- o .:? "host" .!= (defaultDatabase ^. host)
    _serverConfigDatabaseDatabaseName <- o .:? "databaseName" .!= (defaultDatabase ^. databaseName)
    _serverConfigDatabasePort <- o .:? "port" .!= (defaultDatabase ^. port)
    _serverConfigDatabaseAuthEnabled <- o .:? "authEnabled" .!= (defaultDatabase ^. authEnabled)
    _serverConfigDatabaseUsername <- o .:? "username" .!= (defaultDatabase ^. username)
    _serverConfigDatabasePassword <- o .:? "password" .!= (defaultDatabase ^. password)
    return ServerConfigDatabase {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigMessaging where
  parseJSON (Object o) = do
    _serverConfigMessagingEnabled <- o .:? "enabled" .!= (defaultMessaging ^. enabled)
    _serverConfigMessagingHost <- o .:? "host" .!= (defaultMessaging ^. host)
    _serverConfigMessagingPort <- o .:? "port" .!= (defaultMessaging ^. port)
    _serverConfigMessagingUsername <- o .:? "username" .!= (defaultMessaging ^. username)
    _serverConfigMessagingPassword <- o .:? "password" .!= (defaultMessaging ^. password)
    _serverConfigMessagingVhost <- o .:? "vhost" .!= (defaultMessaging ^. vhost)
    return ServerConfigMessaging {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigJwt where
  parseJSON (Object o) = do
    _serverConfigJwtSecret <- o .: "secret"
    _serverConfigJwtVersion <- o .:? "version" .!= (defaultJwt ^. version)
    _serverConfigJwtExpiration <- o .:? "expiration" .!= (defaultJwt ^. expiration)
    return ServerConfigJwt {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigRoles where
  parseJSON (Object o) = do
    _serverConfigRolesDefaultRole <- o .:? "defaultRole" .!= (defaultRoles ^. defaultRole)
    _serverConfigRolesAdmin <- o .:? "admin" .!= (defaultRoles ^. admin)
    _serverConfigRolesDataSteward <- o .:? "dataSteward" .!= (defaultRoles ^. dataSteward)
    _serverConfigRolesResearcher <- o .:? "researcher" .!= (defaultRoles ^. researcher)
    return ServerConfigRoles {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigMail where
  parseJSON (Object o) = do
    _serverConfigMailEnabled <- o .:? "enabled" .!= (defaultMail ^. enabled)
    _serverConfigMailName <- o .:? "name" .!= (defaultMail ^. name)
    _serverConfigMailEmail <- o .: "email" .!= (defaultMail ^. email)
    _serverConfigMailHost <- o .: "host" .!= (defaultMail ^. host)
    _serverConfigMailPort <- o .:? "port" .!= (defaultMail ^. port)
    _serverConfigMailSsl <- o .:? "ssl" .!= (defaultMail ^. ssl)
    _serverConfigMailAuthEnabled <- o .:? "authEnabled" .!= (defaultMail ^. authEnabled)
    _serverConfigMailUsername <- o .:? "username" .!= (defaultMail ^. username)
    _serverConfigMailPassword <- o .:? "password" .!= (defaultMail ^. password)
    return ServerConfigMail {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigRegistry where
  parseJSON (Object o) = do
    _serverConfigRegistryEnabled <- o .:? "enabled" .!= (defaultRegistry ^. enabled)
    _serverConfigRegistryUrl <- o .:? "url" .!= (defaultRegistry ^. url)
    _serverConfigRegistryToken <- o .:? "token" .!= (defaultRegistry ^. token)
    _serverConfigRegistryClientUrl <- o .:? "clientUrl" .!= (defaultRegistry ^. clientUrl)
    return ServerConfigRegistry {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigAnalytics where
  parseJSON (Object o) = do
    _serverConfigAnalyticsEnabled <- o .:? "enabled" .!= (defaultAnalytics ^. enabled)
    _serverConfigAnalyticsEmail <- o .:? "email" .!= (defaultAnalytics ^. email)
    return ServerConfigAnalytics {..}
  parseJSON _ = mzero

instance FromJSON ServerConfigFeedback where
  parseJSON (Object o) = do
    _serverConfigFeedbackEnabled <- o .:? "enabled" .!= (defaultFeedback ^. enabled)
    _serverConfigFeedbackToken <- o .:? "token" .!= (defaultFeedback ^. token)
    _serverConfigFeedbackOwner <- o .:? "owner" .!= (defaultFeedback ^. owner)
    _serverConfigFeedbackRepo <- o .:? "repo" .!= (defaultFeedback ^. repo)
    _serverConfigFeedbackApiUrl <- o .:? "apiUrl" .!= (defaultFeedback ^. apiUrl)
    _serverConfigFeedbackWebUrl <- o .:? "webUrl" .!= (defaultFeedback ^. webUrl)
    return ServerConfigFeedback {..}
  parseJSON _ = mzero