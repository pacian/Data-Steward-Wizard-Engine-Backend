module Wizard.Service.Document.DocumentAcl where

import Control.Lens ((^.))

import LensesConfig
import Wizard.Database.DAO.Questionnaire.QuestionnaireDAO
import Wizard.Model.Context.AppContext
import Wizard.Service.Questionnaire.QuestionnaireAcl

checkViewPermissionToDoc :: String -> AppContextM ()
checkViewPermissionToDoc qtnUuid = do
  qtn <- findQuestionnaireById qtnUuid
  checkViewPermissionToQtn (qtn ^. visibility) (qtn ^. sharing) (qtn ^. permissions)

checkEditPermissionToDoc :: String -> AppContextM ()
checkEditPermissionToDoc qtnUuid = do
  qtn <- findQuestionnaireById qtnUuid
  checkEditPermissionToQtn (qtn ^. visibility) (qtn ^. sharing) (qtn ^. permissions)
