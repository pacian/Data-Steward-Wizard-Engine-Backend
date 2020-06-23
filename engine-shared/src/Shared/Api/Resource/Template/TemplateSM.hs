module Shared.Api.Resource.Template.TemplateSM where

import Data.Swagger

import Shared.Database.Migration.Development.Template.Data.Templates
import Shared.Model.Template.Template
import Shared.Model.Template.TemplateJM ()
import Shared.Util.Swagger

instance ToSchema Template where
  declareNamedSchema = simpleToSchema' "_template" commonWizardTemplate

instance ToSchema TemplateAllowedPackage where
  declareNamedSchema = simpleToSchema' "_templateAllowedPackage" templateAllowedPackage

instance ToSchema TemplateFormat where
  declareNamedSchema = simpleToSchema' "_templateFormat" templateFormatJson

instance ToSchema TemplateFormatStep where
  declareNamedSchema = simpleToSchema' "_templateFormatStep" templateFormatJsonStep

instance ToSchema TemplateFile where
  declareNamedSchema = simpleToSchema' "_templateFile" templateFileDefaultHtml

instance ToSchema TemplateAsset where
  declareNamedSchema = simpleToSchema' "_templateAsset" templateAssetLogo