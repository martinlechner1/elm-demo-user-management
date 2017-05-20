module Model exposing (..)

import Material


type alias Username =
    String


type alias Groupname =
    String


type alias User =
    { name : Username
    , groups : List Groupname
    }


type alias Group =
    { name : Groupname
    , users : List Username
    }


type alias Named a =
    { a | name : String }


type alias Model =
    { users : List User
    , groups : List Group
    , mdl : Material.Model
    , newUsername : String
    , newGroupname : String
    , selectedUser : String
    , selectedGroup : String
    , tab : Int
    }
