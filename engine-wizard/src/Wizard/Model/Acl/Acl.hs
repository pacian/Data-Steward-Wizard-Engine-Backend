module Wizard.Model.Acl.Acl where

import qualified Data.UUID as U
import GHC.Generics

data Group =
  Group
    { _groupGId :: String
    , _groupName :: String
    , _groupDescription :: String
    }
  deriving (Generic, Eq, Show)

data GroupMembership =
  GroupMembership
    { _groupMembershipGroupId :: String
    , _groupMembershipGType :: GroupMembershipType
    }
  deriving (Generic, Eq, Show)

data GroupMembershipType
  = OwnerGroupMembershipType
  | MemberGroupMembershipType
  deriving (Generic, Eq, Show, Read)

data Member
  = GroupMember
      { _groupMemberGId :: String
      }
  | UserMember
      { _userMemberUuid :: U.UUID
      }
  deriving (Generic, Eq, Show)

_ADMIN_PERM :: String
_ADMIN_PERM = "ADMIN"

_EDIT_PERM :: String
_EDIT_PERM = "EDIT"

_VIEW_PERM :: String
_VIEW_PERM = "VIEW"
