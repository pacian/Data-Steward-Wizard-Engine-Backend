module Wizard.Database.Migration.Development.Migration.KnowledgeModel.Data.Migrations where

import Control.Lens ((^.))

import LensesConfig
import Shared.Database.Migration.Development.Event.Data.Events
import Shared.Database.Migration.Development.KnowledgeModel.Data.KnowledgeModels
import Shared.Database.Migration.Development.Package.Data.Packages
import Wizard.Api.Resource.Migration.KnowledgeModel.MigrationStateDTO
import Wizard.Api.Resource.Migration.KnowledgeModel.MigratorConflictDTO
import Wizard.Api.Resource.Migration.KnowledgeModel.MigratorStateCreateDTO
import Wizard.Api.Resource.Migration.KnowledgeModel.MigratorStateDTO
import Wizard.Database.Migration.Development.Branch.Data.Branches
import Wizard.Model.Migration.KnowledgeModel.MigratorState

migratorState :: MigratorStateDTO
migratorState =
  MigratorStateDTO
    { _uuid = amsterdamBranch ^. uuid
    , _migrationState =
        ConflictStateDTO . CorrectorConflictDTO . Prelude.head $ netherlandsPackageV2 ^. events
    , _previousPackageId = netherlandsPackage ^. pId
    , _targetPackageId = netherlandsPackageV2 ^. pId
    , _currentKnowledgeModel = Just km1Netherlands
    }

migratorStateCreate :: MigratorStateCreateDTO
migratorStateCreate = MigratorStateCreateDTO {_targetPackageId = netherlandsPackageV2 ^. pId}

migratorConflict :: MigratorConflictDTO
migratorConflict =
  MigratorConflictDTO
    { _originalEventUuid = a_km1_ch4 ^. uuid
    , _action = MCAEdited
    , _event = Just . Prelude.head $ netherlandsPackageV2 ^. events
    }
