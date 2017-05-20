module Update exposing (..)

import Model exposing (..)
import Material
import List.Extra exposing (filterNot, updateIf, remove)


type Msg
    = ToggleUserGroup String String
    | CreateUser
    | CreateGroup
    | DeleteUser String
    | DeleteGroup String
    | NewUsername String
    | NewGroupname String
    | SelectUser String
    | SelectGroup String
    | Mdl (Material.Msg Msg)
    | SelectTab Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        CreateUser ->
            ( { model | users = { name = model.newUsername, groups = [] } :: model.users, newUsername = "" }, Cmd.none )

        DeleteUser username ->
            ( { model
                | users = removeByName username model.users
                , groups = removeUserFromGroups username model.groups
              }
            , Cmd.none
            )

        DeleteGroup groupname ->
            ( { model | groups = removeByName groupname model.groups }, Cmd.none )

        CreateGroup ->
            ( { model | groups = { name = model.newGroupname, users = [] } :: model.groups, newGroupname = "" }, Cmd.none )

        NewUsername username ->
            ( { model | newUsername = username }, Cmd.none )

        NewGroupname groupname ->
            ( { model | newGroupname = groupname }, Cmd.none )

        SelectTab idx ->
            ( { model | tab = idx }, Cmd.none )

        SelectUser user ->
            ( { model | selectedUser = user }, Cmd.none )

        SelectGroup group ->
            ( { model | selectedGroup = group }, Cmd.none )

        ToggleUserGroup username groupname ->
            ( { model
                | users = updateIf (nameEquals username) (toggleGroupInUser username groupname) model.users
                , groups = updateIf (nameEquals groupname) (toggleUserInGroup username groupname) model.groups
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


nameEquals : String -> Named a -> Bool
nameEquals name =
    .name >> (==) name


removeByName : String -> List (Named a) -> List (Named a)
removeByName name =
    filterNot (nameEquals name)


removeUserFromGroup : String -> Group -> Group
removeUserFromGroup username group =
    { group | users = (remove username group.users) }


removeUserFromGroups : String -> List Group -> List Group
removeUserFromGroups username groups =
    List.map (removeUserFromGroup username) groups


toggleGroupInUser : String -> String -> User -> User
toggleGroupInUser username groupname user =
    if List.member groupname user.groups then
        { user | groups = remove groupname user.groups }
    else
        { user | groups = groupname :: user.groups }


toggleUserInGroup : String -> String -> Group -> Group
toggleUserInGroup username groupname group =
    if List.member username group.users then
        { group | users = remove username group.users }
    else
        { group | users = username :: group.users }
