module Wizard.Database.Migration.Development.Document.Data.Documents where

import Control.Lens ((^.))
import qualified Data.ByteString.Char8 as BS
import Data.Hashable
import Data.Maybe
import Data.Time
import qualified Data.UUID as U

import LensesConfig hiding (hash)
import Shared.Database.Migration.Development.KnowledgeModel.Data.KnowledgeModels
import Shared.Database.Migration.Development.Metric.Data.Metrics
import Wizard.Database.Migration.Development.Level.Data.Levels
import Wizard.Database.Migration.Development.Organization.Data.Organizations
import Wizard.Database.Migration.Development.Package.Data.Packages
import Wizard.Database.Migration.Development.Questionnaire.Data.Questionnaires
import Wizard.Database.Migration.Development.Report.Data.Reports
import Wizard.Database.Migration.Development.Template.Data.Templates
import Wizard.Database.Migration.Development.User.Data.Users
import Wizard.Model.Document.Document
import Wizard.Model.Document.DocumentContext
import Wizard.Service.Package.PackageMapper

doc1 :: Document
doc1 =
  Document
    { _documentUuid = fromJust (U.fromString "264ca352-1a99-4ffd-860e-32aee9a98428")
    , _documentName = "My exported document"
    , _documentState = DoneDocumentState
    , _documentDurability = PersistentDocumentDurability
    , _documentQuestionnaireUuid = questionnaire1 ^. uuid
    , _documentQuestionnaireRepliesHash = hash (questionnaire1 ^. replies)
    , _documentTemplateUuid = commonWizardTemplate ^. uuid
    , _documentFormatUuid = head (commonWizardTemplate ^. formats) ^. uuid
    , _documentMetadata =
        DocumentMetadata
          {_documentMetadataFileName = Just "export.txt", _documentMetadataContentType = Just "text/plain"}
    , _documentOwnerUuid = userNikola ^. uuid
    , _documentCreatedAt = UTCTime (fromJust $ fromGregorianValid 2018 1 20) 0
    }

doc1Content :: BS.ByteString
doc1Content =
  BS.pack $
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor pellentesque velit, sollicitudin euismod " ++
  "arcu varius a. Pellentesque consectetur a felis nec finibus. Curabitur at porttitor turpis. Vivamus eu imperdiet " ++
  "massa. Fusce vitae dolor et nulla vulputate condimentum. Aenean tincidunt, magna quis viverra porta, nulla " ++
  "mauris semper nibh, ac interdum quam orci at elit. Donec aliquet tempor erat, sed consectetur sapien eleifend " ++
  "id. Nullam sagittis justo a lobortis fermentum. Nunc pretium sem sed lectus lacinia, et tempus nulla suscipit. " ++
  "Aliquam volutpat molestie nibh sit amet iaculis."

dmp1 :: DocumentContext
dmp1 =
  DocumentContext
    { _documentContextUuid = fromJust (U.fromString "d87941ae-7725-4d22-b5c7-45dabc125199")
    , _documentContextConfig = DocumentContextConfig {_documentContextConfigLevelsEnabled = True}
    , _documentContextQuestionnaireUuid = U.toString $ questionnaire1 ^. uuid
    , _documentContextQuestionnaireName = questionnaire1 ^. name
    , _documentContextQuestionnaireReplies = questionnaire1 ^. replies
    , _documentContextLevel = questionnaire1 ^. level
    , _documentContextKnowledgeModel = km1WithQ4
    , _documentContextMetrics = [metricF, metricA, metricI, metricR, metricG, metricO]
    , _documentContextLevels = [level1, level2, level3]
    , _documentContextReport = report1
    , _documentContextPackage = toPackage germanyPackage
    , _documentContextOrganization = org1
    , _documentContextCreatedBy = Just userAlbert
    , _documentContextCreatedAt = UTCTime (fromJust $ fromGregorianValid 2018 1 20) 0
    , _documentContextUpdatedAt = UTCTime (fromJust $ fromGregorianValid 2018 1 25) 0
    }

