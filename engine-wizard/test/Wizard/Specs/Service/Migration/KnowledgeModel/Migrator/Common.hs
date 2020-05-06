module Wizard.Specs.Service.Migration.KnowledgeModel.Migrator.Common where

import Data.Maybe
import qualified Data.UUID as U

import Shared.Constant.KnowledgeModel
import Shared.Model.Event.Event
import Shared.Model.KnowledgeModel.KnowledgeModel
import Wizard.Model.Migration.KnowledgeModel.MigratorState

createTestMigratorStateWithEvents :: [Event] -> [Event] -> Maybe KnowledgeModel -> MigratorState
createTestMigratorStateWithEvents branchEvents targetPackageEvents mKm =
  MigratorState
    { _branchUuid = fromJust . U.fromString $ "09080ce7-f513-4493-9583-dce567b8e9c5"
    , _metamodelVersion = kmMetamodelVersion
    , _migrationState = RunningState
    , _branchPreviousPackageId = "b"
    , _targetPackageId = "t"
    , _branchEvents = branchEvents
    , _targetPackageEvents = targetPackageEvents
    , _resultEvents = []
    , _currentKnowledgeModel = mKm
    }
