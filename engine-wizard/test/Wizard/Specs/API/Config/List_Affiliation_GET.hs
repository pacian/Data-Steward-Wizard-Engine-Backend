module Wizard.Specs.API.Config.List_Affiliation_GET
  ( list_affiliation_GET
  ) where

import Control.Lens ((^.))
import Data.Aeson (encode)
import Network.HTTP.Types
import Network.Wai (Application)
import Test.Hspec
import Test.Hspec.Wai hiding (shouldRespondWith)
import Test.Hspec.Wai.Matcher

import LensesConfig
import Wizard.Database.Migration.Development.Config.Data.AppConfigs
import Wizard.Model.Context.AppContext
import Wizard.Service.Config.AppConfigMapper

import Wizard.Specs.API.Common

-- ------------------------------------------------------------------------
-- GET /configs/affiliation
-- ------------------------------------------------------------------------
list_affiliation_GET :: AppContext -> SpecWith Application
list_affiliation_GET appContext =
  describe "GET /configs/affiliation" $ do
    test_200 appContext
    test_401 appContext
    test_403 appContext

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
reqMethod = methodGet

reqUrl = "/configs/affiliation"

reqHeaders = [reqAuthHeader]

reqBody = ""

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_200 appContext =
  it "HTTP 200 OK" $
     -- GIVEN: Prepare expectation
   do
    let expStatus = 200
    let expHeaders = resCtHeader : resCorsHeaders
    let expDto = toAffiliationDTO defaultAffiliation
    let expBody = encode expDto
     -- WHEN: Call API
    response <- request reqMethod reqUrl reqHeaders reqBody
     -- THEN: Compare response with expectation
    let responseMatcher =
          ResponseMatcher {matchHeaders = expHeaders, matchStatus = expStatus, matchBody = bodyEquals expBody}
    response `shouldRespondWith` responseMatcher

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_401 appContext = createAuthTest reqMethod reqUrl [reqCtHeader] reqBody

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_403 appContext =
  createNoPermissionTest (appContext ^. applicationConfig) reqMethod reqUrl [reqCtHeader] reqBody "CFG_PERM"