doc2 :: Document
doc2 =
  Document
    { _documentUuid = fromJust (U.fromString "12de4935-58ad-4a34-9d91-dd0e16619b35")
    , _documentName = "My exported document 2"
    , _documentState = DoneDocumentState
    , _documentDurability = PersistentDocumentDurability
    , _documentQuestionnaireUuid = questionnaire2 ^. uuid
    , _documentQuestionnaireRepliesHash = hash (questionnaire2 ^. replies)
    , _documentTemplateUuid = commonWizardTemplate ^. uuid
    , _documentFormatUuid = head (commonWizardTemplate ^. formats) ^. uuid
    , _documentMetadata =
        DocumentMetadata
          {_documentMetadataFileName = Just "export.txt", _documentMetadataContentType = Just "text/plain"}
    , _documentOwnerUuid = userNikola ^. uuid
    , _documentCreatedAt = UTCTime (fromJust $ fromGregorianValid 2018 1 20) 0
    }

doc3 :: Document
doc3 =
  Document
    { _documentUuid = fromJust (U.fromString "35ef63fd-cb5c-448c-9a4f-54b572573c20")
    , _documentName = "My exported document 3"
    , _documentState = DoneDocumentState
    , _documentDurability = PersistentDocumentDurability
    , _documentQuestionnaireUuid = questionnaire2 ^. uuid
    , _documentQuestionnaireRepliesHash = hash (questionnaire2 ^. replies)
    , _documentTemplateUuid = commonWizardTemplate ^. uuid
    , _documentFormatUuid = head (commonWizardTemplate ^. formats) ^. uuid
    , _documentMetadata =
        DocumentMetadata
          {_documentMetadataFileName = Just "export.txt", _documentMetadataContentType = Just "text/plain"}
    , _documentOwnerUuid = userAlbert ^. uuid
    , _documentCreatedAt = UTCTime (fromJust $ fromGregorianValid 2018 1 20) 0
    }

doc4 :: Document
doc4 =
  doc1
    { _documentUuid = fromJust (U.fromString "9e010fc5-d147-4e9a-94a0-5aba40d78b97")
    , _documentName = "My failed document 4"
    , _documentState = ErrorDocumentState
    }

doc5 :: Document
doc5 =
  doc1
    { _documentUuid = fromJust (U.fromString "c3e1a760-0941-499c-a8cd-6b9d78eee0ba")
    , _documentName = "My in progress document 5"
    , _documentState = InProgressDocumentState
    }

doc6 :: Document
doc6 =
  doc1
    { _documentUuid = fromJust (U.fromString "6a7631bc-af69-4e72-83e4-8440be071005")
    , _documentName = "My queued document 6"
    , _documentState = QueuedDocumentState
    }

tempDocQueued :: Document
tempDocQueued =
  doc1
    { _documentUuid = fromJust (U.fromString "537e2b86-64ec-4ee9-965b-6637775f8f89")
    , _documentName = "My temp docs"
    , _documentState = QueuedDocumentState
    , _documentDurability = TemporallyDocumentDurability
    }

tempDocInProgress :: Document
tempDocInProgress =
  doc1
    { _documentUuid = fromJust (U.fromString "8f075d1e-d7ca-416e-8e17-5dd6d53a01f3")
    , _documentName = "My temp docs"
    , _documentState = InProgressDocumentState
    , _documentDurability = TemporallyDocumentDurability
    }

tempDocDone :: Document
tempDocDone =
  doc1
    { _documentUuid = fromJust (U.fromString "ac38c865-a891-43a7-986b-b6801ed10880")
    , _documentName = "My temp docs"
    , _documentState = DoneDocumentState
    , _documentDurability = TemporallyDocumentDurability
    }

tempDocError :: Document
tempDocError =
  doc1
    { _documentUuid = fromJust (U.fromString "16884341-2771-437d-944f-69bc9572af20")
    , _documentName = "My temp docs"
    , _documentState = ErrorDocumentState
    , _documentDurability = TemporallyDocumentDurability
    }
