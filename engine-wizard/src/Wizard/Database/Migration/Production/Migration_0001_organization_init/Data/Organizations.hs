module Wizard.Database.Migration.Production.Migration_0001_organization_init.Data.Organizations where

import qualified Data.Bson as BSON

organization now =
  [ "uuid" BSON.=: "6c9913de-b739-451b-a176-70af1581234d"
  , "name" BSON.=: "Organization"
  , "organizationId" BSON.=: "global"
  , "createdAt" BSON.=: now
  , "updatedAt" BSON.=: now
  ]
