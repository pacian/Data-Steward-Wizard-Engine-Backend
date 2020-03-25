module Wizard.Api.Handler.Config.List_Affiliation_PUT where

import Servant

import Shared.Api.Handler.Common
import Wizard.Api.Handler.Common
import Wizard.Api.Resource.Config.AppConfigDTO
import Wizard.Api.Resource.Config.AppConfigJM ()
import Wizard.Model.Context.BaseContext
import Wizard.Service.Config.AppConfigService

type List_Affiliation_PUT
   = Header "Authorization" String
     :> ReqBody '[ SafeJSON] AppConfigAffiliationDTO
     :> "configs"
     :> "affiliation"
     :> Put '[ SafeJSON] (Headers '[ Header "x-trace-uuid" String] AppConfigAffiliationDTO)

list_affiliation_PUT ::
     Maybe String
  -> AppConfigAffiliationDTO
  -> BaseContextM (Headers '[ Header "x-trace-uuid" String] AppConfigAffiliationDTO)
list_affiliation_PUT mTokenHeader reqDto =
  getAuthServiceExecutor mTokenHeader $ \runInAuthService ->
    runInAuthService $
    addTraceUuidHeader =<< do
      checkPermission mTokenHeader "CFG_PERM"
      modifyAppConfigAffiliation reqDto