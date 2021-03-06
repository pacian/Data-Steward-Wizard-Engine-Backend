module Shared.Localization.Locale where

import qualified Data.Map.Strict as M

import Shared.Model.Localization.LocaleRecord
import Shared.Util.String (f')

locale :: M.Map String String -> LocaleRecord -> String
locale ls (LocaleRecord key defaultValue variables) =
  case M.lookup key ls of
    Just value -> f' value variables
    Nothing -> f' defaultValue variables
