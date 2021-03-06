module Wizard.Service.Package.PackageMapper where

import Control.Lens ((^.), (^..))
import qualified Data.List as L

import LensesConfig
import qualified Registry.Api.Resource.Package.PackageSimpleDTO as R_PackageSimpleDTO
import Shared.Api.Resource.Organization.OrganizationSimpleDTO
import Shared.Api.Resource.Package.PackageDTO
import Shared.Model.Package.Package
import Shared.Model.Package.PackageGroup
import Shared.Model.Package.PackageWithEvents
import Shared.Util.Coordinate
import Wizard.Api.Resource.Package.PackageDetailDTO
import Wizard.Api.Resource.Package.PackageSimpleDTO
import Wizard.Service.Package.PackageUtil

toSimpleDTO :: Package -> PackageSimpleDTO
toSimpleDTO = toSimpleDTO' [] [] []

toSimpleDTO' ::
     [R_PackageSimpleDTO.PackageSimpleDTO] -> [OrganizationSimpleDTO] -> [String] -> Package -> PackageSimpleDTO
toSimpleDTO' pkgRs orgRs localVersions pkg =
  PackageSimpleDTO
    { _packageSimpleDTOPId = pkg ^. pId
    , _packageSimpleDTOName = pkg ^. name
    , _packageSimpleDTOOrganizationId = pkg ^. organizationId
    , _packageSimpleDTOKmId = pkg ^. kmId
    , _packageSimpleDTOVersion = pkg ^. version
    , _packageSimpleDTOVersions = L.sortBy compareVersion localVersions
    , _packageSimpleDTODescription = pkg ^. description
    , _packageSimpleDTOState = computePackageState pkgRs pkg
    , _packageSimpleDTOOrganization = selectOrganizationByOrgId pkg orgRs
    , _packageSimpleDTOCreatedAt = pkg ^. createdAt
    }

toSimpleDTO'' :: [R_PackageSimpleDTO.PackageSimpleDTO] -> [OrganizationSimpleDTO] -> PackageGroup -> PackageSimpleDTO
toSimpleDTO'' pkgRs orgRs pkgGroup =
  let newest = L.maximumBy (\p1 p2 -> compareVersion (p1 ^. version) (p2 ^. version)) (pkgGroup ^. versions)
   in toSimpleDTO' pkgRs orgRs (pkgGroup ^. versions ^.. traverse . version) newest

toDetailDTO ::
     Package
  -> [R_PackageSimpleDTO.PackageSimpleDTO]
  -> [OrganizationSimpleDTO]
  -> [String]
  -> String
  -> PackageDetailDTO
toDetailDTO pkg pkgRs orgRs versionLs registryLink =
  PackageDetailDTO
    { _packageDetailDTOPId = pkg ^. pId
    , _packageDetailDTOName = pkg ^. name
    , _packageDetailDTOOrganizationId = pkg ^. organizationId
    , _packageDetailDTOKmId = pkg ^. kmId
    , _packageDetailDTOVersion = pkg ^. version
    , _packageDetailDTODescription = pkg ^. description
    , _packageDetailDTOReadme = pkg ^. readme
    , _packageDetailDTOLicense = pkg ^. license
    , _packageDetailDTOMetamodelVersion = pkg ^. metamodelVersion
    , _packageDetailDTOPreviousPackageId = pkg ^. previousPackageId
    , _packageDetailDTOForkOfPackageId = pkg ^. forkOfPackageId
    , _packageDetailDTOMergeCheckpointPackageId = pkg ^. mergeCheckpointPackageId
    , _packageDetailDTOVersions = versionLs
    , _packageDetailDTORemoteLatestVersion =
        case selectPackageByOrgIdAndKmId pkg pkgRs of
          Just pkgR -> Just $ pkgR ^. version
          Nothing -> Nothing
    , _packageDetailDTOState = computePackageState pkgRs pkg
    , _packageDetailDTORegistryLink =
        case selectPackageByOrgIdAndKmId pkg pkgRs of
          Just pkgR -> Just registryLink
          Nothing -> Nothing
    , _packageDetailDTOOrganization = selectOrganizationByOrgId pkg orgRs
    , _packageDetailDTOCreatedAt = pkg ^. createdAt
    }

fromDTO :: PackageDTO -> PackageWithEvents
fromDTO dto =
  PackageWithEvents
    { _packageWithEventsPId = dto ^. pId
    , _packageWithEventsName = dto ^. name
    , _packageWithEventsOrganizationId = dto ^. organizationId
    , _packageWithEventsKmId = dto ^. kmId
    , _packageWithEventsVersion = dto ^. version
    , _packageWithEventsMetamodelVersion = dto ^. metamodelVersion
    , _packageWithEventsDescription = dto ^. description
    , _packageWithEventsReadme = dto ^. readme
    , _packageWithEventsLicense = dto ^. license
    , _packageWithEventsPreviousPackageId = dto ^. previousPackageId
    , _packageWithEventsForkOfPackageId = dto ^. forkOfPackageId
    , _packageWithEventsMergeCheckpointPackageId = dto ^. mergeCheckpointPackageId
    , _packageWithEventsEvents = dto ^. events
    , _packageWithEventsCreatedAt = dto ^. createdAt
    }

buildPackageUrl :: String -> String -> String
buildPackageUrl clientRegistryUrl pkgId = clientRegistryUrl ++ "/knowledge-models/" ++ pkgId
