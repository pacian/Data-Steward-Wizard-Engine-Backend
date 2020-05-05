module Wizard.Api.Resource.Migration.KnowledgeModel.MigratorStateDetailDTO where

import qualified Data.UUID as U
import GHC.Generics

import Shared.Model.Event.Event
import Shared.Model.KnowledgeModel.KnowledgeModel
import Wizard.Api.Resource.Migration.KnowledgeModel.MigrationStateDTO

data MigratorStateDetailDTO =
  MigratorStateDetailDTO
    { _branchUuid :: U.UUID
    , _metamodelVersion :: Int
    , _migrationState :: MigrationStateDTO
    , _branchPreviousPackageId :: String
    , _targetPackageId :: String
    , _branchEvents :: [Event]
    , _targetPackageEvents :: [Event]
    , _resultEvents :: [Event]
    , _currentKnowledgeModel :: Maybe KnowledgeModel
    }
  deriving (Show, Eq, Generic)
