module Specs.API.Package.List_DELETE
  ( list_delete
  ) where

import Control.Lens ((^.))
import Data.Aeson (encode)
import Data.Either
import Network.HTTP.Types
import Network.Wai (Application)
import Test.Hspec
import Test.Hspec.Wai hiding (shouldRespondWith)
import Test.Hspec.Wai.Matcher

import Api.Resource.Error.ErrorDTO ()
import Database.DAO.Branch.BranchDAO
import Database.DAO.Package.PackageDAO
import qualified
       Database.Migration.Development.Branch.BranchMigration as B
import Database.Migration.Development.Package.Data.Packages
import qualified
       Database.Migration.Development.Package.PackageMigration as PKG
import LensesConfig
import Localization
import Model.Context.AppContext
import Model.Error.ErrorHelpers

import Specs.API.Common
import Specs.Common

-- ------------------------------------------------------------------------
-- GET /packages
-- ------------------------------------------------------------------------
list_delete :: AppContext -> SpecWith Application
list_delete appContext =
  describe "DELETE /packages" $ do
    test_204 appContext
    test_400 appContext
    test_401 appContext
    test_403 appContext

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
reqMethod = methodDelete

reqUrl = "/packages"

reqHeaders = [reqAuthHeader, reqCtHeader]

reqBody = ""

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_204 appContext = do
  it "HTTP 200 NO CONTENT" $
     -- GIVEN: Prepare expectation
   do
    let expStatus = 204
    let expHeaders = resCorsHeaders
    let expBody = ""
     -- AND: Run migrations
    runInContextIO PKG.runMigration appContext
    runInContextIO deleteBranches appContext
     -- WHEN: Call API
    response <- request reqMethod reqUrl reqHeaders reqBody
    -- THEN: Find a result
    eitherPackages <- runInContextIO findPackages appContext
     -- AND: Compare response with expetation
    let responseMatcher =
          ResponseMatcher {matchHeaders = expHeaders, matchStatus = expStatus, matchBody = bodyEquals expBody}
    response `shouldRespondWith` responseMatcher
      -- AND: Compare state in DB with expetation
    liftIO $ (isRight eitherPackages) `shouldBe` True
    let (Right packages) = eitherPackages
    liftIO $ packages `shouldBe` []

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_400 appContext = do
  it "HTTP 400 BAD REQUEST when package can't be deleted" $
    -- GIVEN: Prepare expectation
   do
    let expStatus = 400
    let expHeaders = resCorsHeaders
    let expDto =
          createErrorWithErrorMessage $
          _ERROR_SERVICE_PKG__PKG_CANT_BE_DELETED_BECAUSE_IT_IS_USED_BY_SOME_OTHER_ENTITY
            "elixir.nl:core-nl:1.0.0"
            "knowledge model"
    let expBody = encode expDto
    -- AND: Run migrations
    runInContextIO PKG.runMigration appContext
    runInContextIO B.runMigration appContext
    -- WHEN: Call API
    response <- request reqMethod reqUrl reqHeaders reqBody
    -- THEN: Find a result
    eitherPackages <- runInContextIO findPackageWithEvents appContext
    -- AND: Compare response with expetation
    let responseMatcher =
          ResponseMatcher {matchHeaders = expHeaders, matchStatus = expStatus, matchBody = bodyEquals expBody}
    response `shouldRespondWith` responseMatcher
    -- AND: Compare state in DB with expetation
    liftIO $ (isRight eitherPackages) `shouldBe` True
    let (Right packages) = eitherPackages
    liftIO $ packages `shouldBe` [baseElixir0PackageDto, baseElixirPackageDto, elixirNlPackageDto, elixirNlPackage2Dto]

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_401 appContext = createAuthTest reqMethod reqUrl [] reqBody

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------
test_403 appContext = createNoPermissionTest (appContext ^. config) reqMethod reqUrl [] reqBody "PM_WRITE_PERM"
